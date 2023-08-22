# LumenVox MRCP API

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This is the docker-compose file for the MRCP API/Media Server.

To start the API, navigate to the `docker` folder and run the following:
```shell
docker-compose up -d
```

To stop the API, navigate to the `docker` folder and run the following:
```shell
docker-compose down
```

## Environment

| Parameter                               | Description                                                     | Default                                |
|-----------------------------------------|-----------------------------------------------------------------|----------------------------------------|
| MEDIA_SERVER__ALLOW_DEPLOYMENT_OVERRIDE | Allow overrides of the deployment ID                            | false                                  |
| MEDIA_SERVER__ALLOW_OPERATOR_OVERRIDE   | Allow overrides of the operator ID                              | false                                  |
| MEDIA_SERVER__DEFAULT_DEPLOYMENT_ID     | Default deployment ID                                           | enter-your-specific-deployment-id      |
| MEDIA_SERVER__DEFAULT_OPERATOR_ID       | Default operator ID                                             | 00000000-0000-0000-0000-000000000000   |
| MEDIA_SERVER__NUM_CHANNELS              | Number of channels to expose                                    | 200                                    |
| MEDIA_SERVER__SERVER_IP                 | Address of hosting machine                                      | 127.0.0.1                              |
| MEDIA_SERVER__LUMENVOX_API_ADDRESS      | Address of the Lumenvox API to point to                         | lumenvox-api.testmachine.com           |
| MEDIA_SERVER__LUMENVOX_API_PORT         | Port of the Lumenvox API to point to                            | 443                                    |
| MEDIA_SERVER__USE_TLS                   | Toggle to use TLS between the Media Server and the Lumenvox API | true                                   |
| MEDIA_SERVER__HOST_MAP                  | Configure hosts file for unregistered domains                   | lumenvox-api.testmachine.com:127.0.0.1 |

## Required Configuration
* For requests to the Lumenvox API to succeed, you must set `MEDIA_SERVER__DEFAULT_DEPLOYMENT_ID` to your deployment ID.
* `MEDIA_SERVER__NUM_CHANNELS` should correspond to the number of ports exposed in the two ranges.
  * Using the defaults, this should be 200.
* For routing between the client and MRCP API, you must set `MEDIA_SERVER__SERVER_IP` to the MRCP API host machine IP.
* For routing between the MRCP API and Lumenvox API, you must set `MEDIA_SERVER__LUMENVOX_API_ADDRESS` to the hostname specified in the container stack.
  * If you haven't set up your DNS to manage the specified hostname, you must configure `MEDIA_SERVER__HOST_MAP`.

## Certificates
If a certificate is required to connect to the Lumenvox API, place it in a `certs` folder under the `docker` folder and
name it `server.crt`:

```text
docker/
  docker-compose.yml
  .env
  certs/
    server.crt
```

To specify an extra set of root CAs to trust when fetching grammars, concatenate
the certificates in a file, `extra-root-cas.pem`:
```text
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
```

Base64-encode the file, and set `MEDIA_SERVER__EXTRA_ROOT_CA` to the result:
```shell
base64 extra-root-cas.pem -w 0
```

## Host Configuration
If your Lumenvox API domain is unregistered, you will need to configure hostname
mapping in order for the MRCP API to connect to the Lumenvox API. This can be
controlled using the `MEDIA_SERVER__HOST_MAP` variable. The hostname should
match the value of `MEDIA_SERVER__LUMENVOX_API_ADDRESS`, and the IP address
should be that of your Lumenvox API.

If your Lumenvox API domain is registered, no mapping is necessary: you can
either set this value to empty or comment it out.

## Networking and Memory
By default, Docker will spawn a proxy process for each port exposed by a
container. For applications such as this which expose large numbers of ports,
this can create issues with memory usage.

There are multiple ways to get around this. In `docker-compose.yaml`, you
will see the following line:
```shell
network_mode: host
```
This connects the MRCP API directly to the host network, removing the need
for proxy processes, and resulting in far less memory usage.

If you prefer not to have the container directly connected to the host
network, there is another workaround. Add the following configuration to
`/etc/docker/daemon.json`, and restart docker:
```json
{
    "userland-proxy": false
}
```
After making this change and before starting the container, comment out
the `network_mode` line.

Note that this solution will increase the startup time depending on how
many ports are being exposed.

## Older Versions of Docker Compose
Depending on the version of docker compose you are using, there may be
issues with using the `network_mode: host` option in conjunction with
the ports section being present. In this case, you will see something
like the following:
```shell
ERROR: for cloud-media-server "host" network_mode is incompatible with port_bindings
```
In this case, you can comment out the ports section in `docker-compose.yaml`.
This should resolve the issue.
