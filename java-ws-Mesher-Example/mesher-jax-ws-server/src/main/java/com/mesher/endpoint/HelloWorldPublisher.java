package com.mesher.endpoint;

import com.mesher.ws.HelloWorldImpl;
import javax.xml.ws.Endpoint;

// EndPoint publisher
public class HelloWorldPublisher {
    public static void main(String[] args){

        try {
            Endpoint.publish("http://0.0.0.0:8888/ws/hello",new HelloWorldImpl());
            System.out.println("run success  ,listened  :  http://localhost:8888");
            System.out.println("wsdl :  http://localhost:8888/ws/hello?wsdl");
        } catch (Exception e) {
            System.out.println("run failure :"+e.getLocalizedMessage());
            e.printStackTrace();
        }
    }
}
