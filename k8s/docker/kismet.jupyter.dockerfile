FROM autochthe/kismet.base

EXPOSE 8888
RUN python -m kismet.kernel.install
RUN mkdir -p /root/notebooks ~/.jupyter/lab/user-settings/\@jupyterlab/apputils-extension && \
    echo '{"theme": "JupyterLab Dark"}' > ~/.jupyter/lab/user-settings/\@jupyterlab/apputils-extension/themes.jupyterlab-settings

ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--notebook-dir=/root/notebooks", "--allow-root"]
