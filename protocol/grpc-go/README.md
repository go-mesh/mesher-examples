# Go-Mesher-Example

This example illustrates the mesher integration with grpc 


## Getting Started

### Using DockerCompose

To run this example using docker compose you can execute the following commands

##### Step 1
Clone this repo
```
git clone https://github.com/go-mesh/mesher-examples
cd protocol/grpc-go/helloworld
```

##### Step 2
Run Docker-Compose to bring up all the containers
```
./launch.sh
```
This will bring up Service-Center, Client, Server, MesherConsumer, MesherProvider

```
 CONTAINER ID        IMAGE                        COMMAND                  CREATED              STATUS              PORTS                      NAMES
 865a08bb0b6d        client-grpc                  "/bin/sh -c /go/bin/…"   About a minute ago   Up About a minute                              helloworld_Client_1
 c9d6961e3170        server-grpc                  "/bin/sh -c /go/bin/…"   About a minute ago   Up About a minute                              helloworld_Server_1
 e41ed66b25bf        gochassis/mesher             "sh /opt/mesher/star…"   About a minute ago   Up About a minute   0.0.0.0:9000->3000/tcp     helloworld_MesherConsumer_1
 ebb6ea1ac117        gochassis/mesher             "sh /opt/mesher/star…"   About a minute ago   Up About a minute                              helloworld_MesherProvider_1
 e3fe6ea5cfdc        servicecomb/service-center   "/app/service-center"    9 minutes ago        Up About a minute   0.0.0.0:30100->30100/tcp   helloworld_ServiceCenter_1
```

##### Step 3
You can verify by log of client side, it interval access to server and print log
```
Greeting: Hello world
```

