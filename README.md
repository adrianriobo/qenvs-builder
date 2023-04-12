# qenvs-builder  

custom images to run on public cloud providers to support qenvs

## Overview

This folder contains severeal scripts to allow building images to improve spin up times, specially when the setups requires rebooting the machine.

## Windows

THis will setup a windows image with:

* create user with admin privileges
* setup autologin for the user
* sshd enabled  
* setup auth based on private key
* enable hyper-v  
* setup specific UAC levels to allow running privileged without prompt

**IMPORTANT** On booting the image it is required to add userdata to copy paste content for .ssh/authorized_keys with valid openssh public key to match the desired private key. THis setup only creates a fake file to emulate the behavior.  

### Create custom images

Following links show how to use this project for building custom images:

* on [aws](docs/windows/aws.md)
* on [azure](docs/windows/azure.md)  
