FROM continuumio/miniconda:latest

RUN conda config --add channels defaults && \
     conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda install python=3 && \
    conda install -c conda-forge mamba

RUN mamba install -c bioconda --yes \
        lima=2.0.0 pbmm2=1.4.0 \
        pbccs=6.0.0 whatshap=1.1 \
        octopus bowtie2 hisat2 bwa cutadapt atropos \
        bedtools samtools bedtools \
        picard fastqc seqkit seqtk datamash  && \
        pbmarkdup
    conda clean --index-cache --tarballs --packages --yes

ENV PATH /opt/conda/bin:$PATH
