#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"


printf 'Setup python...\n'

pushd python
./setup.sh
popd

printf 'SUCCESS\n'


printf 'Checking az login...'

az account show --output none

printf 'SUCCESS\n'


printf 'Setup dev env...'

az keyvault secret show \
  --name "Kismet-Dev-env" \
  --vault-name "Kismet-Dev" \
  --query "value" \
  --output tsv \
  > .env

printf 'SUCCESS\n'


printf 'Setup k8s...\n'

pushd k8s
./setup.sh
popd

printf 'SUCCESS\n'
