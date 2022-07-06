#!/usr/bin/env bash


docker pull autochthe/kismet.jupyter.vim
docker image prune --force
docker stop kismet.jupyter.vim
docker run -it --rm -p 8888:8888 --name kismet.jupyter.vim autochthe/kismet.jupyter.vim
