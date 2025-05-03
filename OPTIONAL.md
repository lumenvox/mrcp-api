# Optional Environment Variables

## OAuth

### MEDIA_SERVER__OAUTH_ENABLED

If set to "1", enables OAuth for the connection to the Lumenvox API

Default Value:  ""

### MEDIA_SERVER__USERNAME

Allows setting of OAuth username via the environment. Overrides any
usernames found in `credentials.ini`.

Default Value:  ""

### MEDIA_SERVER__PASSWORD

Allows setting of OAuth password via the environment. Overrides any
passwords found in `credentials.ini`.

Default Value:  ""

### MEDIA_SERVER__CLIENT_ID

Allows setting of OAuth client ID via the environment. Overrides any
IDs found in `credentials.ini`.

Default Value:  ""

### MEDIA_SERVER__SECRET_HASH

Allows setting of OAuth secret hash via the environment. Overrides any
hashes found in `credentials.ini`.

Default Value:  ""

### MEDIA_SERVER__AUTH_HEADERS

Allows setting of OAuth headers via the environment. Overrides any
headers found in `credentials.ini`.

Default Value:  "Content-Type=application/x-amz-json-1.1,X-Amz-Target=AWSCognitoIdentityProviderService.InitiateAuth"

### MEDIA_SERVER__AUTH_URL

Allows setting of OAuth URL via the environment. Overrides any
URLs found in `credentials.ini`.

Default Value:  ""

## Miscellaneous

### MEDIA_SERVER__ALLOW_OPERATOR_OVERRIDE

Allow overrides of the operator ID

Default Value:  false

### MEDIA_SERVER__DEFAULT_OPERATOR_ID

Default operator ID

Default Value:  00000000-0000-0000-0000-000000000000

### MEDIA_SERVER__USE_TLS

Toggle to use TLS between the Media Server and the Lumenvox API.

Default Value: true

### MEDIA_SERVER__HOST_MAP

Configure hosts file for unregistered domains

Default Value:  lumenvox-api.testmachine.com:127.0.0.1

### MEDIA_SERVER__SAVE_WAVEFORM

Activate the save-waveform functionality

Default Value:  false

### MEDIA_SERVER__WAVEFORM_URL_PREFIX

URL prefix for saved waveforms, i.e. "https://test.com/"

Default Value:  ""

### MEDIA_SERVER__WAVEFORM_AUTO_CLEANUP

If true, delete saved waveforms at the end of the session.

Default Value: true

### MEDIA_SERVER__COMPATIBILITY_MODE

Compatibility mode for certain media server operations.

Default Value: 0

### MEDIA_SERVER__SSL_VERIFY_PEER

Set to false to disable ssl verify peer.

Default Value: true

### MEDIA_SERVER__SECURE_CONTEXT

Mask sensitive information in logs.

Default Value: false

### MANAGEMENT_ADDRESS

Management API listening address and port.

Default Value: 8085

### MANAGEMENT_CERT_PEM_FILE

Path to certificate PEM file. Leave empty to auto-generate.

Default Value: ""

### MANAGEMENT_KEY_PEM_FILE

Path to key PEM file. Leave empty to auto-generate.

Default Value: ""

### MANAGEMENT_USERS

Credentials for basic authentication. Leave empty to auto-generate.

Default Value: ""

### MEDIA_SERVER__SIP_PORT

The port on which the server will listen for incoming SIP messages.

Default Value: 5060

Possible Values: 0 = Disabled, 1 = Enabled

### MEDIA_SERVER__SIPS_PORT

The port on which the server will listen for incoming Secure SIP (SIPS) messages.

Default Value: 5061

Possible Values: 0 = Disabled, 1 = Enabled

### MEDIA_SERVER__RTSP_PORT

The port on which the server will listen for incoming RTSP messages.

Default Value: 554

Possible Values: 0 = Disabled, 1 = Enabled

### MEDIA_SERVER__RTSP_OUT_OF_SERVICE_CODE

When out_of_service is enabled this response code will be returned to RTSP clients to indicate that the Media Server is
out of service.

Default Value: 404

Possible Values: 404 = Not Found, 503 = Service Unavailable

### MEDIA_SERVER__SIP_OUT_OF_SERVICE_CODE

When out_of_service is enabled this response code will be returned to SIP clients to indicate that the Media Server is
out of service.

Default Value: 503

Possible Values: 480 = Temporarily Unavailable, 486 = Busy Here, 488 = Not Acceptable Here, 503 = Service Unavailable

### MEDIA_SERVER__REUSE_SIP_TCP_SOCKET

When enabled, media server will reuse the SIP TCP/TLS socket with SIP client for all future SIP calls.

Default Value: 0

Possible Values: 0 = Disabled, 1 = Enabled

### MEDIA_SERVER__SIP_RETRANSMISSION_INTERVAL

SIP retransmission interval in msec (SIP T1 timer). Media gateway will send the first retransmit message to the set
value and double until INVITE timeout. If set to 0, retransmission of SIP response messages is disabled.

Default Value: 0

Possible Values: 0 or 500-32000

### MEDIA_SERVER__RTP_PORT_BASE

Lowest numbered port that will be used for RTP/RTCP.

Default Value: 25000

### MEDIA_SERVER__MRCP_PORT_BASE

Lowest numbered port that will be used for MRCP.

Default Value: 20000

### MEDIA_SERVER__SIPS_SSL_CERT_FILE

Specifies full path to SSL certificate (*.pem) file to use in SIPS. By default, a dummy certificate will be used.

Default Value: ""

### MEDIA_SERVER__SIPS_CIPHER_LIST

Cipher List to use during SIPS SSL negotiation. If no cipher list is specified, the default cipher list specified by
OpenSSl be used.Use colons to separate cipher values - no spaces.

Default Value: ""

### MEDIA_SERVER__WIND_BACK_TIME

Amount of audio before voice activity has been detected that is sent to the speech recognition engine for decoding.
Increasing this value may help if call logs show clipping at the beginning of decoded audio.

Default Value: 480

### MEDIA_SERVER__BARGE_IN_TIMEOUT

Amount of non-speech audio (in milliseconds) streamed prior to the barge-in event that is required to trigger a barge-in
timeout event and cancel the stream.

Default Value: 15000

### MEDIA_SERVER__END_OF_SPEECH_TIMEOUT

Amount of speech audio (in milliseconds) streamed after the barge-in event that is required to trigger an end-of-speech
event, stop the stream and perform a recognition.

Default Value: 20000

### MEDIA_SERVER__VAD_STREAM_INIT_DELAY

Sets the amount of silence/noise/non speech data in milliseconds that can be guaranteed before the user starts speaking.
This time is used in initializing some parameters. The longer this value the better the estimate. It is recommended to
be 1 sec if that amount of data can be guaranteed to be non speech in the particular application.

Default Value: 100

### MEDIA_SERVER__BARGE_IN_THRESHOLD

Specifies how sure the VAD needs to be that the frame of data is speech before barge-in. The higher the value, the more
sure we need to be that the frame is speech before barge-in.

Default Value: 50

Possible Values: 0-100

### MEDIA_SERVER__USE_SPEECH_INCOMPLETE

When enabled the Media Server will use the greater of either speech-complete-timeout or speech-incomplete-timeout. When
disabled, speech-incomplete-timeout will be ignored and timing will be based on speech-complete-timeout alone.

Default Value: 0

Possible Values: 0 = Disabled, 1 = Enabled

### MEDIA_SERVER__ENABLE_RTSP_IDLE_TIMEOUT

Detects RTSP connections that remain idle after 10 second if enabled and will drop the connection in such cases. If
disabled, no such check is performed, meaning the client application is responsible for cleaning such idle
connections.

Default Value: 0

Possible Values: 0 = Disabled, 1 = Enabled

### MEDIA_SERVER__RECOGNIZER_RESOURCE_URL

Default URL path specified for recognizer resources.

Default Value: /media/speechrecognizer

### MEDIA_SERVER__SYNTHESIZER_RESOURCE_URL

Default URL path specified for synthesizer resources.

Default Value: /media/synthesizer

### MEDIA_SERVER__FORCE_INCREMENT_RTSP_CSEQ

When enabled, RTSP CSeq numbers will be incremented for server-originated packets. If disabled, the CSeq will correspond
to the original request.

Default Value: 0

Possible Values: 0 = Disabled<br> 1 = Enabled

### MEDIA_SERVER__SEND_SIP_TRYING

Some clients may require the optional '100 TRYING' messages to be returned from INVITE requests prior to OK. Most
clients do not require this response. Set this to 1 (enabled) if you explicitly need these.

Default Value: 0

Possible Values: 0 = Disabled<br> 1 = Enabled

### MEDIA_SERVER__MRCP_TLS_CERT_FILE

Specifies full path to SSL certificate (*.pem) file to use in MRCPv2/TLS. By default, a dummy certificate will be used.
If specified, this should be the full path to a certificate (*.pem) file that should be used.

Default Value: ""

### MEDIA_SERVER__MRCP_CIPHER_LIST

Optional Cipher List to use during MRCPv2/TLS. If no cipher list is specified, the default cipher list specified by
OpenSSl be used. Use colons to separate cipher values - no spaces.

Default Value: ""

### MEDIA_SERVER__ALLOW_UNAUTHENTICATED_SRTP

When enabled, SIPS calls that specify UNAUTHENTICATED_SRTP in SDP crypto parameter will be allowed. If disabled, SIPS
calls that specify UNENCRYPTED_SRTP in all SDP crypto parameter will not be allowed.

Default Value: 1

Possible Values: 0 = Disabled, 1 = Enabled

### MEDIA_SERVER__ALLOW_UNENCRYPTED_SRTP

When enabled, SIPS calls that specify UNENCRYPTED_SRTP in SDP crypto parameter will be allowed. If disabled SIPS calls
that specify UNENCRYPTED_SRTP in all SDP crypto parameter will not be allowed.

Default Value: 1,

Possible Values: 0 = Disabled, 1 = Enabled

### MEDIA_SERVER__LOG_MAX_FILE_SIZE

The maximum size after which a log file will be backed up (if enabled) and a new log file started.

Default Value: 30000000

### MEDIA_SERVER__LOG_MAX_BACKUPS

This is the number of backup files that are rotated through once a log file passes MAX_LOG_FILE_SIZE. Backup files will
be named after the associated log file, with a numeric suffix and .backup, for example the first backup file for
media_server_app.txt will be media_server_app.0.backup

Default Value: 1

Possible Values: 0-50

### MEDIA_SERVER__LOG_MIN_FREE_DISK_SPACE

Minimum free disk space (MB) required before logs are written out to
disk.

Default: 100

Possible Values: 1+
