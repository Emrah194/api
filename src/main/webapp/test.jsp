<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.JSONObject" %>

<%
    /*BufferedReader in = new BufferedReader(
            new InputStreamReader(request.getInputStream()));
    PrintWriter r     = new PrintWriter(response.getOutputStream());

   // response.setContentType("application/json");
    String line = null;
    while((line = in.readLine()) != null) {
        r.printf("%s<br/>\r\n", line);
    }
    r.printf("emrah");

    r.flush();*/
    Scanner s       = new Scanner(request.getInputStream()).useDelimiter("\\A");
    String result   = s.hasNext() ? s.next() : "";
    out.print(result);
    JSONObject jsonObject      = new JSONObject(result);
    String type  = (String) jsonObject.get("type");
    out.print(type);
%>