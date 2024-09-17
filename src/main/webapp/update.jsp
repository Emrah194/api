<%@ page errorPage="error.jsp" %>
<%@include file="classes/Postgre.jsp" %>

<%
    response.setContentType("application/json");
    Postgre postgre = new Postgre(request.getInputStream());
    out.print(postgre.update());
    //out.print(postgre.query);

%>
