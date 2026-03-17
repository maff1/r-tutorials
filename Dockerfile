FROM rocker/r-ver:4.5.3

RUN apt-get update && apt-get install -y \
    wget \
    gdebi-core \
    && rm -rf /var/lib/apt/lists/*

# install Quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.8.24/quarto-1.8.24-linux-amd64.deb && \
    gdebi -n quarto-1.8.24-linux-amd64.deb && \
    rm quarto-1.8.24-linux-amd64.deb

# install minimal R packages
RUN Rscript -e "install.packages(c('knitr','rmarkdown'), repos='https://cloud.r-project.org')"