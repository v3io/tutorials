#!/usr/bin/env bash

SCRIPT=${BASH_SOURCE[0]}
PRODUCT="Iguazio Data Science Platform"
GIT_REPO="https://github.com/v3io/tutorials.git"
USER=${V3IO_USERNAME}

USAGE="\
$SCRIPT:
Retrieves latest-release ${PRODUCT} tutorial files from the v3io/tutorials GitHub repo.
USAGE: ${SCRIPT} [<username>]
PARAMETERS:
  <username> - Username, which determines the directory to which to copy the files - /v3io/users/<username>.
               Default = \$V3IO_USERNAME (if set to a non-empty string)
OPTIONS:
  h|--help   -  Display this message and exit."

while :
do
    case $1 in
        -h | --help) echo -e "$USAGE"; exit 0 ;;
        -*) echo "$FUNCNAME: $1: Unknown option"; exit 1 ;;
        *) break;
    esac
    shift
done

if [[ "$#" -eq 1 ]]; then
    USER=${1}
else if [ -z ${USER} ]; then
    echo -e "$USAGE"
    exit 1
fi fi
DEST_DIR="/v3io/users/${USER}"
TEMP_DIR="${DEST_DIR}/temp-igz-tutorials"

# Get updated tutorials
echo "Updating ${PRODUCT} tutorial files in ${DEST_DIR} ..."
git clone ${GIT_REPO} ${TEMP_DIR}
echo "Copying files to ${DEST_DIR}..."
cp -rf ${TEMP_DIR}/getting-started ${DEST_DIR}
cp -rf ${TEMP_DIR}/demos ${DEST_DIR}
cp -rf ${TEMP_DIR}/*.ipynb ${DEST_DIR}
cp -rf ${TEMP_DIR}/assets ${DEST_DIR}
cp -f ${TEMP_DIR}/README.md ${TEMP_DIR}/LICENSE ${DEST_DIR}
echo "Deleting temporary ${DEST_DIR} directory ..."
rm -rf ${TEMP_DIR}
echo "DONE"

