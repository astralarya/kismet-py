#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"


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