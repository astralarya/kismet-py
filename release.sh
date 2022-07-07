#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"


printf '# Release python'

./python/release.sh "$1"


printf '# Release prod'

./k8s/release.sh "$1"