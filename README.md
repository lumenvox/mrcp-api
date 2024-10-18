# LumenVox MRCP API

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This is the docker-compose file for the MRCP API/Media Server.

To start the API, navigate to the `docker` folder and run the following:
```shell
docker compose up -d
```

To stop the API, navigate to the `docker` folder and run the following:
```shell
docker compose down
```

## Environment

| Parameter                          | Description                                    | Default                              |
|------------------------------------|------------------------------------------------|--------------------------------------|
| MEDIA_SERVER__DEPLOYMENT_ID        | Default deployment ID                          | 00000000-0000-0000-0000-000000000000 |
| MEDIA_SERVER__NUM_CHANNELS         | Number of channels to expose                   | 200                                  |
| MEDIA_SERVER__SERVER_IP            | Address of hosting machine                     | 127.0.0.1                            |
| MEDIA_SERVER__LUMENVOX_API_ADDRESS | Address of the Lumenvox API                    | lumenvox-api.testmachine.com         |
| MEDIA_SERVER__LUMENVOX_API_PORT    | Port of the Lumenvox API                       | 443                                  |
| MEDIA_SERVER__LOGGING_LEVEL        | Verbosity levels: 1=errors, 2=info, or 3=debug | 1                                    |

## Required Configuration
* For requests to the Lumenvox API to succeed, you must set `MEDIA_SERVER__DEPLOYMENT_ID` to your deployment ID.
* `MEDIA_SERVER__NUM_CHANNELS` should correspond to the number of ports exposed in the two ranges.
  * Using the defaults, this should be 200.
* For routing between the client and MRCP API, you must set `MEDIA_SERVER__SERVER_IP` to the MRCP API host machine IP.
* For routing between the MRCP API and Lumenvox API, you must set `MEDIA_SERVER__LUMENVOX_API_ADDRESS` to the hostname specified in the container stack.
  * If you haven't set up your DNS to manage the specified hostname, you must configure `MEDIA_SERVER__HOST_MAP`.

## Optional Configuration
For a full list of optional settings, see OPTIONAL.md in this directory. These settings can be applied directly to the
docker-compose.yaml file, or they can be applied via the .env file.

## Certificates
### Lumenvox API
If a certificate is required to connect to the Lumenvox API, place it in a `certs` folder under the `docker` folder and
name it `server.crt`:

```text
docker/
  docker-compose.yml
  .env
  certs/
    server.crt
```

### Grammar Fetches
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

## Save-Waveform

The save-waveform functionality can be enabled by setting
`MEDIA_SERVER__SAVE_WAVEFORM` to true.

When using an unmodified docker-compose.yaml file, saved waveforms will be
placed in the `docker/waveforms` directory. To change the location of this
directory on your local disk, you can update the left side of the volume
mapping in the docker-compose.yaml file. For example, if you are running
a web server to expose files, you might want to change the mapping to
something like `/var/www/waveforms:/var/lumenvox/waveforms`.

When the save-waveform functionality is enabled, URLs pointing to the
waveform files will be returned in MRCP headers. Use
`MEDIA_SERVER__WAVEFORM_URL_PREFIX` to set the prefix for these URLs. For
example, if the media server saves a waveform to `docker/waveforms/x.ulaw`
and the prefix is set to `https://test.com/`, the URL returned in the MRCP
header will be `https://test.com/x.ulaw`.

By default, waveforms will be automatically deleted at the end of a
session. To make waveforms persist past the end of the session, set
`MEDIA_SERVER__WAVEFORM_AUTO_CLEANUP` to false.
> Note: If you disable automatic cleanup, you will need to manually delete
> waveforms in order to preserve disk space.

## Management API

The MRCP-API now includes a management API to support various operations.
This API will listen on the address specified by `MANAGEMENT_ADDRESS`. By
default, this is `:8085`, which will listen on any interface on port 8085.

The management API only uses HTTPS. To use a custom certificate, place it
(and its corresponding key file) in the `docker/management_certs/` directory
and set `MANAGEMENT_CERT_PEM_FILE` and `MANAGEMENT_KEY_PEM_FILE` to the names
of these files, i.e. `server.crt` and `server.key`. If these variables are
left empty, a certificate will be auto-generated.

The management API implements basic authentication for HTTPS requests. To
configure a list of users, use the `MANAGEMENT_USERS` variable. For example,
to create two users `user1:pass1` and `user2:pass2`, set `MANAGEMENT_USERS`
to the output from following command:
```shell
echo -n "user1:pass1;user2:pass2" | base64 -w 0
```

If `MANAGEMENT_USERS` is left empty, a user `api-admin` will be
automatically created. The password for this user is random and can
be obtained from the logs:
```text
{"level":"WARN","time":"2024-02-16T14:16:06.284-0800","message":"generated API password: Y5cO5yreeMyzrc1OTF4c3xzLT6s"}
```

### Endpoints
| Operation | Endpoint        | Arguments (PUT only)   | Comments                             |
|-----------|-----------------|------------------------|--------------------------------------|
| GET       | /verbosity      |                        | Return current logging verbosity     |
| PUT       | /verbosity      | verbosity: int, 0-5    | Set logging verbosity                |
| GET       | /out-of-service |                        | Return current out-of-service status |
| PUT       | /out-of-service | out-of-service: 0 or 1 | Set out-of-service status            |

#### GET /verbosity Example:
```shell
curl -u user1:pass1 https://localhost:8085/verbosity --insecure
```
#### PUT /verbosity Example:
```shell
curl -X PUT -d '{"verbosity":"2"}' -u user1:pass1 https://localhost:8085/verbosity --insecure
```
#### GET /out-of-service Example:
```shell
curl -u user1:pass1 https://localhost:8085/out-of-service --insecure
```
#### PUT /out-of-service Example:
```shell
curl -X PUT -d '{"out-of-service":"1"}' -u user1:pass1 https://localhost:8085/out-of-service --insecure
```

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
