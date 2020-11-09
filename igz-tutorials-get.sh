#!/usr/bin/env bash

set -o errexit
set -o pipefail

SCRIPT="$(basename $0)"
product="Iguazio Data Science Platform"
git_repo="https://github.com/v3io/tutorials.git"
user=${V3IO_USERNAME}

USAGE="\
$SCRIPT:
Retrieves latest-release ${product} tutorial files from the v3io/tutorials GitHub repo.
USAGE: ${SCRIPT} [OPTIONS] [<username>]
PARAMETERS:
  <username> - Username, which determines the directory to which to copy the files - /v3io/users/<username>.
               Default = \$V3IO_USERNAME (if set to a non-empty string)
OPTIONS:
  -h|--help   -  Display this message and exit.
  -b|--branch -  Branch name (default is latest tag of current platform version).
  --dry-run   -  Do not update the files, but rather show the pending changes."

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
                error_usage "$1: missing branch name"
            fi
            ;;
        --branch=?*)
            branch=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        --branch=)         # Handle the case of an empty --branch=
            error_usage "$1: missing branch name"
            ;;
        --dry-run)
            dry_run=1
            ;;
        -*) error_usage "$1: Unknown option"
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
    echo "Dry run, no files will be copied."
fi


if [ -z "${branch}" ]; then
    platform_version="${IGZ_VERSION%%_*}"
    echo "Detected platform version: ${platform_version}"
    latest_tag=`git ls-remote --tags --refs --sort='v:refname' "${git_repo}" "refs/tags/v${platform_version}.*" | tail -n1 | awk '{ print $2}'`
    if [ -z "${latest_tag}" ]; then
        error_exit "No tag found with tag prefix 'v${platform_version}.*'. Aborting"
    else
        # Remote the prfix from the tag
        branch=${latest_tag#refs/tags/}
        echo "Detected tag: ${branch}"
    fi
fi

dest_dir="/v3io/users/${user}"
temp_dir=$(mktemp -d /tmp/temp-igz-tutorials.XXXXXXXXXX)

trap "{ rm -rf $temp_dir; }" EXIT

# Get updated tutorials
echo "Updating ${product} tutorial files of branch ${branch} in '${dest_dir}'..."
git -c advice.detachedHead=false clone "${git_repo}" --branch "${branch}" --single-branch --depth 1 "${temp_dir}"

shopt -s extglob
if [ -z "${dry_run}" ]; then
    echo "Copying files to '${dest_dir}'..."
    cp -rf "${temp_dir}/"!(igz-tutorials-get.sh|update-tutorials.ipynb) "${dest_dir}"
else
    echo "Files that will be copied to '${dest_dir}':"
    find "${temp_dir}/"!(igz-tutorials-get.sh|update-tutorials.ipynb) -not -path '*/\.*' -type f -printf "%p\n" | sed -e "s|^${temp_dir}/|./|"
fi

echo "Deleting temporary directory '${temp_dir}'..."
rm -rf "${temp_dir}"

echo "DONE"
