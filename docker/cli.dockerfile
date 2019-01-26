FROM continuumio/anaconda

RUN conda update --all && \
    conda config --prepend channels intel && \
    conda config --append channels conda-forge && \
    conda install \
        # Python 3.6
        'python>=3.6<3.7' \
        # Dependencies
        lark-parser \
        numpy \
        prompt_toolkit>=2.0 \
        regex \
        torch \
    && \
    # Install Kismet
    pip install --no-cache-dir kismet && \
    # Clean up
    conda clean

ENTRYPOINT python -m kismet
