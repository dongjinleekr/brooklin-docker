FROM openjdk:8u212-jre-alpine

ARG brooklin_version=1.0.0

LABEL maintainer="Lee Dongjin <dongjin@apache.org>"

ENV BROOKLIN_VERSION=$brooklin_version \
    BROOKLIN_HOME=/opt/brooklin \
    BROOKLIN_CONFIG=$BROOKLIN_HOME/config

ENV PATH=${PATH}:${BROOKLIN_HOME}/bin

COPY download-brooklin.sh start-brooklin.sh /tmp/

RUN apk add --no-cache bash curl jq docker \
 && chmod a+x /tmp/*.sh \
 && mv /tmp/start-brooklin.sh /usr/bin \
 && sync && /tmp/download-brooklin.sh \
 && tar xfz /tmp/brooklin-${BROOKLIN_VERSION}.tgz -C /opt \
 && rm /tmp/brooklin-${BROOKLIN_VERSION}.tgz \
 && ln -s /opt/brooklin-${BROOKLIN_VERSION} ${BROOKLIN_HOME} \
 && rm /tmp/*

COPY server.properties-default ${BROOKLIN_CONFIG}/server.properties

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-brooklin.sh"]

