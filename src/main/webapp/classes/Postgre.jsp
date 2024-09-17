<%--
  Created by IntelliJ IDEA.
  User: omer.kesmez
  Date: 8.09.2024
  Time: 22:39
--%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.*" %>
<%@include file="Mongo.jsp" %>
<%@include file="Json.jsp" %>
<%--
  https://github.com/redisson/redisson/wiki/Table-of-Content
  <%@include file="classes/Postgre.jsp" %>
  --------------------------------------------
  How to Use
  -------------------------------------------
  Postgre postgre = new Postgre();
  out.print(postgre.select());
  -------------------------------------------
--%>
<%
    class Postgre extends Json{
        private java.sql.Statement stmt;
        private java.sql.Connection conn;
        private java.sql.ResultSet rs;
        JSONObject requestBodyParameters;
        JSONObject rowdata;
        JSONObject response;
        public int error = 0;
        public String query = "";

        public Postgre(InputStream inputStream){
            rowdata     = new JSONObject();
            response    = new JSONObject();
            requestBodyParameters = jsonRead(inputStream);
            if(table == null){
                error = 1;
            } else{
                connect();
            }
        }

        public void connect(){
            String url = "jdbc:postgresql://localhost:5432/local?user=postgres&password=123456&ssl=false";
            try	{
                Class.forName("org.postgresql.Driver").newInstance();
                //json          = new Json();
                //JSONObject jo = json.jsonRead(request.getInputStream());
                conn = java.sql.DriverManager.getConnection(url);
                stmt = conn.createStatement();
            }
            catch (java.sql.SQLException sqle)	{
                //sqle.printStackTrace();
                Mongo mongo   = new Mongo();
                mongo.setAndInsert(sqle,"connect","error","Postgre.sql",null);
            }
            catch (Exception e)	{
                //e.printStackTrace();
                Mongo mongo   = new Mongo();
                mongo.setAndInsert(e,"connect","error","Postgre.sql",null);
            }
        }

        public JSONObject select(){
            try	{
                query = "SELECT * FROM "+table+filter+" limit "+limit;
                rs                     = stmt.executeQuery(query);
                ResultSetMetaData rsmd = rs.getMetaData();
                int columnCount        = rsmd.getColumnCount();
                while (rs.next()) {
                    rowdata.clear();
                   // out.print(rs.getString(1));
                    for (int i = 1; i <= columnCount; i++ ) {
                        String name        = rsmd.getColumnName(i);
                        String columnValue = rs.getString(name);
                        rowdata.put(name,columnValue);
                    }
                    Mongo mongo   = new Mongo();
                    mongo.setAndInsert(null,"select","watch","Postgre.jsp",rowdata.toString());
                    response.put(rs.getString(1), rowdata);
                  //  rowdata.clear();
                }
                rs.close();
                stmt.close();
            } catch (java.sql.SQLException sqle)	{
                Mongo mongo   = new Mongo();
                mongo.setAndInsert(sqle,"select","error","Postgre.sql",query);
            } catch (Exception e)	{
                Mongo mongo   = new Mongo();
                mongo.setAndInsert(e,"select","error","Postgre.sql",query);
            } finally {
                if(response.length() == 0){
                    response.put("status",500);
                    response.put("message","Postgre error. Please log check. file:Postgre.sql method:select");
                }
                return response;
                //return new JSONObject(hm);
            }
        }
        public JSONObject update(){
            String message = "";
            try{
                query = "UPDATE "+ table + set + filter;
                stmt.executeUpdate(query);
                stmt.close();
                Mongo mongo = new Mongo();
                mongo.setAndInsert(null, "update", "watch", "Postgre.jsp", set);
                message     = "{\"status\":\"200\",\"message\":\"Operation is succesfully.\"}";
            } catch (java.sql.SQLException sqle) {
                Mongo mongo = new Mongo();
                mongo.setAndInsert(sqle, "select", "error", "Postgre.sql", query);
                message     = "{\"status\":\"500\",\"message\":\"Operation is not succesfully.\"}";
            } catch (Exception e)	{
                Mongo mongo   = new Mongo();
                mongo.setAndInsert(e,"update","error","Postgre.sql",query);
                message     = "{\"status\":\"500\",\"message\":\"Operation is not succesfully.\"}";
            } finally {
                return new JSONObject(message);
            }
        }

    }
%>