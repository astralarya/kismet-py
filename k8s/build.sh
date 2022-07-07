#!/usr/bin/env bash

cd "$(dirname "$0")"/docker


docker pull continuumio/miniconda3 &&
docker-compose build