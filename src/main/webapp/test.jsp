<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
Request Metodu
JSP İstek Metodu: <%= request.getMethod() %>
İstek URI: <%= request.getRequestURI() %>
İstek Protokolü: <%= request.getProtocol() %>
Server Adı: <%= request.getServerName() %>
Server Port: <%= request.getServerPort() %>
Uzak Adres: <%= request.getRemoteAddr() %>
Uzak Host: <%= request.getRemoteHost() %>
Local: <%= request.getLocale() %>
Bulunduğun URL: <%=request.getRequestURL()%>
<%
    BufferedReader in = new BufferedReader(
            new InputStreamReader(request.getInputStream()));
    PrintWriter r = new PrintWriter(response.getOutputStream());

   // response.setContentType("application/json");

    String line = null;
    while((line = in.readLine()) != null) {
        r.printf("%s<br/>\r\n", line);
    }
    r.printf("emrah");

    r.flush();
%>