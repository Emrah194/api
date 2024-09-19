<%@ page import="io.github.cdimascio.dotenv.Dotenv" %>

<%

    Dotenv dotenv = Dotenv
            .configure()
            .directory(request.getServletContext().getRealPath(""))
            .filename(".env")
            .ignoreIfMalformed()
           // .ignoreIfMissing()
            .load();
    out.print(dotenv.get("MY_ENV_VAR1"));

%>