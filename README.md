[![Docker Pulls](https://img.shields.io/docker/pulls/dongjinleekr/brooklin.svg)](https://hub.docker.com/r/dongjinleekr/brooklin)
[![Docker Stars](https://img.shields.io/docker/stars/dongjinleekr/brooklin.svg)](https://hub.docker.com/r/dongjinleekr/brooklin)

brooklin-docker
=====

Dockerfile for [Linkedn Brooklin](https://github.com/linkedin/brooklin).

This project is an brookin-equivalent of [kafka-docker](https://github.com/wurstmeister/kafka-docker), which provides a docker image of [Apache Kafka](https://kafka.apache.org/). The image is also available from [Docker Hub](https://hub.docker.com/r/dongjinleekr/brooklin).

# Quickstart

The following `docker-compose.yml` shows how to start up a brooklin cluster, consists of 1 zookeeper and 1 brooklin container.

```yml
version: '3.6'

services:
  zookeeper:
    image: wurstmeister/zookeeper:3.4.6
    ports:
      - "2181:2181"
  brooklin:
    image: dongjinleekr/brooklin:latest
    ports:
      - "32311:32311"
    environment:
      BROOKLIN_CLUSTER_NAME: brooklin-quickstart
      BROOKLIN_ZOOKEEPER_CONNECT: zookeeper:2181
      BROOKLIN_HTTP_PORT: 32311
```

# Environment Variables

You can customize your docker containers by setting the following environment variables.

- `BROOKLIN_CLUSTER_NAME`: The name of the Brooklin cluster. (Required)
- `BROOKLIN_ZOOKEEPER_CONNECT`: Connection string to the backing zookeeper ensemble. (Required)
- `BROOKLIN_HTTP_PORT`: HTTP port for administration. (32311 by default)

As of 1.0.0-2, the name of the connectors and transport providers are fixed and only some of their are configurable:

| Category | Class | Name | Options |
|:-----------------:|:-----------------------------:|:---------------:|--------------------------------------------------------------------------------|
| Connector | `TestEventProducingConnector` | testC |  |
| Connector | `FileConnector` | fileC |  |
| Connector | `DirectoryConnector` | dirC |  |
| Connector | `KafkaConnector` | kafkaC |  |
| Connector | `KafkaMirrorMakerConnector` | kafkaMirroringC |  |
| TransportProvider | `DirectoryTransportProvider` | dirTP |  |
|  |  |  | - `KAFKA_TP_BOOTSTRAP_SERVERS`: Bootstrap servers to the target kafka cluster. (default: `localhost:9092`) |
| TransportProvider | `KafkaTransportProvider` | kafkaTP | - `KAFKA_TP_ZOOKEEPER_CONNECT`: Connection string to the target kafka cluster's Zookeeper cluster. (default: `localhost:2181`) |
|  |  |  | - `KAFKA_TP_BOOTSTRAP_SERVERS`: - `KAFKA_TP_CLIENT_ID`: Kafka client id to produce messages. (default: `datastream-producer`) |

# Versions

This project follows the following versioning scheme: `{brooklin-version}-{image-version}`. For example, `1.0.0-2` means the 2nd release of brooklin `1.0.0`.

# License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)

