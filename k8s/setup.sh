#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"


printf 'Checking az login...'
az account show --output none
printf 'SUCCESS\n'


printf 'Setup kubectl...'
az aks get-credentials \
  --resource-group Kismet-py \
  --name k8s-kismet-py
printf 'SUCCESS\n'

printf 'Setup prod env...'
az keyvault secret show \
  --name "Kismet-values" \
  --vault-name "Kismet-py" \
  --query "value" \
  --output tsv \
  > helm/values.yaml
printf 'SUCCESS\n'