<%@ page errorPage="error.jsp" %>
<%@include file="classes/Postgre.jsp" %>

<%
    //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    //out.print(sdf.format(new Date()));
    //JSONObject where = json.where;
    //out.print(where.get("customer_id"));
    response.setContentType("application/json");
    Postgre postgre = new Postgre(request.getInputStream());
    if(postgre.error != 1){
        out.print(postgre.select());
        //out.print(postgre.filter);
    }
%>
