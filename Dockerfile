FROM sysdig/sysdig:latest

ARG KUBERNETES_VERSION

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && apt-key fingerprint 0EBFCD88 \
    && echo "deb [arch=amd64] https://download.docker.com/linux/debian jessie stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        apt-utils \
        vim \
        dnsutils \
        telnet \
        tcpdump \
        inetutils-traceroute \
        docker-ce \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ADD https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

ADD ksysdig /usr/local/bin/ksysdig
RUN chmod +x /usr/local/bin/ksysdig