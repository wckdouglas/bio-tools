FROM continuumio/miniconda3:latest as base

RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda install python=3.9
RUN conda install -c conda-forge mamba

FROM base as conda
RUN mamba install -c bioconda -c conda-forge --yes \
    jupyterlab jupyter pandas numpy seaborn scipy \
    pysam intervaltree pydantic \
    bustools=0.41.0 kallisto=0.48.0 dask mpire \
    && conda clean --index-cache --tarballs --packages --yes
RUN pip install scanpy && pip install scvi-tools

FROM conda as final
ENV PATH /opt/conda/bin:$PATH
