FROM mambaorg/micromamba:jammy-cuda-11.7.1 as base
ARG MAMBA_DOCKERFILE_ACTIVATE=1

RUN micromamba install -y -n base \
    -c bioconda -c conda-forge -c pytorch -c nvidia \
    python=3.9 jupyterlab jupyter pandas numpy seaborn scipy \
    pysam intervaltree pydantic \
    kb-python dask scikit-misc \
    mpire scvi-tools==0.19.0 \
    pytorch-cuda=11.7 \
    scanpy=1.9.1 \
    && micromamba clean --all --yes

FROM base as final
ARG MAMBA_DOCKERFILE_ACTIVATE
ENV PATH /opt/conda/bin:$PATH
