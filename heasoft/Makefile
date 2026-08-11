#=============================================================================#
# File Description:
#   Used for building HEASoft Docker image.
#=============================================================================#

IMAGE_NAME = heasoft
IMAGE_VERSION = 6.36
IMAGE_LABEL = v$(IMAGE_VERSION)

DOCKER = docker
#DOCKER = sudo docker

SHELL = tcsh

#HOST_MOUNT = /Users/user1/folder1
#IMAGE_MOUNT = /home/heasoft/folder1
#XHOST = /opt/X11/bin/xhost

image:
	@echo "Building Docker image ${IMAGE_NAME}:${IMAGE_LABEL}..."
	-$(DOCKER) build --network=host --build-arg version=$(IMAGE_VERSION) -t $(IMAGE_NAME):$(IMAGE_LABEL) .

latest: image
	@echo "Tagging Docker image ${IMAGE_NAME}:${IMAGE_LABEL} with latest..."
	-$(DOCKER) tag `$(DOCKER) image ls --format '{{.ID}}' $(IMAGE_NAME):$(IMAGE_LABEL)` $(IMAGE_NAME):latest

run:
	@echo "Running Docker image ${IMAGE_NAME}:${IMAGE_LABEL}..."
	docker run --rm -it --network=host ${IMAGE_NAME}:${IMAGE_LABEL} ${SHELL}
	#docker run --rm -it --network=host -e DISPLAY -v ${HOST_MOUNT}:${IMAGE_MOUNT} -v /FTP:/FTP:ro -v /tmp/.X11-unix:/tmp/.X11-unix:ro ${IMAGE_NAME}:${IMAGE_LABEL} ${SHELL}

# Alternate "run" target; this one mounts a host user volume and
# connects to the host display:
#
#run:
#	@echo "Running Docker image ${IMAGE_NAME}:${IMAGE_LABEL}..."
#	${XHOST} + 127.0.0.1
#	docker run --rm -it --network=host -e DISPLAY=host.docker.internal:0 -v ${HOST_MOUNT}:${IMAGE_MOUNT} ${IMAGE_NAME}:${IMAGE_LABEL} ${SHELL}
