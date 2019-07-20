FROM continuumio/miniconda3

RUN conda update --all && \
    conda config --prepend channels intel && \
    conda config --prepend channels pytorch && \
    conda config --append channels conda-forge && \
    conda install \
    # Python 3.7
    python'>=3.7,<3.8' \
    # Dependencies
    aiohttp'>3.5.2,<3.6.0' \
    ipython'>=7' \
    jupyterlab \
    lark-parser \
    numpy \
    prompt_toolkit \
    regex \
    slackclient \
    pytorch \
    ipython'>=7' \
    && \
    # Clean up
    conda clean --all

COPY version.txt /root
RUN pip install --no-cache-dir kismet=="$(cat /root/version.txt)"

STOPSIGNAL SIGINT
