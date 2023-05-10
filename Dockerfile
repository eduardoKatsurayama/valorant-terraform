FROM ubuntu:latest

ENV HOME /home/ubuntu

RUN apt-get update && \
    apt-get install -y git sudo curl unzip

# Users
RUN useradd -m -s /bin/bash ubuntu && \
    usermod -aG sudo ubuntu && \
    sudo passwd -d ubuntu

USER ubuntu

# Ubuntu user as default
WORKDIR ${HOME}

# Clone and install tfenv
RUN git clone --depth=1 https://github.com/tfutils/tfenv.git ${HOME}/.tfenv && \
    export PATH=$PATH:$HOME/.tfenv/bin && \
    tfenv install 1.4.6 && \
    tfenv use 1.4.6 && \
    echo "export PATH=$PATH:$HOME/.tfenv/bin" >> ${HOME}/.bashrc

# Create directory for mounting the volume
RUN mkdir -p ${HOME}/valorant-terraform
