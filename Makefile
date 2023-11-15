VERSION ?= 0.0.1
CONTAINER_MANAGER ?= podman
# Image URL to use all building/pushing image targets
IMG ?= quay.io/rhqp/qenvs-builder:v${VERSION}

# Build the container image
.PHONY: build-aws-windows
build-aws-windows: 
	${CONTAINER_MANAGER} build -t ${IMG}-aws-windows -f windows/aws/oci/Containerfile .
.PHONY: build-azure-windows
build-azure-windows: 
	${CONTAINER_MANAGER} build -t ${IMG}-azure-windows -f oci/Containerfile azure
.PHONY: build
build: build-aws-windows build-azure-windows

# Push the container image
.PHONY: push-aws-windows
push-aws-windows:
	${CONTAINER_MANAGER} push ${IMG}-aws-windows
.PHONY: push-azure-windows
push-azure-windows:
	${CONTAINER_MANAGER} push ${IMG}-azure-windows
.PHONY: push
push: push-aws-windows push-azure-windows