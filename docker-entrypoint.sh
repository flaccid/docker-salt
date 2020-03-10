#!/bin/sh -e

# salt-api requires CherryPy PyOpenSSL
# https://docs.saltstack.com/en/latest/ref/netapi/all/salt.netapi.rest_cherrypy.html

: ${ENABLE_PAM_EAUTH:=false}
: ${SALT_API:=false}
: ${SALT_API_SSL:=false}
: ${SALT_PASSWORD:=}
: ${TLS_SELF_SIGNED:=false}

mkdir -p /etc/salt/master.d

if [ "$ENABLE_PAM_EAUTH" = 'true' ]; then
  cat <<EOF> /etc/salt/master.d/external_auth.conf
external_auth:
  pam:
    salt:
      - .*
      - '@wheel'   # to allow access to all wheel modules
      - '@runner'  # to allow access to all runner modules
      - '@jobs'    # to allow access to the jobs runner and/or wheel module
EOF
fi

if [ "$TLS_SELF_SIGNED" = 'true' ]; then
  salt-call --local tls.create_self_signed_cert
  read -r -d '' ssl_pki <<-"EOT"
  ssl_crt: /etc/pki/tls/certs/localhost.crt
  ssl_key: /etc/pki/tls/certs/localhost.key
EOT
fi

if [ "$SALT_API" = 'true' ]; then
  if [ "$SALT_API_SSL" = 'false' ]; then
    disable_ssl='disable_ssl: True'
  else
    disable_ssl='disable_ssl: False'
  fi

  if [ ! -z "$SALT_PASSWORD" ]; then
    echo 'updating password for salt user'
    echo "salt:$SALT_PASSWORD" | chpasswd
  fi

  cat <<EOF> /etc/salt/master.d/rest.conf
rest_cherrypy:
  port: 8000
  collect_stats: True
  $disable_ssl
  $ssl_pki
EOF

  echo 'start salt api daemon in background'
  salt-api --log-file=/dev/stdout &
fi

echo "> $@" && exec "$@"
