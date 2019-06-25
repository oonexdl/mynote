# Install Docker

As personal development, it's free to use Docker Community Edition(Docker CE).

[install](https://docs.docker.com/engine/installation/linux/ubuntu/)

Ensure use docker without sudo

```
sudo usermod -aG docker ${USER}
```

# Install Docker-compose

```
sudo curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
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
docker build --build-arg http_proxy=http://my.proxy.url --tag $(registry-host)/$(REPOSITORY):$(TAG) .
```

### Manage Volume

```shell
# show all volumes by docker management
docker volume ls
# remove all volumes not referenced with any containers
docker prune
```

# Dockerfile

## 如何选择基础镜像

alpine 还是 phusion/baseimage-docker?

后者主要解决了 unix zombie process 的问题，除此之外，还提供了 syslog-ng，sshd 等后台服务。镜像也因此变得臃肿，总之性价比略低。实际上在 alpine 的较新的版本里，内置的 /sbin/tini 命令已经可以解决僵尸进程的问题。另外 alpine 镜像简单，安全，体积小，不内置任何 daemon service，自带的 package 可以满足大部分依赖需求。这意味着给与了开发者更大的灵活性，keep simple，keep flexible。

```
REPOSITORY                            TAG                 IMAGE ID            CREATED             SIZE
ubuntu                                18.04               4c108a37151f        3 days ago          64.2MB
phusion/baseimage                     latest              166cfc3f6974        17 months ago       209MB
alpine                                latest              4d90542f0623        2 days ago          5.58MB
```

## multi-stage builds

https://docs.docker.com/develop/develop-images/multistage-build/




