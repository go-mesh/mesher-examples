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

## Configure mesher with Apollo ConfigCenter

[Apollo](https://github.com/ctripcorp/apollo) is an open source configuration center. We implement mesher's open configuration source interface to read config items from Apollo. When installation is finished, the apollo sever should be up and running. Configure the apollo service with NodePort IP or LoadBalancer to make sure you can access the apollo website's port `8070`, login with username "apollo" and password "admin". The following is the apollo related configs in the injected mesher:

```yaml
config:
  client:
    type: apollo
    serverUri: http://apollo.servicecomb:8080
    refreshMode: 1
    refreshInterval: 30
    autodiscovery: false
    serviceName: hybrid-example  # The project-id in apollo
    env: DEV # The environment in apollo
    cluster: default # The cluster in apollo
    namespace: application # The namespace in apollo
```

So now we create a new apollo project with ID `hybrid-example:`

![apollo-project](/hybrid/docs/apollo-create-project.png)

Add some new configs and publish the project, to enable mesher's governance abilities like rate limiting, routing, etc. Please refer to the [example](https://github.com/asifdxtreme/chassis-apollo-example) for more details and have fun! 

## Clean up

```bash
cd hybrid/infrastructure/kubernetes
kubectl delete -f example.yaml
bash -x uninstall.sh
```
