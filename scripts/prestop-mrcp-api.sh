#!/usr/bin/env bash

### set bash operating arguments
set -e -o pipefail;

### load common functions
source /root/prestop-common-functions.sh;

### define service domain for interrogating DNS
SERVICE_DOMAIN="lumenvox.service.consul";

### if necessary, first drain the local pod IP from Kubernetes Service DNS
wait_for_service_domain_dns_change $SERVICE_DOMAIN;

### terminate cleanly so the container may receive SIGTERM
exit 0;
