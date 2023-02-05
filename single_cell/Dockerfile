FROM mambaorg/micromamba:0.19.1 as base

COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

RUN micromamba activate base \
    && micromamba install -c bioconda -c conda-forge --yes \
        python=3.9 \
        jupyterlab jupyter pandas numpy seaborn scipy \
        pysam intervaltree pydantic \
        kb-python dask mpire scikit-misc\
    && conda clean --index-cache --tarballs --packages --yes \
    && pip install matplotlib=3.0.3 \
    && pip install scanpy \
    && pip install scvi-tools 

FROM base as final
ENV PATH /opt/conda/bin:$PATH
