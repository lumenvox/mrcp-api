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

| Parameter                               | Description                                                   | Default                              |
|-----------------------------------------|---------------------------------------------------------------|--------------------------------------|
| MEDIA_SERVER__ALLOW_DEPLOYMENT_OVERRIDE | Allow overrides of the deployment ID                          | false                                |
| MEDIA_SERVER__ALLOW_OPERATOR_OVERRIDE   | Allow overrides of the operator ID                            | false                                |
| MEDIA_SERVER__DEFAULT_DEPLOYMENT_ID     | Default deployment ID                                         | enter-your-specific-deployment-id    |
| MEDIA_SERVER__DEFAULT_OPERATOR_ID       | Default operator ID                                           | 00000000-0000-0000-0000-000000000000 |
| MEDIA_SERVER__NUM_CHANNELS              | Number of channels to expose                                  | 200                                  |
| MEDIA_SERVER__SERVER_IP                 | Address of hosting machine                                    | 127.0.0.1                            |
| MEDIA_SERVER__SPEECH_API_ADDRESS        | Address of the Speech API to point to                         | speech-api.testmachine.com           |
| MEDIA_SERVER__SPEECH_API_PORT           | Port of the Speech API to point to                            | 443                                  |
| MEDIA_SERVER__USE_TLS                   | Toggle to use TLS between the Media Server and the Speech API | true                                 |
| MEDIA_SERVER__HOST_MAP                  | Configure hosts file for unregistered domains                 | speech-api.testmachine.com:127.0.0.1 |

## Required Configuration
* For requests to the Speech API to succeed, you must set `MEDIA_SERVER__DEFAULT_DEPLOYMENT_ID` to your deployment ID.
* `MEDIA_SERVER__NUM_CHANNELS` should correspond to the number of ports exposed in the two ranges.
  * Using the defaults, this should be 200.
* For routing between the client and MRCP API, you must set `MEDIA_SERVER__SERVER_IP` to the MRCP API host machine IP.
* For routing between the MRCP API and Speech API, you must set `MEDIA_SERVER__SPEECH_API_ADDRESS` to the hostname specified in the container stack.
  * If you haven't set up your DNS to manage the specified hostname, you must configure `MEDIA_SERVER__HOST_MAP`.

## Certificates
If a certificate is required to connect to the Speech API, place it in a `certs` folder under the `docker` folder and
name it `server.crt`:

```text
docker/
  docker-compose.yml
  .env
  certs/
    server.crt
```

## Host Configuration
If your Speech API domain is unregistered, you will need to configure hostname
mapping in order for the MRCP API to connect to the Speech API. This can be
controlled using the `MEDIA_SERVER__HOST_MAP` variable. The hostname should
match the value of `MEDIA_SERVER__SPEECH_API_ADDRESS`, and the IP address
should be that of your Speech API.

If your Speech API domain is registered, no mapping is necessary: you can
either set this value to empty or comment it out.
