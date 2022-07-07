#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"


python3 -m bumpversion "$1"


./build.sh
./release.sh