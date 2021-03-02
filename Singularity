Bootstrap: docker
From: continuumio/miniconda:latest

%labels
    AUTHOR wckdouglas@gmail.com

%environment
    export PATH="/opt/conda/bin:/usr/local/bin:/usr/bin:/bin:"
    unset CONDA_DEFAULT_ENV
    export ANACONDA_HOME=/opt/conda

%post
    export PATH=/opt/conda/bin:$PATH
    conda config --add channels defaults
    conda config --add channels bioconda
    conda install --yes lima=2.0.0 pbmm2=1.4.0 pbccs=6.0.0
    conda clean --index-cache --tarballs --packages --yes
