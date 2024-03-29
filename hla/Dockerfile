# Adopted from https://github.com/zlskidmore/docker-hla-la/blob/master/Dockerfile
# work from latest LTS ubuntu release
FROM ubuntu:18.04 as base

# set the environment variables
ENV hla_la_version 1.0.1
ENV samtools_version 1.9
ENV bwa_version 0.7.17
ENV picard_version 1.123
ENV bamtools_version 2.5.1
ENV mummer_version=4.0.0rc1


# run update and install necessary tools ubuntu tools
RUN apt-get update -y && \
    apt-get install -y \
        build-essential \
        curl \
        unzip \
        zlib1g-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libnss-sss \
        libbz2-dev \
        liblzma-dev \
        vim \
        less \
        libcurl4-openssl-dev \
        wget \
        libz-dev \
        openjdk-8-jre \
        libboost-all-dev \
        cmake \
        libjsoncpp-dev \
        cpanminus  \
        git \
        bioperl \
        libtext-levenshtein-perl \
        liblist-moreutils-perl

# install samtools
FROM base as build
WORKDIR /usr/local/bin
RUN wget https://github.com/samtools/samtools/releases/download/${samtools_version}/samtools-${samtools_version}.tar.bz2
RUN tar -xjf /usr/local/bin/samtools-${samtools_version}.tar.bz2 -C /usr/local/bin/
RUN cd /usr/local/bin/samtools-${samtools_version}/ && ./configure
RUN cd /usr/local/bin/samtools-${samtools_version}/ && make
RUN cd /usr/local/bin/samtools-${samtools_version}/ && make install

# instsall mummer
WORKDIR /usr/local/bin
RUN wget https://github.com/mummer4/mummer/releases/download/v${mummer_version}/mummer-${mummer_version}.tar.gz 
RUN tar zxvf mummer-${mummer_version}.tar.gz 
WORKDIR mummer-${mummer_version} 
RUN ./configure --prefix=/usr/local
RUN make  && make install CPPFLAGS="-O3 -DSIXTYFOURBITS"
RUN rm -rf /usr/local/bin/mummer-${mummer_version} mummer-${mummer_version}.tar.gz 

# install picard
WORKDIR /usr/local/bin
RUN wget https://github.com/broadinstitute/picard/releases/download/${picard_version}/picard-tools-${picard_version}.zip
RUN unzip picard-tools-${picard_version}.zip
RUN mkdir -p /usr/local/bin/picard
RUN mv /usr/local/bin/picard-tools-${picard_version}/* /usr/local/bin/picard/
RUN chmod 0644 /usr/local/bin/picard/SamToFastq.jar
RUN rm -rf /usr/local/bin/picard-tools-${picard_version}/

# install bwa
WORKDIR /usr/local/bin/
RUN mkdir -p /usr/local/bin/ \
  && curl -SL https://github.com/lh3/bwa/archive/v${bwa_version}.zip \
  >  v${bwa_version}.zip
RUN unzip v${bwa_version}.zip && rm -f v${bwa_version}.zip
RUN cd /usr/local/bin/bwa-${bwa_version} && make
RUN ln -s /usr/local/bin/bwa-${bwa_version}/bwa /usr/local/bin

# install bamtools
WORKDIR /usr/local/bin
RUN wget https://github.com/pezmaster31/bamtools/archive/v${bamtools_version}.zip
RUN unzip v${bamtools_version}.zip
RUN mkdir -p /usr/local/bin/bamtools-${bamtools_version}/build
WORKDIR /usr/local/bin/bamtools-${bamtools_version}/build
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local/bin/bamtools-${bamtools_version} ..
RUN make
RUN make install 

# install hla*la
RUN mkdir -p /opt/HLA-LA/bin
RUN mkdir -p /opt/HLA-LA/src
RUN mkdir -p /opt/HLA-LA/obj
RUN mkdir -p /opt/HLA-LA/temp
RUN mkdir -p /opt/HLA-LA/working
RUN mkdir -p /opt/HLA-LA/graphs
WORKDIR /opt/
RUN wget https://github.com/DiltheyLab/HLA-LA/archive/v${hla_la_version}.zip
RUN unzip v${hla_la_version}.zip
RUN mv /opt/HLA-LA-${hla_la_version}/* /opt/HLA-LA/src/
RUN rm -rf /opt/HLA-LA-${hla_la_version}
WORKDIR /opt/HLA-LA/src
RUN sed -i 's@\$(BAMTOOLS_PATH)/lib64@\$(BAMTOOLS_PATH)/lib@' makefile
RUN make all BOOST_PATH=/usr/include/boost BAMTOOLS_PATH=/usr/local/bin/bamtools-2.5.1

# modify paths.ini for hla*la
RUN sed -i 's@samtools_bin=@samtools_bin=/usr/local/bin/samtools@' paths.ini
RUN sed -i 's@bwa_bin=@bwa_bin=/usr/local/bin/bwa@' paths.ini
RUN sed -i 's@picard_sam2fastq_bin=.*@picard_sam2fastq_bin=/usr/local/bin/picard/SamToFastq.jar@' paths.ini
RUN sed -i 's@nucmer_bin=.*@nucmer_bin=/usr/local/bin/nucmer@' paths.ini

#perl module
RUN apt-get install -y 
WORKDIR /opt/
RUN git clone https://github.com/Ensembl/Bio-DB-HTS.git 
WORKDIR Bio-DB-HTS 
RUN perl INSTALL.pl && \
    cpanm Text::LevenshteinXS  && \
    cpanm List::MoreUtils

# some final cleanup and command
FROM build as hla
ENV LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"
ENV PATH="/usr/local/bin/:${PATH}"
ENV PATH="/opt/HLA-LA/bin/:${PATH}"
ENV PATH="/opt/HLA-LA/src/:${PATH}"
