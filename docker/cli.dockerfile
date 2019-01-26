FROM continuumio/anaconda

RUN conda update && \
    conda config \
        --prepend intel
    conda config \
        --append conda-forge
    conda install \
        # Python 3.6
        'python>=3.6<3.7'
        # Dependencies
        lark-parser
        numpy
        prompt_toolkit>=2.0
        regex
        torch
    && \
    # Install Kismet
    pip install --no-cache-dir kismet && \
    # Clean up
    conda clean

ENTRYPOINT python -m kismet
