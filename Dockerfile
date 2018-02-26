FROM ubuntu:16.04
RUN apt-get update && \
    apt-get install -yq apt-utils && \
    apt-get upgrade -yq

RUN apt-get install -yq btrfs-tools e2fsprogs iptables xfsprogs xz-utils pigz zfsutils-linux wget

# Docker install
RUN apt-get install -yq apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -yq docker-ce

ENV DIND_COMMIT 3b5fac462d21ca164b3778647420016315289034

RUN wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind" && \
    chmod +x /usr/local/bin/dind

COPY dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
