#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"


printf '# Release python\n'

./python/release.sh


printf '# Release prod\n'

./k8s/release.sh