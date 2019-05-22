FROM alpine:edge

MAINTAINER Chris Fordham <chris@fordham.id.au>

ENV STACK_ROLE=salt-master
ENV SALT_LOG_LEVEL=info

# https://pkgs.alpinelinux.org/package/edge/community/x86_64/salt
RUN apk add \
    --update \
    --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
      git \
      salt \
      salt-api \
      salt-cloud \
      salt-doc \
      salt-master \
      salt-minion \
      salt-ssh \
      salt-syndic && \
    mkdir -p /etc/salt/pki

VOLUME /etc/salt/pki
VOLUME /var/cache/salt
VOLUME /var/logs/salt

EXPOSE 4505/tcp
EXPOSE 4506/tcp

CMD "$STACK_ROLE" --log-level "$SALT_LOG_LEVEL"
