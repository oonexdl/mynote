# basic usage

### get images

1. config register-mirror to accelerate

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

### manage images

```shell
# list all images include intermediate layers only with numeric IDs
docker images -aq
# filter images with unused images
docker images --filter dangling=true
# list images with pretty format
docker images --format "{{ .ID | .Repository | .Tag | .Size }}"
# rm images
docker rmi ${IMAGEIDS}
# rm 10 unused images
docker rmi $(docker images -q --filter dangling=true | head -n 10)
```

### manage containers

```shell
# start a container with interactive terminal, which will be deleted after exit 
# -v mount local file system to container
# -w set current workDir
# -p map container port to current host port
# -e set environment varaibles
# --network set container network mode, host means using current Host
docker run --it --rm -v localPath:containerPath -w currentWorkDir -p 9000:9001 -e MONGOURL=${MONGOURL} --network host ${IMAGE} bash
# list all containers with exited code is 0, more detailed just `RFTM`
docker ps -a --format="{{ .Status }} {{ .Names }}" --filter exited=0
# to be continued...
```

### build and push images

```shell
# use current dir for context and Dockerfile
# image names
docker build --tag $(registry-host)/$(REPOSITORY):$(TAG) .
docker push $(registry-host)/$(REPOSITORY):$(TAG)
```

