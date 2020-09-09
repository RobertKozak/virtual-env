#!/bin/bash

# Get some local keys and crednetials and send in to Docker build as build-args
SSH_KEY=$(cat ~/.ssh/id_rsa)
VAULT_PASSWORD_FILE=$(cat $HOME/vault-password)

docker build --build-arg SSH_PRIVATE_KEY="$SSH_KEY" -t chromeriver/virtual-env --no-cache .
