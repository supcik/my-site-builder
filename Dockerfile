FROM ubuntu

LABEL maintainer="jacques@supcik.net"
LABEL version="1.0.1"
ENV GOLANG_VERSION 1.9.2

ENV PATH /root/bin:/usr/local/go/bin:$PATH
ENV GOPATH /root

RUN apt-get update && apt-get install -y \
    wget \
    git \
    python-pip \
    zip

RUN \
    wget -O go.tgz https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz; \
    tar -C /usr/local -xzf go.tgz; \
	rm go.tgz; \
    pip install pygments; \
    go get github.com/kardianos/govendor; \
    govendor get github.com/gohugoio/hugo; \
    go install github.com/gohugoio/hugo; \
    go get -u github.com/tcnksm/ghr; \
    go install github.com/tcnksm/ghr

RUN \
    go version; \
    hugo version; \
    pygmentize -V; \
    ghr -version
