#!/usr/bin/env bash

set -o errexit
set -o pipefail

SCRIPT=${BASH_SOURCE[0]}
PRODUCT="Iguazio Data Science Platform"
GIT_REPO="https://github.com/v3io/tutorials.git"
USER=${V3IO_USERNAME}

USAGE="\
$SCRIPT:
Retrieves latest-release ${PRODUCT} tutorial files from the v3io/tutorials GitHub repo.
USAGE: ${SCRIPT} [-b branch/tag] [<username>]
PARAMETERS:
  <username> - Username, which determines the directory to which to copy the files - /v3io/users/<username>.
               Default = \$V3IO_USERNAME (if set to a non-empty string)
OPTIONS:
  -h|--help   -  Display this message and exit.
  -b|--branch -  Branch name (default is latest tag of current platform version)."


while :
do
    case $1 in
        -h | --help) echo -e "$USAGE"; exit 0 ;;
        -b|--branch)
            if [ "$2" ]; then
                BRANCH=$2
                shift
            else
                echo "$SCRIPT: $1: missing branch name"; exit 1
            fi
            ;;
        --branch=?*)
            BRANCH=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        --branch=)         # Handle the case of an empty --branch=
            echo "$SCRIPT: $1: missing branch name"; exit 1
            ;;
        -*) echo "$SCRIPT: $1: Unknown option"; exit 1
            ;;
        *) break;
    esac
    shift
done

if [[ "$#" -eq 1 ]]; then
    USER=${1}
elif [ -z "${USER}" ]; then
    echo -e "$USAGE"
    exit 1
fi


if [ -z "${BRANCH}" ]; then
    PLATFORM_VERSION="${IGZ_VERSION%%_*}"
    echo "Detected platform version: ${PLATFORM_VERSION}"
    LATEST_TAG=`git ls-remote --tags --refs --sort='v:refname' "${GIT_REPO}" "refs/tags/v${PLATFORM_VERSION}.*" | tail -n1 | awk '{ print $2}'`
    if [ -z "${LATEST_TAG}" ]; then
        echo "No tag found, using master branch"
        BRANCH=master
    else
        # Remote the prfix from the tag
        BRANCH=${LATEST_TAG#refs/tags/}
    fi
fi

DEST_DIR="/v3io/users/${USER}"
TEMP_DIR="${DEST_DIR}/temp-igz-tutorials"

# Get updated tutorials
echo "Updating ${PRODUCT} tutorial files of branch ${BRANCH} in '${DEST_DIR}' ..."
git -c advice.detachedHead=false clone "${GIT_REPO}" --branch "${BRANCH}" --single-branch --depth 1 "${TEMP_DIR}"
echo "Copying files to '${DEST_DIR}'..."
cp -rf ${TEMP_DIR}/data-ingestion-and-preparation ${DEST_DIR}
cp -rf ${TEMP_DIR}/examples ${DEST_DIR}
cp -rf ${TEMP_DIR}/assets ${DEST_DIR}
cp -rf ${TEMP_DIR}/getting-started-tutorial ${DEST_DIR}
cp -f ${TEMP_DIR}/welcome.ipynb \
      ${TEMP_DIR}/platform-overview.ipynb \
      ${TEMP_DIR}/virtual-env.ipynb \
      ${TEMP_DIR}/get-additional-demos.sh \
      ${TEMP_DIR}/README.md \
      ${TEMP_DIR}/LICENSE \
      ${DEST_DIR}
echo "Deleting temporary '${TEMP_DIR}' directory ..."
rm -rf "${TEMP_DIR}"
echo "DONE"

