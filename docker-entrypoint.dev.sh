#!/bin/sh -e

# only used with dev version of image

su - salt -c 'salt-run salt.cmd tls.create_self_signed_cert'

echo "> $@" && exec "$@"
