#!/usr/bin/env bash

function wait_for_service_domain_dns_change() {
    ### define looping criteria
    SLEEPYTIME=10;

    ### pre-verify DNS unless the environment suggests skipping
    if [ -n "$MEDIA_SERVER__SERVER_IP" ]; then
        ### state our intentions
        echo "[PRESTOP] Waiting for IP [$MEDIA_SERVER__SERVER_IP] to disappear from DNS [$1]..." > /proc/1/fd/1;

        ### loop while dig arbitrarily comes up empty or fails, or the IP still appears in dig output
        while true; do
            ### dig service DNS + analyze output to see if this IP still appears
            DIGRESULT=$( (dig A "$1") || echo 'DIGFAILED' );
            DIGNOERROR=$( (echo "$DIGRESULT" | grep -E 'status: NOERROR') || echo 'DIGFAILED' );
            GREPRESULT=$( (echo "$DIGRESULT" | grep -E "${MEDIA_SERVER__SERVER_IP:-NOLOCALIPV4}") || echo 'GREPFAILED' );

            ### ensure no dig output failures
            if [[ "$DIGRESULT" != 'DIGFAILED' && "$DIGNOERROR" != 'DIGFAILED' ]]; then
                ### verify grep failures
                if [[ "$GREPRESULT" == 'GREPFAILED' ]]; then
                    ### state our intentions
                    echo "[PRESTOP] IP [$MEDIA_SERVER__SERVER_IP] disappeared from DNS [$1]!" > /proc/1/fd/1;

                    ### break out of infinite while loop
                    break;
                else
                    ### state our intentions
                    echo "[PRESTOP] IP [$MEDIA_SERVER__SERVER_IP] still appears in DNS [$1]!" > /proc/1/fd/1;
                fi;
            else
                ### state our intentions
                echo "[PRESTOP] Dig of DNS [$1] failed!" > /proc/1/fd/1;
            fi;

            ### state our intentions
            echo "[PRESTOP] Retrying in $SLEEPYTIME seconds..." > /proc/1/fd/1;

            ### sleep for a little bit
            sleep $SLEEPYTIME;
        done;
    else
        echo "[PRESTOP] Skipping DNS verification!" > /proc/1/fd/1;
    fi;
}
