#!/bin/bash

ACTION=$1
shift

[[ "$ACTION"  == "create" ]] && add-branch $@ && exit 0
[[ "$ACTION"  == "remove" ]] && remove-branch $@ && exit 0
[[ "$ACTION"  == "pull_request" ]] && deploy-service $@ && exit 0
