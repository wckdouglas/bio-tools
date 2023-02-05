FROM mambaorg/micromamba:0.19.1 as base
ARG MAMBA_DOCKERFILE_ACTIVATE=1

RUN micromamba install -y -n base \
    -c bioconda -c conda-forge \
    python=3.9 \
    jupyterlab jupyter pandas numpy seaborn scipy \
    pysam intervaltree pydantic \
    kb-python dask mpire scikit-misc\
    scanpy scvi-tools scvi \
    && micromamba clean --all --yes

FROM base as final
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH /opt/conda/bin:$PATH
