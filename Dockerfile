FROM continuumio/miniconda3:latest

RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda install python=3.9
RUN conda install -c conda-forge mamba

RUN mamba install -c bioconda --yes \
        lima=2.0.0 pbmm2\
        pbccs=6.0.0 \
        octopus bowtie2 hisat2 bwa cutadapt atropos \
        bedtools samtools pbsv hifiasm \
        pbmarkdup tabix bcftools \
        picard fastqc seqkit seqtk datamash &&\
    conda clean --index-cache --tarballs --packages --yes

ENV PATH /opt/conda/bin:$PATH
