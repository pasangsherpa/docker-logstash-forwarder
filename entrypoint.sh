#!/bin/bash

set -e

# Add logstash-forwarder as command if needed
if [[ "$1" == -* ]]; then
    set -- logstash-forwarder "$@"
fi

# Run as user "logstash-forwarder" if the command is "logstash-forwarder"
if [ "$1" == logstash-forwarder ]; then
    set -- gosu logstash-forwarder "$@"
fi

# Add default config if not set
if [[ $* == *-config* ]]; then
    exec "$@"
else 
    exec "$@" -config /opt/conf/logstash-forwarder.conf
fi
