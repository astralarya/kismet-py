FROM continuumio/miniconda3

RUN conda update --all && \
    conda config --prepend channels intel && \
    conda config --prepend channels pytorch && \
    conda config --append channels conda-forge && \
    conda install \
        # Python 3.6
        'python>=3.6,<3.7' \
        # Dependencies
        lark-parser \
        numpy \
        prompt_toolkit \
        pytorch-cpu \
        regex \
    && \
    # Install Kismet
    pip install --no-cache-dir kismet && \
    # Clean up
    conda clean --all

ENTRYPOINT python -m kismet.chatbot.discord
