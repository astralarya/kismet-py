#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"


printf '# Checking requirements\n'

DEPENDENCIES=(az docker helm python3)
MISSING=()
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


printf '# Setup python\n'

./python/setup.sh


printf '# Setup k8s\n'

./k8s/setup.sh


printf '# Setup dev\n'

printf 'Checking az login...'
az account show --output none
printf 'SUCCESS\n'

printf 'Setup env...'
az keyvault secret show \
  --name "Kismet-Dev-env" \
  --vault-name "Kismet-Dev" \
  --query "value" \
  --output tsv \
  > .env
printf 'SUCCESS\n'