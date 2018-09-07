### Running this example using docker compose

To run this example using docker compose you can execute the following commands

##### Step 1
Clone the code
```
git clone https://github.com/go-mesh/mesher-examples
cd Go-Mesher-Example
```

##### Step 2
Run Docker-Compose to bring up all the containers
```
docker-compose up
```
This will bring up Service-Center, Client, Server, MesherConsumer, MesherProvider, Zipkin, Grafana and Prometheus in docker container.

```
docker ps
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                                     NAMES
8b6fbb867fbe        grafana/grafana              "/run.sh"                About an hour ago   Up About a minute   0.0.0.0:3000->3000/tcp                    mesherexample_MyGrafana_1
64807af12545        my-prometheus:latest         "/bin/prometheus -..."   About an hour ago   Up About a minute   0.0.0.0:9090->9090/tcp                    mesherexample_MyPrometheus_1
86c9c7e08ba0        client:latest                "/bin/sh -c /go/bi..."   About an hour ago   Up About a minute                                             mesherexample_Client_1
9fe6511b3ce7        server:latest                "/bin/sh -c /go/bi..."   About an hour ago   Up 11 seconds                                                 9fe6511b3ce7_mesherexample_Server_1
b93251fbdca8        mesher-consumer:latest       "/opt/mesher/start..."   About an hour ago   Up About a minute   0.0.0.0:9000->3000/tcp                    mesherexample_MesherConsumer_1
781e3ea3f1dd        mesher-provider:latest       "/opt/mesher/start..."   About an hour ago   Up About a minute                                             mesherexample_MesherProvider_1
b99f4767be46        openzipkin/zipkin            "/bin/sh -c 'test ..."   About an hour ago   Up About a minute   9410/tcp, 0.0.0.0:9411->9411/tcp          mesherexample_MyZipkin_1
fd482f1b5ea7        servicecomb/service-center   "/root/start.sh"         About an hour ago   Up About a minute   2379-2380/tcp, 0.0.0.0:30100->30100/tcp   mesherexample_ServiceCenter_1

```

##### Step 3
You can verify the Client using below url
```
curl -v http://127.0.0.1:9000/TestLatency
*   Trying 127.0.0.1...
* Connected to 127.0.0.1 (127.0.0.1) port 9000 (#0)
> GET /TestLatency HTTP/1.1
> Host: 127.0.0.1:9000
> User-Agent: curl/7.47.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Date: Tue, 26 Dec 2017 16:52:35 GMT
< Content-Length: 110
< Content-Type: text/plain; charset=utf-8
< 
The Latency for this request is : 100ms
* Connection #0 to host 127.0.0.1 left intact
The host serving this request is 781e3ea3f1dd and the IP is 172.18.0.4
```
Client is available on http://localhost:9000  
The Service-center is running on http://localhost:30100  
The Zipkin Dashboard will be available on http://localhost:9411/zipkin/  
The Grafana Dashboard will be available on http://localhost:3000/dashboard/db/mesher-dashboard?refresh=5s&orgId=1  
Prometheus data is available on http://localhost:9090/graph


