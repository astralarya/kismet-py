FROM autochthe/kismet.jupyter

RUN conda install nodejs && \
    jupyter labextension install jupyterlab_vim && \
    conda uninstall nodejs && \
    # Clean up
    conda clean --all
