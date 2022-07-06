#!/usr/bin/env bash

set -e

# Normalize working directory
cd "$(dirname "$0")"


# Login if necessary

printf 'Checking login...'

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