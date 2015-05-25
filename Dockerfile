# logstash-forwarder - A tool to collect logs locally in preparation for processing elsewhere!
#
# VERSION 0.4.0

FROM debian:jessie

MAINTAINER Pasang Sherpa "https://github.com/pasangsherpa"

# Install logstash-forwarder and curl
RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4 \
    && echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | tee /etc/apt/sources.list.d/logstashforwarder.list \
    && apt-get update; apt-get install -y logstash-forwarder

# Clean up apt-get mess
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Include logstash-forwarder in the PATH
ENV PATH /opt/logstash-forwarder/bin:$PATH

CMD ["logstash-forwarder", "-config=/opt/conf/logstash-forwarder.conf"]