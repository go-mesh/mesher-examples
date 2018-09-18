#!/bin/bash

set -x
set -e

SCRIPT_PATH=$(cd $(dirname $0);pwd)

kubectl delete -f ${SCRIPT_PATH}/apollo.yaml
kubectl delete -f ${SCRIPT_PATH}/servicecomb.yaml
kubectl delete -f ${SCRIPT_PATH}/namespace.yaml
