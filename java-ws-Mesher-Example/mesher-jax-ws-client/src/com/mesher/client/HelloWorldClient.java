package com.mesher.client;


import com.mesher.myproxy.myProxySelector;
import com.mesher.ws.HelloWorld;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import java.net.ProxySelector;
import java.net.URL;

public class HelloWorldClient {

    public static String callJAXWS(String name,String mesher) throws Exception {
        ProxySelector.setDefault(new myProxySelector());
        URL url = new URL(" http://" + mesher + ":8888/ws/hello?wsdl");
        QName qname = new QName("http://ws.mesher.com/", "HelloWorldImplService");

        Service service = Service.create(url, qname);
        HelloWorld hello = service.getPort(HelloWorld.class);

        return hello.helloWorld(name);

    }
}

