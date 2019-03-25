# FROM 201777367430.dkr.ecr.us-east-1.amazonaws.com/ref1.5/release/platform/infrastructure/docker-base-jmeter:latest-0
FROM jmeter/base:latest

# Ports to be exposed from the container for JMeter Slaves/Server
EXPOSE 1099 50000

# Application to run on starting the container
# AWS_HOST_PUBLIC_IP to be passed in as -e variable with docker run command
ENTRYPOINT $JMETER_HOME/bin/jmeter-server \
                        -Dserver.rmi.ssl.disable=true \
                        -Dserver.rmi.localport=50000 \
                        -Dserver_port=1099 \
                        -Djava.rmi.server.hostname=$AWS_HOST_PUBLIC_IP

USER ebsco:ebsco