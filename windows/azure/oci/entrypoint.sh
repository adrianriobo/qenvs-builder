#!/bin/sh

# create a random password
random_pass() {
    echo $(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')
} 



##########
## Main ##
##########

# Validate conf
VALID_CONFIG=true
if [ -z "${ARM_SUBSCRIPTION_ID+x}" ] || [ -z "${ARM_CLIENT_ID+x}" || [ -z "${ARM_CLIENT_SECRET+x}" ]; then 
  echo "AZURE ENVs for auth are required"
  VALID_CONFIG=false  
fi
if [ "${VALID_CONFIG}" = false ]; then
  echo "Add the required ENVs"
  exit 1
fi

set -exuo pipefail

# Generate credentials
ssh-keygen -t rsa -b 4096 -f id_rsa -N ""
admin_pass="].$(random_pass)"
password="$(random_pass)]."
# authorized_keys="$(cat id_rsa.pub)"

# Run packer
packer init .
build_vars="-var admin-pass=${admin_pass} -var password=${password}"
if [ ! -z "${VERSION+x}" ] ; then
  build_vars="${build_vars} -var version=${VERSION}"
fi
packer build ${build_vars} .

# Outputs
OUTPUT="${OUTPUT:-"/output"}"
mkdir -p "${OUTPUT}"
jq '(.builds[-1].artifact_id)' manifest.json > "${OUTPUT}/image-id"
cp manifest.json "${OUTPUT}/manifest.json"
cp id_rsa "${OUTPUT}/id_rsa"
echo "${admin_pass}" > "${OUTPUT}/admin-pass"
echo "${password}" > "${OUTPUT}/password"
