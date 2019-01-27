# Kismet
A dice roll parser with personality

## Installation
```bash
pip install kismet
```

### Jupyter
After installation with `pip`, you may optionally install the Jupyter kernel:
```bash
pythom -m kismet.kernel.install
```

## Docker

### Command Line Interface
```bash
docker run autochthe/kismet
```

### Jupyterlab Server
```bash
docker run -p 8888:8888 autochthe/kismet.jupyter
```
Vim bindings
```bash
docker run -p 8888:8888 autochthe/kismet.jupyter.vim
```
#### Self healing runners
```bash
wget https://raw.githubusercontent.com/autochthe/kismet-py/master/docker/run-kismet.jupyter
chmod a+x run-kismet.jupyter
./run-kismet.jupyter
```
Vim bindings
```bash
wget https://raw.githubusercontent.com/autochthe/kismet-py/master/docker/run-kismet.jupyter.vim
chmod a+x run-kismet.jupyter.vim
./run-kismet.jupyter.vim
```

### Discord Bot
```bash
docker run autochthe/kismet.discord
```
#### Self healing runner
```bash
wget https://raw.githubusercontent.com/autochthe/kismet-py/master/docker/run-kismet.discord
chmod a+x run-kismet.discord

## Edit `run-kismet.discord` and
# ./run-kismet.discord

## OR
# DISCORD_CLIENTID=00000 \
# DISCORD_TOKEN=xxx.xxx \
# ./run-kismet.discord
```
