FROM continuumio/miniconda3:latest as base

RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda install python=3.9
RUN conda install -c conda-forge mamba

FROM base as conda
COPY package-list.txt .
RUN mamba install -c bioconda --yes  --file package-list.txt && \
    conda clean --index-cache --tarballs --packages --yes

FROM conda as exec
ENV PATH /opt/conda/bin:$PATH
