# java-ws-mesher-example

- This example illustrates the mesher integration with java webservices

1、Server

server only use java ws .you can run the server in endpoint pkg.

1.1 Launch server
```sh
cd mesher-jax-ws-server/src/main/java
./launch.sh
```

1.2 Test server

you can use `curl` to test server running or down
```sh
curl http://localhost:8888/ws/hello?wsdl
```
if you access `http://localhost:8888/ws/hello?wsdl` success,it is illustrates sever is running

2、Client

client is web project with servlet ,Use tomcat to start client .
 
 2.1 launch client
 
 Bale project into a war ball.Then put the client war pkg in the webapps directory
 under tomcat . use `start.bat` or `start.sh` to start tomcat 
 when client started you can access url `http://localhost:8080` will reply   `Hello world `.


Now server and client is running ,access `/helloJAX` with two query params .

e.g.
```sh
curl -G -d "name=jax-ws-mesher&server=mesher" http://localhost:8080/helloJAX
```
if access success will reply 
```sh
jxs hello world =>Hello World mesher -> JAX-WS :jax-ws-mesher
```