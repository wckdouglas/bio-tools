FROM continuumio/miniconda:latest

env PATH /opt/conda/bin:$PATH
RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda install -c conda-forge mamba
RUN mamba install -c bioconda --yes lima=2.0.0 pbmm2=1.4.0 pbccs=6.0.0 whatshap=1.1
RUN conda clean --index-cache --tarballs --packages --yes

