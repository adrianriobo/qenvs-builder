# Create images from container

## Windows_Server-2019-English-Full-HyperV-RHQE

This command will create an AMI with name (Windows_Server-2019-English-Full-HyperV-RHQE) on the target region, also it will output a file
`ami-id` holding the ami id for the custom image

```bash
podman run -d --rm \
    -v $PWD:/output:Z \
    -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
    -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
    -e AWS_REGION="${TARGET_REGION}" \
    quay.io/rhqp/qenvs-builder:v0.0.1-aws-windows
```

## Windows_Server-2019-Spanish-Full-HyperV-RHQE

This command will create an AMI with name (Windows_Server-2019-Spanish-Full-HyperV-RHQE) on the target region, also it will output a file
`ami-id` holding the ami id for the custom image

```bash
podman run -d --rm \
    -v $PWD:/output:Z \
    -e LOCALIZE=spanish \
    -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
    -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
    -e AWS_REGION="${TARGET_REGION}" \
    quay.io/rhqp/qenvs-builder:v0.0.1-aws-windows
```

## Windows_Server-2019-English-Full-OCPL-${CRC-VERSION}-RHQE

This command will create an AMI with name (Windows_Server-2019-English-Full-OCPL-${CRC-VERSION}-RHQE) on the target region, also it will output a file
`ami-id` holding the ami id for the custom image

```bash
podman run -d --rm \
    -v $PWD:/output:Z \
    -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
    -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
    -e AWS_REGION="${TARGET_REGION}" \
    -e CRC_VERSION="${CRC_VERSION}" \
    -e CRC_DISTRIBUTABLE_URL="${CRC_DISTRIBUTABLE_URL}" \
    quay.io/rhqp/qenvs-builder:v0.0.1-aws-windows
```

## Windows_Server-2019-Spanish-Full-OCPL-${CRC-VERSION}-RHQE

This command will create an AMI with name (Windows_Server-2019-Spanish-Full-OCPL-${CRC-VERSION}-RHQE) on the target region, also it will output a file
`ami-id` holding the ami id for the custom image

```bash
podman run -d --rm \
    -v $PWD:/output:Z \
    -e LOCALIZE=spanish \
    -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
    -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
    -e AWS_REGION="${TARGET_REGION}" \
    -e CRC_VERSION="${CRC_VERSION}" \
    -e CRC_DISTRIBUTABLE_URL="${CRC_DISTRIBUTABLE_URL}" \
    quay.io/rhqp/qenvs-builder:v0.0.1-aws-windows
```
