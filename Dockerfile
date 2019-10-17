FROM golang:1.12

MAINTAINER kdfmail@qq.com

RUN mkdir -p /home/holder

COPY devops-test /home/holder

WORKDIR /home/holder

RUN echo $PWD

EXPOSE 8089
CMD ["nohup ./hom/devops-test &"]