FROM ubuntu:focal
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -qqy update && apt-get -qqy install curl git build-essential wget net-tools bash 

RUN wget -O ~/vsls-reqs https://aka.ms/vsls-linux-prereq-script && chmod +x ~/vsls-reqs && ~/vsls-reqs

# create lean user
RUN useradd lean -m -U
USER lean
WORKDIR /home/lean

# install elan
RUN curl https://raw.githubusercontent.com/Kha/elan/master/elan-init.sh -o elan-init.sh
RUN sh ./elan-init.sh --default-toolchain none --no-modify-path -y
ENV PATH "/home/lean/.elan/bin:$PATH"

RUN elan default leanprover/lean4:nightly