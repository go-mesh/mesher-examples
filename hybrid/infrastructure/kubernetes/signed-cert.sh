#!/bin/bash

set -e

usage() {
    cat <<EOF
Generate certificate suitable for use with an sidecar-injector webhook service.
usage: ${0} [OPTIONS]
The following flags are required.
       --service          Service name of webhook.
       --namespace        Namespace where webhook service and secret reside.
       --secret           Secret name for CA certificate and server certificate/key pair.
EOF
    exit 1
}

while [[ $# -gt 0 ]]; do
    case ${1} in
        --service)
            service="$2"
            shift
            ;;
        --secret)
            secret="$2"
            shift
            ;;
        --namespace)
            namespace="$2"
            shift
            ;;
        *)
            usage
            ;;
    esac
    shift
done

[ -z ${service} ] && service=sidecar-injector-webhook-svc
[ -z ${secret} ] && secret=sidecar-injector-webhook-certs
[ -z ${namespace} ] && namespace=default

if [ ! -x "$(command -v openssl)" ]; then
    echo "openssl not found"
    exit 1
fi

csrName=${service}.${namespace}
tmpdir=$(mktemp -d)
echo "creating certs in tmpdir ${tmpdir} "

cat <<EOF >> ${tmpdir}/csr.conf
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no

[req_distinguished_name]
C = IN
ST = Karnataka
L = Bangalore
O = mesher
CN = mesher CA

[v3_req]
keyUsage = keyCertSign
basicConstraints = CA:TRUE
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${service}
DNS.2 = ${service}.${namespace}
DNS.3 = ${service}.${namespace}.svc
EOF

openssl req -newkey rsa:2048 -nodes -keyout ${tmpdir}/root-key.pem -x509 -days 36500 -out ${tmpdir}/root-cert.pem <<EOF
IN
Karnataka
Bangalore
mesher
Test
mesher CA
testrootca@mesher.io
EOF

openssl genrsa -out ${tmpdir}/ca-key.pem 2048

openssl req -new -key ${tmpdir}/ca-key.pem -out ${tmpdir}/ca-cert.csr -config ${tmpdir}/csr.conf -batch -sha256

openssl x509 -req -days 36500 -in ${tmpdir}/ca-cert.csr -sha256 -CA ${tmpdir}/root-cert.pem -CAkey ${tmpdir}/root-key.pem -CAcreateserial -out ${tmpdir}/ca-cert.pem -extensions v3_req -extfile ${tmpdir}/csr.conf

# create the secret with CA cert and server cert/key
kubectl create secret generic ${secret} \
        --from-file=${tmpdir}/ca-key.pem \
        --from-file=${tmpdir}/ca-cert.pem \
        --from-file=${tmpdir}/root-cert.pem \
        --dry-run -o yaml |
    kubectl -n ${namespace} apply -f -
