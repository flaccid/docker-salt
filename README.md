# docker-salt

:whale: A Docker image for Salt (the SaltStack Platform).

## Usage

### Environment Variables

- `ENABLE_PAM_EAUTH` - whether to enable or disable PAM auth (default: `false`)
- `SALT_API` - whether to enable or disable the salt api server (default: `false`)
- `SALT_API_SSL` - whether to enable or disable salt api server SSL (default: `false`)
- `SALT_LOG_LEVEL` - salt log level (default: `info`)
- `SALT_PASSWORD` - set a password for the salt user
- `STACK_ROLE` - salt role to play, `salt-master` or `salt-minion`
  (default: `salt-master`)
- `TLS_SELF_SIGNED` - generate and use a self-signed cert (default: `false`)


### Volumes

In the image, we do not expose `/etc/salt` due to volume overlap with child
directories such as `/etc/salt/pki`. In runtime, you can however create
additional directories as desired.

- `/etc/salt/pki` - pki store used for master and minions
- `/var/cache/salt` - general salt cache files
- `/var/logs/salt` - salt logs

### Salt API

By default, the `salt-api` server is not enabled, it can be enabled by running
the container with the `SALT_API=true` environment variable.

For more information, see https://docs.saltstack.com/en/latest/ref/netapi/all/salt.netapi.rest_cherrypy.html

#### Authentication

Authentication with the Salt API is done using `eauth` (External Autentication System).
For more information, see https://docs.saltstack.com/en/latest/topics/eauth/index.html

Example login:

```
curl http://localhost:8000/login \
  -d username=salt \
  -d password=salt \
  -d eauth=pam
```

## Development

Check out available targets in `make help` to assist with development.

## License & Authors

- Author:: Chris Fordham ([chris@fordham.id.au](mailto:chris@fordham.id.au))

```text
Copyright:: 2019, Chris Fordham

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
