# You can find the new timestamped tags here:
# https://hub.docker.com/r/gitpod/workspace-python-3.9/tags
# It's best to pin a version instead of relying on "latest"
# for full reproducibility.
FROM gitpod/workspace-python-3.9:2022-09-07-02-19-02

CMD [ "/bin/bash" ]

ARG CONDA_VERSION=py39_4.12.0
ARG MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh"

# Install conda and mamba, based on instructions here:
# https://github.com/ContinuumIO/docker-images/tree/master/miniconda3/debian
RUN wget "${MINICONDA_URL}" -O ~/miniconda.sh -q && \
    sudo sh ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    sudo ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    sudo /opt/conda/bin/conda install mamba=0.25.0 -c conda-forge -y && \
    sudo find /opt/conda/ -follow -type f -name '*.a' -delete && \
    sudo find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    sudo /opt/conda/bin/conda clean -afy

# This is Gitpod only. The production version on AWS should comment this out.
RUN sudo chown -R gitpod:gitpod /opt/conda
