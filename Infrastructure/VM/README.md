### Run on a VM Infrastructure as a Process

To run Go-Mesher-Example example as a process on VM you need to 2 VM's to run the Provider and Consumer

```

|--------------VM-1---------------|                   |--------------VM-2---------------|
|                                 |                   |                                 |
|           Client                |                   |             Server              |
|                                 |                   |                                 |
|                                 |                   |                                 |
|       Mesher Consumer           |                   |          Mesher-Provider        |
|                                 |                   |                                 |
|---------------------------------|                   |---------------------------------|
```

##### Step 1 (Both the VM's)
Clone this repo
```
git clone https://github.com/go-mesh/mesher-examples
cd mesher-examples
export WORKSPACE=$PWD
```

##### Step 2 (VM-1 or VM-2)
Run the Service-Center using the guide given [here](https://github.com/apache/incubator-servicecomb-service-center#quick-start) (Remember to expose the ports of Service-Centre so that is accessible from both the machine). After service-center comes up succesfully then store the service-center ip in env varibale in both the machine.
```go
export SERVICE_CENTER_ADDR=SCIP (http://127.0.0.1:30100)
```

##### Step 3 (VM-1)
Start Client
```go
cd $WORKSPACE/Go-Mesher-Example/scripts
# ./start.sh COMPONENT_NAME ROOT_DIR
./start.sh client $WORKSPACE
```

##### Step 4 (VM-1)
Start Mesher-Consumer
```go
cd $WORKSPACE/Go-Mesher-Example/scripts
# ./start.sh COMPONENT_NAME ROOT_DIR SERVICE_CENTER_IP
./start.sh mesher-consumer $WORKSPACE $SERVICE_CENTER_ADDR
```


##### Step 5 (VM-2)
Start Server
```go
cd $WORKSPACE/Go-Mesher-Example/scripts
# ./start.sh COMPONENT_NAME ROOT_DIR
./start.sh server $WORKSPACE
```


##### Step 6 (VM-2)
Start Mesher-Provider
```go
cd $WORKSPACE/Go-Mesher-Example/scripts
# ./start.sh COMPONENT_NAME ROOT_DIR SERVICE_CENTER_IP PROVIDER_NAME SEPCIFIC_PORT
./start.sh mesher-provider $WORKSPACE $SERVICE_CENTER_ADDR Server rest:3001
```

##### Step 7
You can verify the Client using below url.

Make sure you unset all the proxy, before you executed curl(you can open a new ssh session)
```
curl -v http://127.0.0.1:3000/TestLatency
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
The h
