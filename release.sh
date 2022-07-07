#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"


printf '# Release python'

./python/release.sh


printf '# Release prod'

./k8s/release.sh