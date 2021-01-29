Bootstrap: docker
From: continuumio/miniconda3:4.4.10

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
    conda install --yes lima pbmm2 pbccs
    conda clean --index-cache --tarballs --packages --yes
