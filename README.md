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

### Discord Bot
```bash
docker run autochthe/kismet.discord
```
#### Self healing runner
Appropriately updates and restarts
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
