FROM arm64v8/alpine:latest

MAINTAINER Chin Pin Hon

RUN apk add --no-cache curl bind-tools

RUN curl -L https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/2.1.1/dnscrypt-proxy-linux_arm64-2.1.1.tar.gz > /tmp/dnscrypt-proxy.tar.gz && \
    mkdir /opt/dnscrypt-proxy && \
    cd /opt/dnscrypt-proxy && \
    tar xvzf /tmp/dnscrypt-proxy.tar.gz --strip-components 1 && \
    rm /tmp/dnscrypt-proxy.tar.gz

# To add ARG for timezone settings
RUN apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime && \
    echo "Asia/Hong_Kong" > /etc/timezone && \
    apk del tzdata 

COPY dnscrypt-proxy.toml /opt/dnscrypt-proxy/dnscrypt-proxy.toml

ENTRYPOINT ["/opt/dnscrypt-proxy/dnscrypt-proxy", "-config", "/opt/dnscrypt-proxy/dnscrypt-proxy.toml"]

HEALTHCHECK --interval=300s CMD dig . @localhost > /dev/null || exit 1
