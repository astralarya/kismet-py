#!/usr/bin/env bash

cd $(dirname "$0")


# Check dependencies
DEPENDENCIES=(twine)
MISSING=()
echo 'Checking app requirements:'
for package in "${DEPENDENCIES[@]}"
do printf ' %s...' "$package"
    if ! command -v "$package"
    then echo 'MISSING'
        MISSING+=("$package")
    fi
done
if [ ${#MISSING[@]} -gt 0 ]
then echo 'Install the following dependencies before proceeding:'
    printf ' %s\n' "${MISSING[@]}"
    exit 1
fi

twine upload dist/*