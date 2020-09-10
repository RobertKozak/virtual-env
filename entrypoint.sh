#!/bin/bash

ACTION=$1
shift

[[ "$ACTION"  == "create" ]] && add-branch $@ && exit 0
[[ "$ACTION"  == "remove" ]] && remove-branch $@ && exit 0
[[ "$ACTION"  == "deploy" ]] && deploy-service $@ && exit 0
