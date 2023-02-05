FROM mambaorg/micromamba:0.19.1 as base

RUN mamba config --add channels defaults && \
    mamba config --add channels bioconda && \
    mamba config --add channels conda-forge && \
    mamba install python=3.9

FROM base as conda
RUN mamba install  --yes \
    jupyterlab jupyter pandas numpy seaborn scipy \
    pysam intervaltree pydantic \
    kb-python dask mpire scikit-misc\
    && conda clean --index-cache --tarballs --packages --yes \
    && pip install matplotlib=3.0.3 \
    && pip install scanpy \
    && pip install scvi-tools 

FROM conda as final
ENV PATH /opt/conda/bin:$PATH
