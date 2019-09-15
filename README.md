[![Docker Pulls](https://img.shields.io/docker/pulls/dongjinleekr/brooklin.svg)](https://hub.docker.com/r/dongjinleekr/brooklin)
[![Docker Stars](https://img.shields.io/docker/stars/dongjinleekr/brooklin.svg)](https://hub.docker.com/r/dongjinleekr/brooklin)

brooklin-docker
=====

Dockerfile for [Linkedn Brooklin](https://github.com/linkedin/brooklin).

This project is an brookin-equivalent of [kafka-docker](https://github.com/wurstmeister/kafka-docker), which provides a docker image of [Apache Kafka](https://kafka.apache.org/). The image is also available from [Docker Hub](https://hub.docker.com/r/dongjinleekr/brooklin).

# Quickstart

The following `docker-compose.yml` shows how to start up a brooklin cluster, consists of 1 zookeeper and 1 brooklin container, with one source kafka cluster (`kafka-1`) and one destination kafka cluster (`kafka-2`).

```yml
version: '3.6'
services:
  zookeeper:
    image: wurstmeister/zookeeper:3.4.6
    ports:
      - "2181:2181"
  brooklin-1:
    image: dongjinleekr/brooklin:latest
    ports:
      - "32311:32311"
    environment:
      BROOKLIN_CLUSTER_NAME: brooklin-quickstart
      BROOKLIN_ZOOKEEPER_CONNECT: zookeeper:2181
      BROOKLIN_HTTP_PORT: 32311
      KAFKA_TP_BOOTSTRAP_SERVERS: kafka-2:9093
      KAFKA_TP_ZOOKEEPER_CONNECT: kafka-zookeeper-2:2181
      KAFKA_TP_CLIENT_ID: brooklin-producer-1
  kafka-zookeeper-1:
    image: wurstmeister/zookeeper:3.4.6
  kafka-1:
    image: wurstmeister/kafka:2.12-2.3.0
    ports:
      - "9092:9092"
    environment:
      HOSTNAME_COMMAND: "route -n | awk '/UG[ \t]/{print $$2}'"
      KAFKA_LISTENERS: PLAINTEXT://:9092
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://_{HOSTNAME_COMMAND}:9092
      KAFKA_ZOOKEEPER_CONNECT: kafka-zookeeper-1:2181
      KAFKA_CREATE_TOPICS: "first-topic:1:1,second-topic:1:1,third-topic:1:1"
  kafka-zookeeper-2:
    image: wurstmeister/zookeeper:3.4.6
  kafka-2:
    image: wurstmeister/kafka:2.12-2.3.0
    ports:
      - "9093:9093"
    environment:
      HOSTNAME_COMMAND: "route -n | awk '/UG[ \t]/{print $$2}'"
      KAFKA_LISTENERS: PLAINTEXT://:9093
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://_{HOSTNAME_COMMAND}:9093
      KAFKA_ZOOKEEPER_CONNECT: kafka-zookeeper-2:2181
      KAFKA_CREATE_TOPICS: "test:1:1"
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

