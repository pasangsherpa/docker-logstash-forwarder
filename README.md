# [logstash-forwarder](https://github.com/pasangsherpa/logstash-forwarder)

> Dockerized Logstash Forwarder: A tool to collect logs locally in preparation for processing elsewhere!

[https://github.com/elastic/logstash-forwarder](https://github.com/elastic/logstash-forwarder)

If you want the ELK stack, checkout [elk-stack](https://github.com/pasangsherpa/elk-stack).

### Pull Image from [Docker Hub Registry][1].

    docker pull pasangsherpa/logstash-forwarder

### Run and test

    # The container runs as 'logstash-forwarder' executable. 
    docker run -i --rm pasangsherpa/logstash-forwarder -h

    # Read logs from stdin
    docker run -i --rm -v `pwd`/config/conf-stdin:/opt/conf \
                       -v `pwd`/config/certs:/opt/certs \
                       pasangsherpa/logstash-forwarder
    test stdin
    test stdin
    ^C

    # Pipe logs to stdin from node server using debug module
    DEBUG=test:server npm start | docker run -i --rm \
                        -v `pwd`/config/conf-stdin:/opt/conf \
                        -v `pwd`/config/certs:/opt/certs \
                        pasangsherpa/logstash-forwarder

    # Read logs from a file
    docker run --name forwarder -d \
               -v /var/log/test:/var/log \
               -v `pwd`/config/conf:/opt/conf \
               -v `pwd`/config/certs:/opt/certs \
               pasangsherpa/logstash-forwarder

    cat >> /var/log/test/test.log
    test file
    test file
    ^C

    # Stop and remove container
    docker rm $(docker stop forwarder)

    Log in to the Kibana interface, you should see the logs 3 test messages there.

### Volumes:

    /opt/conf  - Configuration folder with logstash-forwarder.conf
    /opt/certs - Certs folder with logstash-forwarder.crt and logstash-forwarder.key (used to start logstash)

Example logstash-forwarder.conf. *NOTE: Replace '<logstash_server_fqdn>' with your logstash server dns.*

    {
      "network": {
        "servers": [ "<logstash_server_fqdn>:5000" ],
        "ssl ca": "/opt/certs/logstash-forwarder.crt", # ssl cert generated in logstash server
        "timeout": 15
      },
      "files": [
        {
          "paths": [ "/var/log/test.log" ]
        }
      ]
    }

### Generating ssl certificate in the logstash server

    cd /etc/pki/tls;
    sudo openssl req -subj '/CN=<logstash_server_fqdn>/' -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt


## License

[MIT](http://opensource.org/licenses/MIT) © [Pasang Sherpa](https://github.com/pasangsherpa)


[1]: https://registry.hub.docker.com/u/pasangsherpa/kibana/