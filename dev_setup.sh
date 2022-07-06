#!/usr/bin/env bash

set -e

# Normalize working directory
cd "$(dirname "$0")"


# Setup python package

printf 'Setup python...'

pip3 install --editable .

printf 'SUCCESS\n'

# Login if necessary

printf 'Checking az login...'

az account show --output none

printf 'SUCCESS\n'

# Setup SSH

printf 'Setup SSH...'

az keyvault secret show \
  --name "SSH-key" \
  --vault-name "Kismet-Dev" \
  --query "value" \
  --output tsv \
  > ~/.ssh/kismet_dev.pem

chmod 600 ~/.ssh/kismet_dev.pem

printf 'SUCCESS\n'

# Setup .env

printf 'Setup env...'

az keyvault secret show \
  --name "Kismet-Dev-env" \
  --vault-name "Kismet-Dev" \
  --query "value" \
  --output tsv \
  > .env

printf 'SUCCESS\n'