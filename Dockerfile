FROM python:3.7-alpine

MAINTAINER Chris Fordham <chris@fordham.id.au>

ENV SALT_LOG_LEVEL=info

# https://pkgs.alpinelinux.org/package/edge/community/x86_64/salt
RUN apk add \
    --update \
    --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
      salt \
      salt-api \
      salt-cloud \
      salt-doc \
      salt-master \
      salt-minion \
      salt-ssh \
      salt-syndic

VOLUME /etc/salt

EXPOSE 4505/tcp
EXPOSE 4506/tcp

CMD salt-master --log-level "$SALT_LOG_LEVEL"
