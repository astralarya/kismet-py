FROM continuumio/miniconda3

RUN conda update --all && \
    conda config --prepend channels intel && \
    conda config --prepend channels pytorch && \
    conda config --append channels conda-forge && \
    conda install \
        # Python 3.6
        python'>=3.6,<3.7' \
        # Dependencies
        ipython'>=7' \
        jupyterlab \
        lark-parser \
        nodejs \
        numpy \
        prompt_toolkit \
        pytorch-cpu \
        regex \
        # Transitive Dependencies
        aiohttp \
        async-timeout \
        chardet \
        graphviz \
        multidict \
        networkx \
        opt_einsum \
        tqdm \
        websockets \
    && \
    # Clean up
    conda clean --all

COPY version.txt /root
RUN pip install --no-cache-dir kismet=="$(cat /root/version.txt)"
RUN python -m kismet.kernel.install

STOPSIGNAL SIGINT
