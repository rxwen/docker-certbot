FROM alpine
MAINTAINER Raymond Wen

RUN apk update && apk add certbot

# to run certbot without interaction, add: --agree-tos --email EMAIL_ADDRESS@DOMAIN
CMD ["certbot"]
