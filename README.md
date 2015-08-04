## Graphite Dockerfile

This repository contains **Dockerfile** of [Graphite](https://github.com/graphite-project) and [Statsite](http://armon.github.io/statsite) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/puckel/docker-graphite/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [puckel/docker-base](https://registry.hub.docker.com/u/puckel/docker-base/)


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/puckel/docker-graphite/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull puckel/docker-graphite`

Alternatively, you can build an image from [Dockerfile](https://github.com/puckel/docker-graphite/)


### Usage

```bash
  docker run -ti --rm \
  -p 8080:80 \
  -p 2003:2003 \
  -p 8125:8125 \
  --name graphite \
  puckel/docker-graphite
```

This starts a Docker container named: graphite

Then point your browser to : [Graphite](http://localhost:8080)
