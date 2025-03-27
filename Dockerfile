# Use base LumenVox MRCP API image
FROM lumenvox/mrcp-api:5.4

### install extra packages
RUN apt-get update && \
    apt-get install -y \
        nano \
        sngrep \
        ngrep \
        dnsutils \
    && \
    apt-get clean

### stage LumenVox container management scripts
COPY scripts/*.sh /root/

### set the same container working directory as the source
WORKDIR /usr/bin

### launch the same entrypoint as the source
CMD ["lv_mrcp_media_server"]
