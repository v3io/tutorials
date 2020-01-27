#!/usr/bin/env bash
USER=${V3IO_USERNAME}
DEST_DIR="/v3io/users/${USER}/demos"
TEMP_DIR="${DEST_DIR}/temp-demos"
GIT_REPO="https://github.com/mlrun/demos"

git clone ${GIT_REPO} ${TEMP_DIR}

echo "Copying files to ${DEST_DIR}..."
cp -rf ${TEMP_DIR}/faces ${DEST_DIR}
cp -rf ${TEMP_DIR}/image-classification ${DEST_DIR}
cp -rf ${TEMP_DIR}/lightgbm ${DEST_DIR}
cp -rf ${TEMP_DIR}/spark ${DEST_DIR}
cp -rf ${TEMP_DIR}/xgboost ${DEST_DIR}
cp -rf ${TEMP_DIR}/netops ${DEST_DIR}
cp -f ${TEMP_DIR}/README.md ${DEST_DIR}/README-MLRUN.md
echo "Deleting temporary ${DEST_DIR} directory ..."
rm -rf ${TEMP_DIR}
echo "DONE"
