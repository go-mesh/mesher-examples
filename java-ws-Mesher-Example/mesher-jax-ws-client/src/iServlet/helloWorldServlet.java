package iServlet;

import com.mesher.client.HelloWorldClient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "helloWorldServlet", urlPatterns = {"/helloJAX"})
public class helloWorldServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws  IOException {
        PrintWriter out = response.getWriter();
        String name=  request.getParameter("name");
        String mesherName = request.getParameter("server");
        String result = "";
        try {
            result=    HelloWorldClient.callJAXWS(name,mesherName);
        } catch (Exception e) {
            out.println("call jax error"+e.getLocalizedMessage());
            e.printStackTrace();
        }
        response.setContentType("text/html");
        out.println("jxs hello world =>"+result);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
