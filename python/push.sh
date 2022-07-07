#!/usr/bin/env bash

cd $(dirname "$0")


python3 -m twine upload dist/*