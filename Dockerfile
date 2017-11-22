## -*- docker-image-name: "xjdr/prod-base" -*-
FROM debian:jessie
MAINTAINER Jeff Rose <jeff.rose12@gmail.com>

# ===== Use the "noninteractive" debconf frontend =====
ENV DEBIAN_FRONTEND noninteractive

# ===== Use Cloudfront =====
RUN sh -c 'echo "deb [arch=amd64] http://cloudfront.debian.net/debian/ jessie main" > /etc/apt/sources.list'
RUN sh -c 'echo "deb [arch=amd64] http://cloudfront.debian.net/debian-security/ jessie/updates main" >> /etc/apt/sources.list'

# ===== Update apt-get =====
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get upgrade -y

# ===== Install sudo  =====
RUN apt-get -y install sudo locales ca-certificates

# ==== Set locales and Timezones and whatnot =====
RUN sudo echo "America/Los_Angeles" > /etc/timezone
RUN sudo dpkg-reconfigure -f noninteractive tzdata
RUN sudo sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN sudo echo 'LANG="en_US.UTF-8"'>/etc/default/locale
RUN sudo dpkg-reconfigure --frontend=noninteractive locales
RUN sudo update-locale LANG=en_US.UTF-8

# ===== Installing packages =====
RUN apt-get install -y \
    git-core \
    gperf \
    wget \
    unzip \
    curl \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libgflags-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
    libcurl4-openssl-dev \
--no-install-recommends

