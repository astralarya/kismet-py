#!/usr/bin/env bash

# Normalize working directory
cd "$(dirname "$0")"


helm upgrade --install kismet-py helm/