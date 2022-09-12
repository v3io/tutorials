#!/usr/bin/env bash
# Copyright 2018 Iguazio
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -o errexit
set -o pipefail

SCRIPT="$(basename $0)"
product="Iguazio Data Science Platform"
git_owner=v3io
git_repo=tutorials
git_base_url="https://github.com/${git_owner}/${git_repo}" 
git_url="${git_base_url}.git"
user=${V3IO_USERNAME}

USAGE="\
$SCRIPT:
Retrieves updated ${product} tutorial files from the v3io/tutorials GitHub repository.
USAGE: ${SCRIPT} [OPTIONS] [<username>]
PARAMETERS:
  <username> -  Username, which determines the directory to which to copy the
                retrieved files (/v3io/users/<username>).
                Default: \$V3IO_USERNAME, if set to a non-empty string.
OPTIONS:
  -h|--help   -  Display this message and exit.
  -b|--branch -  Git branch name. Default: The latest release branch that
                 matches the current platform version.
  --dry-run   -  Show files to update but don't execute the update."

error_exit()
{

# ----------------------------------------------------------------
# Function for exit due to fatal program error
#   Accepts 1 argument:
#     string containing descriptive error message
# ----------------------------------------------------------------
    echo "${SCRIPT}: ${1:-"Unknown Error"}" 1>&2
    exit 1
}

error_usage()
{
    echo "${1:-"Unknown Error"}" 1>&2
    echo -e "$USAGE"
    exit 1
}

while :
do
    case $1 in
        -h | --help) echo -e "$USAGE"; exit 0 ;;
        -b|--branch)
            if [ "$2" ]; then
                branch=$2
                shift
            else
                error_usage "$1: Missing branch name."
            fi
            ;;
        --branch=?*)
            branch=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        --branch=)         # Handle the case of an empty --branch=
            error_usage "$1: Missing branch name."
            ;;
        --dry-run)
            dry_run=1
            ;;
        -*) error_usage "$1: Unknown option."
            ;;
        *) break;
    esac
    shift
done

if [[ "$#" -eq 1 ]]; then
    user=${1}
elif [ -z "${user}" ]; then
    error_usage "Missing user name."
fi

if [ ! -z "${dry_run}" ]; then
    echo "Dry run; no files will be copied."
fi

if ! (curl -s --connect-timeout 2 github.com &>/dev/null); then
    error_exit "Github is unreachable, Aborting..."
fi

if [ -z "${branch}" ]; then
    platform_version="${IGZ_VERSION%%_*}"
    echo "Detected platform version: ${platform_version}"
    tag_prefix=`echo ${platform_version} | cut -d . -f1-2`
    latest_tag=`git ls-remote --tags --refs --sort='v:refname' "${git_url}" "refs/tags/v${tag_prefix}.*" | tail -n1 | awk '{ print $2}'`
    if [ -z "${latest_tag}" ]; then
        error_exit "Couldn't locate a Git tag with prefix 'v${tag_prefix}.*'. Aborting..."
    else
        # Remove the prefix from the Git tag
        branch=${latest_tag#refs/tags/}
        echo "Detected ${git_url} tag: ${branch}"
    fi
fi

dest_dir="/v3io/users/${user}"
echo "Updating ${product} tutorial files of branch ${branch} to '${dest_dir}'..."

temp_dir=$(mktemp -d /tmp/temp-igz-tutorials.XXXXXXXXXX)
trap "{ rm -rf $temp_dir; }" EXIT
echo "Copying files to a temporary directory '${temp_dir}'..."

# Get updated tutorials
tar_url="${git_base_url}/archive/${branch}.tar.gz"
wget -qO- "${tar_url}" | tar xz -C "${temp_dir}" --strip-components 1

shopt -s extglob
if [ -z "${dry_run}" ]; then
    echo "Copying files to '${dest_dir}'..."
    cp -rf "${temp_dir}/"!(igz-tutorials-get.sh|update-tutorials.ipynb) "${dest_dir}"
else
    # Dry run
    echo "Identified the following files to copy to '${dest_dir}':"
    find "${temp_dir}/"!(igz-tutorials-get.sh|update-tutorials.ipynb) -not -path '*/\.*' -type f -printf "%p\n" | sed -e "s|^${temp_dir}/|./|"
fi

echo "Deleting temporary directory '${temp_dir}'..."
rm -rf "${temp_dir}"

echo "DONE"
