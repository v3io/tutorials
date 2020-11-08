#!/usr/bin/env bash

set -o errexit
set -o pipefail

SCRIPT=${BASH_SOURCE[0]##*/}
product="Iguazio Data Science Platform"
git_repo="https://github.com/mlrun/demos.git"
user=${V3IO_USERNAME}

USAGE="\
$SCRIPT:
Retrieves latest-release demos from the mlrun/demos GitHub repo.
USAGE: ${SCRIPT} [-b branch/tag] [-u username]
OPTIONS:
  -h|--help   -  Display this message and exit.
  -b|--branch -  Branch name (default is branch equivalent to the current MLRun version).
  -u|--user   -  Username, which determines the directory to which to copy the files - /v3io/users/<username>.
                 Default = \$V3IO_USERNAME (if set to a non-empty string)."

while :
do
    case $1 in
        -h | --help) echo -e "$USAGE"; exit 0 ;;
        -b|--branch)
            if [ "$2" ]; then
                branch=$2
                shift
            else
                echo "$SCRIPT: $1: missing branch name"; exit 1
            fi
            ;;
        --branch=?*)
            branch=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        --branch=)         # Handle the case of an empty --branch=
            echo "$SCRIPT: $1: missing branch name"; exit 1
            ;;
        -u|--user)
            if [ "$2" ]; then
                user=$2
                shift
            else
                echo "$SCRIPT: $1: missing user name"; exit 1
            fi
            ;;
        --user=?*)
            user=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        --user=)         # Handle the case of an empty --user=
            echo "$SCRIPT: $1: missing user name"; exit 1
            ;;
        -*) echo "$SCRIPT: $1: Unknown option"; exit 1
            ;;
        *) break;
    esac
    shift
done

if [ -z "${user}" ]; then
    echo "Missing user name."
    echo -e "$USAGE"
    exit 1
fi

if [ -z "${branch}" ]; then
    pip_mlrun=$(pip show mlrun | grep Version) || :

    if [ -z "${pip_mlrun}" ]; then
        echo "MLRun version not found. Aborting"
        exit 1
    else
        echo "Detected MLRun ${pip_mlrun}"
        mlrun_version="${pip_mlrun##Version: }"
        tag_prefix=`echo ${mlrun_version} | cut -d . -f1-2`
        latest_tag=`git ls-remote --tags --refs --sort='v:refname' "${git_repo}" "refs/tags/v${tag_prefix}.*" | tail -n1 | awk '{ print $2}'`
        if [ -z "${latest_tag}" ]; then
            echo "No tag found with tag prefix 'v${tag_prefix}.*'. Aborting"
            exit 1
        else
            # Remote the prfix from the tag
            branch=${latest_tag#refs/tags/}
            echo "Detected tag: ${branch}"
        fi
    fi
fi

dest_dir="/v3io/users/${user}"
demos_dir="${dest_dir}/demos"

if [ -d "${demos_dir}" ]; then

    dt=$(date '+%Y%m%d%H%M%S');
    old_demos_dir="${dest_dir}/demos.old/${dt}"

    echo "Moving '${demos_dir}' to ${old_demos_dir}' ..."
    
    mkdir -p "${old_demos_dir}"
    cp -r "${demos_dir}" "${old_demos_dir}"
    rm -r "${demos_dir}"
fi

echo "Updating demos from ${git_repo} branch ${branch} to '${demos_dir}' ..."
git -c advice.detachedHead=false clone "${git_repo}" --branch "${branch}" --single-branch --depth 1 "${demos_dir}"
