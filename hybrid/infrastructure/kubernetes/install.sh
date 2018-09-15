#!/bin/bash

set -x
set -e

SCRIPT_PATH=$(cd $(dirname $0);pwd)

kubectl apply -f ${SCRIPT_PATH}/namespace.yaml

bash -x ${SCRIPT_PATH}/signed-cert.sh --service sidecar-injector-webhook-mesher-svc \
 --secret sidecar-injector-webhook-mesher-certs --namespace "servicecomb"

kubectl apply -f ${SCRIPT_PATH}/servicecomb.yaml
