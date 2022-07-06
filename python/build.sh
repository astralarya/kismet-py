#!/usr/bin/env bash

cd $(dirname "$0")


rm -rf dist/ build/ &&
python3 setup.py sdist bdist_wheel