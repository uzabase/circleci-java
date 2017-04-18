FROM maven
MAINTAINER Hideyuki TAKEUCHI <hideyuki.takeuchi@uzabase.com>

RUN set -x \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y python-pip python-dev libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install awscli

RUN set -x \
    && curl -L -o /tmp/docker.tgz https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
    && tar -xz -C /tmp -f /tmp/docker.tgz \
    && mv /tmp/docker/* /usr/bin \
    && rm -rf /tmp/docker
