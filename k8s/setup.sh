#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"


printf 'Checking az login...'
az account show --output none
printf 'SUCCESS\n'


printf 'Setup prod env...'
az keyvault secret show \
  --name "Kismet-values" \
  --vault-name "Kismet-py" \
  --query "value" \
  --output tsv \
  > helm/values.yaml
printf 'SUCCESS\n'