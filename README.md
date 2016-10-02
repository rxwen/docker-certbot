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

### setup haproxy rule if we can't use port 80 for the certbot container

The certbot need to bind to port 80 on the host so that let's encrypt can verify that we really owns the domain. But there're cases we can't bind 80 to certbot container. In production environment, port 80 is usually occupied by haproxy. We start certbot to bind a different tcp port, and setup haproxy to redirect let's encrypt's request to the certbot container's port.

```
frontend http
    bind 0.0.0.0:80
    acl certbot-req path_beg -i /.well-known/acme-challenge/
    # Send to certbot-backend
    use_backend certbot_backend if certbot-req

backend certbot_backend
    server certbot-node IP_OF_CERTBOT_CONTAINER:PORT_OF_CERTBOT_CONTAINER
```
