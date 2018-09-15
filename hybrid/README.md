hybrid
-----
   
This is a sample demo to deploy microservices with ServiceComb

## Introduce

Here we show how to deploy a `Hello World` application to kubernetes cluster.
In Hellowolrd, we show two kinds of ServiceComb micro-service technologies. 
Among them, `hello-consumer` is a PHP-based micro-service, which uses [`Mesher`](https://github.com/go-mesh/mesher) to access 
the ServiceComb manage plane, and `hello-provider` is a Java-based micro-service which developed
with [`Java-Chassis`](https://github.com/apache/incubator-servicecomb-java-chassis) framework,
it can directly access the manage plane.

![demo](/hybrid/docs/demo-with-servicecomb.png)

## Before you start

Ensure that the kubernetes server version is 1.9 or above
and make MutatingAdmissionWebhook controllers enabled.

See [`here`](https://github.com/go-mesh/sidecar-injector#prerequisites) for more details

## Quick start

Step 1 install ServiceComb components
```bash
cd hybrid/infrastructure/kubernetes
bash -x install.sh
```

Step 2 install demos
```bash
cd hybrid/infrastructure/kubernetes
kubectl apply -f example.yaml
```

## Confirm the installation is OK

```bash
# curl http://{consumer}:30180/consumer.php
"Hello World!"
```

## Clean up

```bash
cd hybrid/infrastructure/kubernetes
kubectl delete -f example.yaml
bash -x uninstall.sh
```
