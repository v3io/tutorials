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
        echo "MLRun version not found, using 'master' branch"
        branch=master
    else
        echo "Detected MLRun ${pip_mlrun}"
        mlrun_version="${pip_mlrun##Version: }"
        branch=`echo ${mlrun_version} | cut -d . -f1-2`.x
    fi
fi


git_clone_or_pull() {

    local reposrc="${1}"
    local branch="${2}"
    local localrepo="${3}"

    local localrepo_git_dir="${localrepo}/.git"

    echo "Reading ${reposrc} to '${localrepo}' folder..." 

    if [ -d "${localrepo_git_dir}" ]; then
        git -C "${localrepo}" fetch origin "${branch}"
        
        local exists=$(git -C ${localrepo} show-ref refs/heads/${branch} )
        if [ -z "${exists}" ]; then
            git -C "${localrepo}" checkout -b "${branch}"
        else
            git -C "${localrepo}" checkout "${branch}"
        fi
        
        git -C "${localrepo}" merge origin/"${branch}"
    elif [ -d "${localrepo}" ]; then
        if [ -z ${4} ]; then
            echo "'${localrepo}' folder exists, but is not a git repository. Aborting." 1>&2
            exit 1
        else
            local old_localrepo="${4}"
            echo "'${localrepo}' folder exists, but is not a git repository, moving '${localrepo}' to '${old_localrepo}'."
            if [ -d "${old_localrepo}" ]; then
                echo "'${old_localrepo}' folder already exists. Aborting." 1>&2
                exit 1
            fi
            cp -r "${localrepo}" "${old_localrepo}"
            rm -r "${localrepo}"
            git clone "${reposrc}" -b "${branch}" "${localrepo}"
        fi
    else
        git clone "${reposrc}" -b "${branch}" "${localrepo}"
    fi
}

dest_dir="/v3io/users/${user}"
demos_dir="${dest_dir}/demos"
old_demos_dir="${dest_dir}/demos.old"

git_clone_or_pull "${git_repo}" "${branch}" "${demos_dir}" "${old_demos_dir}"

