#!/usr/bin/env bash

set -e

# Normalize working directory
cd "$(dirname "$0")"


pushd python
./build.sh
./push.sh
popd

pushd docker
./build.sh
./push.sh
./deploy.sh
popd