VERSION ?= 0.0.1
CONTAINER_MANAGER ?= podman
# Image URL to use all building/pushing image targets
IMG ?= quay.io/rhqp/qenvs-builder:v${VERSION}

# Build the container image
.PHONY: oci-build-aws-windows
oci-build-aws-windows: 
	${CONTAINER_MANAGER} build -t ${IMG}-aws-windows -f windows/oci/Containerfile aws

# Push the container image
.PHONY: oci-push-aws-windows
oci-push-aws-windows:
	${CONTAINER_MANAGER} push ${IMG}-aws-windows