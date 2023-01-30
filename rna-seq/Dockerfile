FROM continuumio/miniconda3:latest as base

RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda install python=3.9
RUN conda install -c conda-forge mamba

FROM base as conda
RUN mamba install -c bioconda --yes \
    bowtie2 hisat2 \
    bwa cutadapt \
    bedtools samtools tabix \
    picard fastqc seqkit seqtk datamash \
    kallisto \
    && conda clean --index-cache --tarballs --packages --yes

# build a few custom rust tools
FROM rust:1.67-slim-buster as rust 
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget unzip perl cmake \
    && rm -rf /var/lib/apt/lists/* 
WORKDIR /opt/work
RUN wget https://github.com/wckdouglas/filter-clipped/archive/refs/tags/v0.3.0.zip 
RUN unzip v0.3.0.zip 
WORKDIR filter-clipped-0.3.0
RUN cargo install --path .


WORKDIR /opt/work
RUN wget https://github.com/wckdouglas/fq-filter-reads/archive/refs/tags/0.1.0.zip 
RUN unzip 0.1.0.zip 
WORKDIR fq-filter-reads-0.1.0
RUN cargo install --path .



FROM conda as exec
COPY --from=rust /usr/local/cargo/bin/fq-filter-reads /usr/local/bin/fq-filter-reads 
COPY --from=rust /usr/local/cargo/bin/filter-clipped /usr/local/bin/filter-clipped
ENV PATH /usr/local/bin:/opt/conda/bin:$PATH
