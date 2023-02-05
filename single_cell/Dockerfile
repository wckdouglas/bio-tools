FROM mambaorg/micromamba:0.19.1 as base
ARG MAMBA_DOCKERFILE_ACTIVATE=1

RUN micromamba install -y -n base \
    -c bioconda -c conda-forge \
    python=3.9 \
    jupyterlab jupyter pandas numpy seaborn scipy \
    pysam intervaltree pydantic \
    kb-python dask mpire scikit-misc\
    matplotlib=3.0.3 \
    && micromamba clean --all --yes
# these have to be pip install, for the latest versions

FROM base as scrna
RUN pip install scanpy \
    && pip install scvi-tools  \
    && pip install scvi 

FROM scrna as final
ARG MAMBA_DOCKERFILE_ACTIVATE
ENV PATH /opt/conda/bin:$PATH
