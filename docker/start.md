# Install

As personal development, it's free to use Docker Community Edition(Docker CE).

[install](https://docs.docker.com/engine/installation/linux/ubuntu/)

Ensure use docker without sudo

```
sudo usermod -aG docker ${USER}
```

# Basic Usage

### Get Images

1. config register-mirror to accelerate

[aliyun console](https://cr.console.aliyun.com)

docker version is higer than 1.10

```shell
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://******.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

docker version is lower than 1.10

```shell
MIRROR="url get from aliyun mirror" sudo echo """
DOCKER_OPTS="$DOCKER_OPTS --dns 114.114.114.114"
DOCKER_OPTS="$DOCKER_OPTS --registry-mirror=${MIRROR}"
""" >> /etc/default/docker
/etc/init.d/docker restart
```

2. pull from docker-hub

```shell
docker pull ${REPOSITORY}:${LABEL}
```

### Manage Images

```shell
# list all images include intermediate layers only with numeric IDs
docker images -aq
# filter images with unused images
# more filter in https://docs.docker.com/edge/engine/reference/commandline/images/#filtering
docker images --filter dangling=true
# list images with pretty format
docker images --format "{{ .ID | .Repository | .Tag | .Size }}"
# rm images
docker rmi ${IMAGEIDS}
# rm 10 unused images
docker rmi $(docker images -q --filter dangling=true | head -n 10)
```

### Manage Containers

```shell
# start a container with interactive terminal, which will be deleted after exit
# -v mount local file system to container
# -w set current workDir
# -p map container port to current host port
# -e set environment varaibles
# --network set container network mode, host means using current Host
docker run --it --rm -v localPath:containerPath -w currentWorkDir -p 9000:9001 -e MONGOURL=${MONGOURL} --network host ${IMAGE} bash
# list all containers with exited code is 0, more detailed just `RFTM`
docker ps -a --format "{{ .Status }} {{ .Names }}" --filter exited=0
# scan container detailt info
docker inspect --format "{{ .Status }} {{ .Names }}" ${container}
```

### Build and Push Images

```shell
# use current dir for context and Dockerfile
# image names
docker build --tag $(registry-host)/$(REPOSITORY):$(TAG) .
docker push $(registry-host)/$(REPOSITORY):$(TAG)

# build image after http proxy, gfw you know...
docker build -build-arg http_proxy=http://my.proxy.url --tag $(registry-host)/$(REPOSITORY):$(TAG) .
```

### Manage Volume

```shell
# show all volumes by docker management
docker volume ls
# remove all volumes not referenced with any containers
docker prune
```
