# Use base LumenVox MRCP API image
# NOTE: The version should always stay in lockstep with:
# https://github.com/Invoca/lumenvox-kubernetes-rendering/blob/5a20683105fab839b33d55e19505c9ddf7870eeb/values.yaml#L349
FROM lumenvox/mrcp-api:6.2

### Install extra packages
RUN apt-get update && \
    apt-get install -y \
        nano \
        sngrep \
        ngrep \
        dnsutils \
    && \
    apt-get clean

### Stage container management scripts
COPY scripts/*.sh /root/

### Set the same container working directory as the source image
WORKDIR /usr/bin

### Launch the same entrypoint as the source image
CMD ["lv_mrcp_media_server"]
