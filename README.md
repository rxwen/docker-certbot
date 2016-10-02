# docker-certbot
certbot docker image for let's encrypt

## usage example

### docker command
```
docker run -it --rm -v ~/certdir:/etc/letsencrypt/ rxwen/certbot certonly --standalone --agree-tos --email nobody@example.com --domain my-domain.com
```

### docker compose
```
version: '2'

services:

    certbot:
        image: rxwen/certbot
        volumes:
            - ./certdir:/etc/letsencrypt
        command: [certbot, certonly, --email, nobody@example.com, --agree-tos, --domain, example.com, --standalone]
```
