FROM rocker/r-ver:4.5.3

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    gdebi-core \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libcairo2-dev \
    libxt-dev \
    make \
    g++ \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.8.24/quarto-1.8.24-linux-amd64.deb && \
    gdebi -n quarto-1.8.24-linux-amd64.deb && \
    rm quarto-1.8.24-linux-amd64.deb

RUN Rscript -e "install.packages(c( \
    'knitr', \
    'rmarkdown', \
    'tidyverse', \
    'ggplot2', \
    'cowplot', \
    'patchwork', \
    'broom', \
    'broom.mixed', \
    'performance', \
    'parameters', \
    'see', \
    'ggeffects', \
    'emmeans', \
    'modelsummary', \
    'sjPlot' \
  ), repos = 'https://cloud.r-project.org')"

RUN Rscript -e "install.packages(c( \
    'Rcpp', \
    'RcppEigen', \
    'Matrix', \
    'nlme', \
    'lme4', \
    'lmerTest', \
    'DHARMa' \
  ), repos = 'https://cloud.r-project.org')"

RUN Rscript -e "stopifnot(requireNamespace('lme4', quietly = TRUE))" && \
    Rscript -e "stopifnot(requireNamespace('lmerTest', quietly = TRUE))" && \
    Rscript -e "stopifnot(requireNamespace('DHARMa', quietly = TRUE))"

WORKDIR /workspace