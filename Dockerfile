FROM continuumio/miniconda:latest

env PATH /opt/conda/bin:$PATH
RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda install --yes lima pbmm2 pbccs
RUN conda clean --index-cache --tarballs --packages --yes

