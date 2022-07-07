#!/usr/bin/env bash

set -e

# Normalize working directory
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


printf 'Setup prod env...'

az keyvault secret show \
  --name "Kismet-values" \
  --vault-name "Kismet-py" \
  --query "value" \
  --output tsv \
  > k8s/helm/values.yaml

printf 'SUCCESS\n'