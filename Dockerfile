# Build Docker Image:
# docker build --platform linux/amd64 -t odbc_amd64:latest .
# 
# Build Singularity Image:
# docker run -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/output --privileged -t --rm singularityware/docker2singularity odbc_amd64:latest
#
# Copy the Singularity image to M2.
#
# Use:
# module load singularity
# singularity shell odbc.sif

FROM ubuntu:20.04
LABEL maintainer "Robert Kalescky <rkalescky@smu.edu>"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&\
 apt-get install -y\
 build-essential\
 git\
 cmake\
 gpg-agent\
 curl\
 zsh\
 python3\
 python3-pip

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - &&\
 curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list\
 > /etc/apt/sources.list.d/mssql-release.list &&\
 apt-get update &&\
 ACCEPT_EULA=Y apt-get -y install msodbcsql17 unixodbc-dev

RUN apt-get install -y\
 python3-matplotlib\
 python3-geopandas

RUN pip install -U\
 pip\
 setuptools\
 wheel\
 scikit-learn

