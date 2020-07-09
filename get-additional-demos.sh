#!/usr/bin/env bash
USER=${V3IO_USERNAME}
DEST_DIR="/v3io/users/${USER}/demos"
TEMP_DIR="${DEST_DIR}/temp-demos"
GIT_REPO="https://github.com/mlrun/demos"

git clone ${GIT_REPO} --branch master --single-branch --depth 1 ${TEMP_DIR}

echo "Copying files to ${DEST_DIR}..."
mv ${TEMP_DIR}/README.md ${TEMP_DIR}/README-mlrun-demos.md
cp -r ${TEMP_DIR}/* ${DEST_DIR}

echo "Deleting temporary ${TEMP_DIR} directory ..."
rm -rf ${TEMP_DIR}

echo "DONE"
