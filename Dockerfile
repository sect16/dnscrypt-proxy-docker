FROM alpine:latest

MAINTAINER Chin Pin Hon

RUN apk add --no-cache tzdata curl bind-tools 

RUN curl -L https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/2.1.2/dnscrypt-proxy-linux_arm64-2.1.2.tar.gz > /tmp/dnscrypt-proxy.tar.gz && \
    mkdir /opt/dnscrypt-proxy && \
    cd /opt/dnscrypt-proxy && \
    tar xvzf /tmp/dnscrypt-proxy.tar.gz --strip-components 1 && \
    rm /tmp/dnscrypt-proxy.tar.gz

COPY dnscrypt-proxy.toml /opt/dnscrypt-proxy/dnscrypt-proxy.toml

ENTRYPOINT ["/opt/dnscrypt-proxy/dnscrypt-proxy", "-config", "/usr/share/dnscrypt-proxy/dnscrypt-proxy.toml"]

#HEALTHCHECK --interval=300s CMD dig . @localhost > /dev/null || exit 1
HEALTHCHECK --interval=300s CMD /opt/dnscrypt-proxy/dnscrypt-proxy -resolve www.google.com,127.0.0.1 > /dev/null || exit 1
