<%@ page language = "java" contentType = "text/html; charset = ISO-8859-1"
	import="java.io.*"
	import="java.sql.*"
	import="java.util.*"
	import="com.connection.ConnectionDB"
%>
<html>
<head>
	<title>Testing Connection</title>
</head>
<body>
    <%
    if(request.getParameter("db")!=null){
        ConnectionDB myDbTest = null;
        String RDBMS = request.getParameter("rdbms");
        String Server = request.getParameter("server");
        String Port = request.getParameter("port");
        String DataBase = request.getParameter("db");
        String User = request.getParameter("user");
        String Password = request.getParameter("password");
        myDbTest = new ConnectionDB(RDBMS, Server, Port, DataBase, User, Password);

        Connection connection = null;
        connection = myDbTest.getConnection();
        //out.println(connection);

        if(request.getParameter("query")!=null){
            ResultSet res = null;
            Statement stmt = connection.createStatement();

            if(connection!=null){
                String codpais = request.getParameter("pais");
                String sql = "SELECT * FROM usuario JOIN paises ON usuario.codpais=paises.codpais WHERE usuario.codpais = '" + codpais +"'";
                res = stmt.executeQuery(sql);

                out.println("<TABLE BORDER=5 ALIGN=CENTER>\n" +
                "<TR BGCOLOR=\"#FFAD00\">\n" +
                "<TH>ID</TH>" +
                "<TH>Nombre</TH>"+
                "<TH>Apellido</TH>"+
                "<TH>codPais</TH>"+
                "<TH>Pais</TH>");
                while(res.next()){
                   out.println("<TR>" +
                   "<TD>" + res.getString("id")+ "</TD>" +
                   "<TD>" + res.getString("nombre") + "</TD>" +
                   "<TD>" + res.getString("apellido")+ "</TD>" +
                   "<TD>" + res.getString("codpais") + "</TD>" +
                   "<TD>" + res.getString("pais") + "</TD>"
                   );
                }
                out.println("</TR></TABLE>");
             }
        }else{
            %>
            <form action="index.jsp?query=1" method="post">
                <input type="hidden" name="rdbms" value="<%=RDBMS%>">
                <input type="hidden" name="server" value="<%=Server%>">
                <input type="hidden" name="port" value="<%=Port%>">
                <input type="hidden" name="db" value="<%=DataBase%>">
                <input type="hidden" name="user" value="<%=User%>">
                <input type="hidden" name="password" value="<%=Password%>">
                Pais <input type="text" value="MX" name="pais">
                <input type="submit" value="Enviar">
            </form>
            <%
        }
    }else{
    %>
    <form action="index.jsp" method="post">
        <table>
            <tr>
                <td>RDMMS: </td>
                <td><input type="text" name="rdbms" value="mysql"></td>
            </tr>
            <tr>
                <td>Servidor: </td>
                <td><input type="text" name="server" value="localhost"></td>
            </tr>
            <tr>
                <td>Puerto: </td>
                <td><input type="text" name="port" value="3306"></td>
            </tr>
            <tr>
                <td>Base da datos: </td>
                <td><input type="text" name="db" value="testing"></td>
            </tr>
            <tr>
                <td>usuario: </td>
                <td><input type="text" name="user" value="root"></td>
            </tr>
            <tr>
                <td>contrase&ntilde;a: </td>
                <td><input type="text" name="password" value="pass"></td>
            </tr>
        </table>
        <input type="submit" value="Conectar">
    </form>
    <% } %>
</body>
</html>