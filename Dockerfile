FROM ubuntu:trusty

LABEL maintainer="Mirko Hecky"

RUN apt-get update && apt-get install -y python-software-properties && add-apt-repository ppa:duplicity-team/ppa

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    duplicity \
    duply \
    haveged \
    ncftp \
    python-boto \
    python-paramiko \
    pwgen \
    rsync \
    openssh-client \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENV HOME /root

ENV KEY_TYPE      RSA
ENV KEY_LENGTH    2048
ENV SUBKEY_TYPE   RSA
ENV SUBKEY_LENGTH 2048
ENV NAME_REAL     Duply Backup
ENV NAME_EMAIL    duply@localhost
ENV PASSPHRASE    random

VOLUME ["/root"]

COPY files/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash"]
