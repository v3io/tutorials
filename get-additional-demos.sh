#!/usr/bin/env bash

set -o errexit
set -o pipefail

git_clone_or_pull() {

    REPOSRC="${1}"
    LOCALREPO="${2}"

    LOCALREPO_GIT_DIR="$LOCALREPO/.git"

    echo "Reading $REPOSRC"

    if [ -d "$LOCALREPO_GIT_DIR" ]; then
        git -C "$LOCALREPO" pull origin
    elif [ -d "$LOCALREPO" ]; then
        if [ -z ${3} ]; then
            echo "'${LOCALREPO}' folder exists, but is not a git repository. Aborting." 1>&2
            exit 1
        else
            echo "'${LOCALREPO}' folder exists, but is not a git repository."
            git clone "$REPOSRC" "${3}"
        fi
    else
        git clone "$REPOSRC" "$LOCALREPO"
    fi
}

git_clone_or_pull https://github.com/mlrun/demos.git demos mlrun-demos
