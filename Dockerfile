FROM alpine:latest
# FROM node:lts-alpine
# install cmd tools needed
RUN apk update
RUN apk add wget unzip
# install docker engine
RUN apk add docker openrc
# Install packer
ENV PACKER_VERSION 1.6.0
RUN export
RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip
RUN chmod +x packer
RUN mv packer /usr/local/bin
# 
RUN mkdir /smembe812
# Install auth-server
RUN mkdir /smembe812/auth-server
COPY ./auth-server-packer.json /smembe812/auth-server/packer.json
COPY ./npmrc /smembe812/.npmrc
COPY ./npmrc /smembe812/auth-server/.npmrc
ENV NODE_ENV=development
#install file proxy
RUN mkdir /smembe812/file-proxy
COPY ./file-proxy-packer.json /smembe812/file-proxy/packer.json
WORKDIR /smembe812
#run packer from file cached in env
ENV PACKER_BUILD_FILE /smembe812/auth-server/packer.json
ENTRYPOINT [ ]
CMD packer build auth-server/packer.json && packer build file-proxy/packer.json