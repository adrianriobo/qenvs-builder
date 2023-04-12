# Create images from container

## Windows 10 22h2-pro

This command will create an image with name (it-rhqp-win10-22h2-pro) on existing resource group, also it will output files:

* `image-id` holding the iamge id for the custom image
* `admin-pass` holding the admin pass for user rhqpadmin
* `password` holoding the pass for user rhqp

```bash
podman run -d --rm \
    -v $PWD:/output:Z \
    -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
    -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
    -e AWS_REGION="${TARGET_REGION}" \
    quay.io/rhqp/qenvs-builder:v0.0.1-azure-windows
```
