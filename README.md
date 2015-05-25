# [logstash-forwarder](https://github.com/elastic/logstash-forwarder)

> Dockerized Logstash Forwarder: A tool to collect logs locally in preparation for processing elsewhere!

### Pull Image from [Docker Hub Registry][1].

    docker pull pasangsherpa/logstash-forwarder

### Run and test

    mkdir /tmp/test && touch /tmp/test/test.log
    docker run --name forwarder -d -v /tmp/test:/tmp/test -v `pwd`/conf:/opt/conf -v `pwd`/certs:/opt/certs -t quay.io/concur_platform/logstash-forwarder

    cat >> /tmp/test/test.log
    test
    test
    test
    ^C

    Log in to the Kibana interface, you should see the logs 3 test messages there.

### Volumes:

    /opt/conf  - Configuration folder with config.json
    /opt/certs - Certs folder with logstash-forwarder.crt and logstash-forwarder.key (used to start logstash)

Example config.json

    {
      "network": {
        "servers": [ "logstash_server_fqdn:5000" ],
        "ssl certificate": "/opt/certs/logstash-forwarder.crt",
        "ssl key": "/opt/certs/logstash-forwarder.key",
        "ssl ca": "/opt/certs/logstash-forwarder.crt",
        "timeout": 15
      },
      "files": [
        {
          "paths": [ "/tmp/test/test.log" ],
          "fields": { "type": "stdin" }
        }
      ]
    }

### Generating ssl certificate in the logstash server

    cd /etc/pki/tls;
    sudo openssl req -subj '/CN=<logstash_server_fqdn>/' -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt


[1]: "https://registry.hub.docker.com/u/pasangsherpa/kibana/"