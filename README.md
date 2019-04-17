# docker-salt

:whale: A Docker image for Salt (SaltStack Platform)

## Usage

### Environment Variables

- `SALT_LOG_LEVEL` - salt log level (default: `info`)
- `STACK_ROLE` - salt role to play, `salt-master` or `salt-minion`
  (default: `salt-master`)

### Volumes

In the image, we do not expose `/etc/salt` due to volume overlap with child
directories such as `/etc/salt/pki`. In runtime, you can however create
additional directories as desired.

- `/etc/salt/pki` - certificate/key store used for signed minions
- `/var/cache/salt` - general salt cache files
- `/var/logs/salt` - salt logs

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
