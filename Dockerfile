FROM maven
MAINTAINER Hideyuki TAKEUCHI <hideyuki.takeuchi@uzabase.com>

ARG USER_HOME_DIR="/root"

ARG GRADLE_VERSION=4.6
ARG GRADLE_SHA=98bd5fd2b30e070517e03c51cbb32beee3e2ee1a84003a5a5d748996d4b1b915
ARG GRADLE_BASE_URL=https://services.gradle.org/distributions

RUN curl -fsSL -o /tmp/gradle.zip ${GRADLE_BASE_URL}/gradle-${GRADLE_VERSION}-bin.zip \
    && echo "${GRADLE_SHA} /tmp/gradle.zip" | sha256sum -c - \
    && unzip /tmp/gradle.zip -d /usr/share \
    && mv /usr/share/gradle-${GRADLE_VERSION} /usr/share/gradle \
    && rm -f /tmp/gradle.zip \
    && ln -s /usr/share/gradle/bin/gradle /usr/bin/gradle

ENV GRADLE_HOME=/usr/share/gradle

VOLUME "$USER_HOME_DIR/.gradle"

RUN set -x \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y python-pip python-dev libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade awscli

RUN set -x \
    && curl -L -o /tmp/docker.tgz https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
    && tar -xz -C /tmp -f /tmp/docker.tgz \
    && mv /tmp/docker/* /usr/bin \
    && rm -rf /tmp/docker
