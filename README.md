# MRCP API

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
| MEDIA_SERVER__SPEECH_API_ADDRESS        | Address of the Speech API to point to                         | speech-api.testmachine.com           |
| MEDIA_SERVER__SPEECH_API_PORT           | Port of the Speech API to point to                            | 8080                                 |
| MEDIA_SERVER__USE_TLS                   | Toggle to use TLS between the Media Server and the Speech API | false                                |

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
