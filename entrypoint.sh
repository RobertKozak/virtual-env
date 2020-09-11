#!/bin/bash

ACTION=$1
shift

BRANCH=( "${@}" )
BRANCH=( "${BRANCH[@]:0}" )

if [[ "$BRANCH" =~ "kube" ]] || [[ "$BRANCH" =~ "system" ]] || [[ "$BRANCH" == "default" ]] || [[ "$BRANCH" == "apps" ]] || [[ "$BRANCH" =~ "services" ]] || \
   [[ "$BRANCH" == "dev" ]] || [[ "$BRANCH" == "smoke" ]] || [[ "$BRANCH" == "staging" ]] || [[ "$BRANCH" == "qa" ]] || [[ "$BRANCH" == "prod" ]] || [[ "$BRANCH" == "pool" ]]; then

   echo "ERROR: Branch '$BRANCH' is a protected value. Branch names like the following cannot be used for Virtual Environments: kube*, *system, default, dev, smoke, staging, qa, prod, apps, *services, pool"
   exit 1
fi

[[ "$ACTION"  == "create" ]] && add-branch $@ && exit 0
[[ "$ACTION"  == "delete" ]] && remove-branch $@ && exit 0
[[ "$ACTION"  == "push" ]] && deploy-service $@ && exit 0
