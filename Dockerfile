FROM alpine:edge

MAINTAINER Chris Fordham <chris@fordham.id.au>

ENV ENABLE_PAM_EAUTH=false
ENV SALT_API=false
ENV SALT_LOG_LEVEL=info
ENV STACK_ROLE=salt-master
ENV TLS_SELF_SIGNED=false

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# https://pkgs.alpinelinux.org/package/edge/community/x86_64/salt
# cherrypy installed by pip as package version missing many python deps
RUN addgroup -g 450 -S salt && \
    adduser -s /bin/sh -SD -G salt salt && \
    apk add \
      --update \
      --no-cache \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
        git \
        linux-pam \
        linux-pam-dev \
        py3-gitpython \
        py3-pyldap \
        py3-more-itertools \
        py3-openssl \
        py3-pip \
        py3-pygit2 \
        salt \
        salt-api \
        salt-doc \
        salt-master \
        salt-minion \
        salt-ssh \
        salt-syndic && \
    mkdir -p /etc/salt/pki && \
    sed -i "s/#default_include/default_include/g" /etc/salt/master && \
    pip3 install CherryPy

VOLUME /etc/salt/pki
VOLUME /var/cache/salt
VOLUME /var/logs/salt

EXPOSE 4505/tcp
EXPOSE 4506/tcp

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD "$STACK_ROLE" --log-level "$SALT_LOG_LEVEL"
