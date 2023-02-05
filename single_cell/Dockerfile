FROM mambaorg/micromamba:0.19.1 as base
ARG MAMBA_DOCKERFILE_ACTIVATE=1

RUN micromamba install -y -n base \
    -c bioconda -c conda-forge \
    python=3.9 \
    jupyterlab jupyter pandas numpy seaborn scipy \
    pysam intervaltree pydantic \
    kb-python dask scikit-misc \
    scvi-tools=0.19.0 scvi=0.6.8 mpire \
    && micromamba clean --all --yes
# these have to be pip install, for the latest versions

FROM base as scrna
ARG MAMBA_DOCKERFILE_ACTIVATE
RUN python  -m pip install --upgrade pip setuptools wheel \
    && pip install matplotlib==3.6.2 \
    && pip install scanpy==1.9.1 

FROM scrna as final
ARG MAMBA_DOCKERFILE_ACTIVATE
ENV PATH /opt/conda/bin:$PATH
