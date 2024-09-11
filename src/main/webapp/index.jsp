<%@ page import="org.json.JSONObject" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.*" %>
<%
    Scanner s       = new Scanner(request.getInputStream()).useDelimiter("\\A");
    String result   = s.hasNext() ? s.next() : "";
    // out.print(request.getInputStream());
    try{
       /* JSONObject jo = new JSONObject(result);
        out.print(result.toString());*/
        BufferedReader in = new BufferedReader(
                new InputStreamReader(request.getInputStream()));
        PrintWriter r = new PrintWriter(response.getOutputStream());

        response.setContentType("application/json");

        String line = null;
        while((line = in.readLine()) != null) {
            r.printf("%s<br/>\r\n", line);
        }
        r.printf("emrah");

        r.flush();
    } catch (Exception e) {
        out.print(e.getMessage());
    }
    finally {
        out.print(result + "work");
    }

%>