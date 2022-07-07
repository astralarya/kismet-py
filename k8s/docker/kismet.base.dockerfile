FROM continuumio/miniconda3

RUN conda update --all && \
    conda config --prepend channels intel && \
    conda config --prepend channels pytorch && \
    conda config --append channels conda-forge && \
    conda install \
    # Python 3.7
    python'>=3.8,<3.9' \
    # Dependencies
    aiohttp \
    discord.py \
    ipython'>=7' \
    jupyterlab \
    lark-parser \
    numpy \
    prompt_toolkit \
    pytorch \
    ipython'>=7' \
    && \
    # Clean up
    conda clean --all

COPY python/kismet/__init__.py /app
WORKDIR /app
RUN pip install --no-cache-dir kismet=="$(python -c 'from __init__ import __version__; print(__version__)')"

STOPSIGNAL SIGINT
