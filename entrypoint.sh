#!/bin/bash

set -e

# Add logstash-forwarder as command if needed
if [[ "$1" == -* ]]; then
    set -- logstash-forwarder "$@"
else 
    # Run as user "logstash-forwarder" if the command is "logstash-forwarder"
    if [ "$1" == 'logstash-forwarder' ]; then
        set -- gosu logstash-forwarder "$@"
    else
        # As argument is not related to logstash-forwarder,
        # then assume that user wants to run their own process,
        # for example a `bash` shell to explore this image
        exec "$@"
    fi
fi

# Use default config if config is not provided
if [[ "$*" == *-config* ]]; then
    exec "$@"
else 
    exec "$@" -config /opt/conf/logstash-forwarder.conf
fi
