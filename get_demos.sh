#!/usr/bin/env bash

if [[ "$#" -ne 1 ]]; then
    echo "Usage: $0 username"
    exit 1
fi

USER=$1

git clone https://github.com/v3io/tutorials.git /v3io/users/$USER/tutorials
cd /v3io/users/$USER
cp -rf tutorials/getting-started .
cp -rf tutorials/demos .
cp -rf tutorials/*.ipynb .
cp -rf tutorials/assets .
rm -rf /v3io/users/iguazio/tutorials

