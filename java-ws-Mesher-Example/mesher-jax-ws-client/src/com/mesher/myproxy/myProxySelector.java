package com.mesher.myproxy;

import java.io.IOException;
import java.net.*;
import java.util.ArrayList;
import java.util.List;

public class myProxySelector extends ProxySelector {
    @Override
    public List<Proxy> select(URI uri) {
        List<Proxy> list = new ArrayList<Proxy>();
//         设置需要进行代理的地址，此处为mesher的host和port
        String address = "127.0.0.1";
        int port = 30101;
        InetSocketAddress socketAddress = new InetSocketAddress(address,port);
        Proxy proxy = new Proxy(Proxy.Type.HTTP,socketAddress);
        list.add(proxy);
        return list;
    }

    @Override
    public void connectFailed(URI uri, SocketAddress sa, IOException ioe) {

    }
}
