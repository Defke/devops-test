FROM golang:1.12

MAINTAINER kdfmail@qq.com

RUN mkdir -p /go/src/release

COPY devops-test /go/src/release

WORKDIR /go/src/release

EXPOSE 8089
CMD ["nohup ./devops-test > run.log &"]