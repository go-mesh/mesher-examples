package com.mesher.ws;

import javax.jws.WebService;


//
@WebService(endpointInterface = "com.mesher.ws.HelloWorld")
public class HelloWorldImpl implements HelloWorld {

    public String helloWorld (String name) {
        return "Hello World mesher -> JAX-WS :"+name;
    }
}
