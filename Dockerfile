FROM continuumio/miniconda3:latest

RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda install python=3.6 
RUN conda install -c conda-forge mamba

RUN mamba install -c bioconda --yes \
        lima=2.0.0 pbmm2=1.4.0 \
        pbccs=6.0.0 \
        octopus bowtie2 hisat2 bwa cutadapt atropos \
        bedtools samtools bedtools tabix \
        picard fastqc seqkit seqtk datamash 
RUN mamba install -c bioconda pbmarkdup 
RUN conda clean --index-cache --tarballs --packages --yes

ENV PATH /opt/conda/bin:$PATH
