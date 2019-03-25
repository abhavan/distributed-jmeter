FROM debian:sid-slim
# FROM 201777367430.dkr.ecr.us-east-1.amazonaws.com/platform/images/jre:latest

ARG JMETER_VERSION=apache-jmeter-5.0
ARG CMDRUNNER_VERSION=2.2
ARG PLUGINMGR_VERSION=1.3
ARG JRE_VERSION=11

ENV LANG=C.UTF-8 \
    JVM_ARGS="-Xms2G -Xmx2G"
    

RUN mkdir -p /usr/share/man/man1 && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates curl bzip2 unzip xz-utils openjdk-$JRE_VERSION-jre-headless && \
    rm -rf /var/lib/apt/lists/* && \
    addgroup --system --gid 501 ebsco && \
    adduser --system --uid 501 --gid 501 --disabled-password --disabled-login --home /opt/ebsco ebsco

WORKDIR /opt/ebsco

# Install jmeter, plugins manager and plugins (non-deprecated)
RUN curl -fsSL --compressed -o /tmp/jmeter.tgz https://archive.apache.org/dist/jmeter/binaries/$JMETER_VERSION.tgz \
    && tar -C /opt -xzf /tmp/jmeter.tgz \
    && rm /tmp/jmeter.tgz \
    && curl -fsSL --compressed -o /opt/$JMETER_VERSION/lib/ext/jmeter-plugins-manager.jar https://jmeter-plugins.org/get \
    && curl -fsSL --compressed -o /opt/$JMETER_VERSION/lib/cmdrunner-$CMDRUNNER_VERSION.jar http://central.maven.org/maven2/kg/apc/cmdrunner/$CMDRUNNER_VERSION/cmdrunner-$CMDRUNNER_VERSION.jar\
    && java -cp /opt/$JMETER_VERSION/lib/ext/jmeter-plugins-manager.jar org.jmeterplugins.repository.PluginManagerCMDInstaller \
    && /opt/$JMETER_VERSION/bin/PluginsManagerCMD.sh install-all-except jpgc-hadoop,jpgc-oauth \
    && sleep 2 \
    && /opt/$JMETER_VERSION/bin/PluginsManagerCMD.sh status

ENV JMETER_HOME=/opt/$JMETER_VERSION \
    PATH=/opt/$JMETER_VERSION/bin:$PATH

ENV JAVA_OPTS="-XX:PermSize=1024m -XX:MaxPermSize=512m"

USER ebsco:ebsco