FROM continuumio/miniconda:latest

RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge
RUN conda install python=3
RUN conda install -c conda-forge mamba
RUN mamba install -c bioconda --yes lima=2.0.0 pbmm2=1.4.0 pbccs=6.0.0 whatshap
RUN conda clean --index-cache --tarballs --packages --yes

ENV PATH /opt/conda/bin:$PATH
