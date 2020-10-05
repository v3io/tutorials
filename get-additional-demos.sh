#!/usr/bin/env bash

set -o errexit
set -o pipefail

git_clone_or_pull() {

    REPOSRC="${1}"
    # Get the string after the last '/'
    LOCALREPO="${REPOSRC##*/}"
    
    # Remove any extensions (e.g., if .git is there)
    LOCALREPO="${LOCALREPO%.*}"

    # We do it this way so that we can abstract if from just git later on
    LOCALREPO_VC_DIR="$LOCALREPO/.git"

    echo "Reading $REPOSRC"

    if [ ! -d $LOCALREPO_VC_DIR ]
    then
        git clone "$REPOSRC" "$LOCALREPO"
    else
        git -C $LOCALREPO pull origin
    fi

}

git_clone_or_pull https://github.com/mlrun/demo-network-operations.git
git_clone_or_pull https://github.com/mlrun/demo-stocks.git
#git_clone_or_pull https://github.com/mlrun/demo-model-deployment-with-streaming.git
