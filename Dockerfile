FROM alpine:latest

RUN apk add --update --no-cache curl coreutils bash jq && rm -rf /var/cache/apk/*
