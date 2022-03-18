FROM gcc:9.2 as base

RUN apt-get update && apt-get install -y cmake libgtest-dev libboost-test-dev && rm -rf /var/lib/apt/lists/* 

FROM base as cmake
RUN mkdir -p /opt
WORKDIR /opt
RUN git clone https://github.com/AntonBankevich/LJA.git 


FROM cmake AS lja_build
WORKDIR /opt/LJA 
RUN   cmake . && \
    make

ENV PATH /opt/LJA/bin:$PATH
