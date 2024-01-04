VERSION ?= 0.0.2
CONTAINER_MANAGER ?= podman
# Image URL to use all building/pushing image targets
IMG ?= quay.io/rhqp/qenvs-builder:v${VERSION}

# Build the container image
.PHONY: build-aws-windows
build-aws-windows: 
	${CONTAINER_MANAGER} build -t ${IMG}-aws-windows -f windows/aws/oci/Containerfile .

.PHONY: oci-build
oci-build: build-aws-windows 

# Push the container image
.PHONY: push-aws-windows
push-aws-windows:
	${CONTAINER_MANAGER} push ${IMG}-aws-windows

.PHONY: oci-push
oci-push: push-aws-windows 