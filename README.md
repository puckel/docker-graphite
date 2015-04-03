## Graphite and Grafana Dockerfile

This repository contains **Dockerfile** of [Graphite](https://github.com/graphite-project) & [Grafana](http://grafana.org/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/puckel/docker-graphite/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [puckel/docker-base](https://registry.hub.docker.com/u/puckel/docker-base/)


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/puckel/docker-graphite/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull puckel/docker-graphite`

Alternatively, you can build an image from [Dockerfile](https://github.com/puckel/docker-graphite/)


### Usage

You need an elasticsearch instance to store dashboards : `docker pull puckel/docker-elasticsearch` and add --link elasticsearch:elasticsearch to docker run command)
For InfluxDB, you have to start the instance with a link to influxdb instance `--link influxdb:influxdb` (`docker pull puckel/docker-influxdb`)

Note : `docker pull puckel/collectd` for a container running collectd.

```bash
    docker run -d \
        -p 9090:80 \
        -p 8080:8080 \
        -p 2003:2003 \
	--link influxdb:influxdb
	--link elasticsearch:elasticsearch
        --name graphite \
        puckel/graphite
```

This starts a Docker container named: graphite

Then point your browser to : [Graphite-web](http://localhost:8080) or [Grafana](http://localhost:9090)
