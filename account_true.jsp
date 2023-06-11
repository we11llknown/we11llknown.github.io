<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<style>
    * {
        margin: 0;
        padding: 0;
    }
    html {
        height: 100%;
    }
    body {
        height: 100%;

    }
    .container {
        height: 100%;
        background-image: url("img/bj33.jpg");
    }
    .header {
        font-size: 35px;
        font-weight: bold;
        text-align: center;
        line-height: 200px;
    }
    .login-wrapper {
        background-color: bisque;
        width: 358px;
        height: 380px;
        border-radius: 15px;
        padding: 0 50px;
        position: relative;
        left: 50%;
        top: 50%;
        transform: translate(-50%,-50%);
    }
    .input-item {
        display: block;
        width: 100%;
        margin-bottom: 20px;
        border: 0;
        padding: 10px;
        border-bottom: 1px solid rgb(128,125,125);
        font-family: "Source Code Pro", serif;
        font-size: 15px;
        font-weight: bold;
        outline: none;
        cursor: pointer;
    }
</style>
<head>
    <title>结算成功</title>
</head>
<% Connection con;
    PreparedStatement pre; //预处理语句。
    ResultSet rs = null;
    Statement sql = null;
    String place = null;
    try{  //加载JDBC-MySQL8.0连接器:
        Class.forName("com.mysql.cj.jdbc.Driver");
    }
    catch(Exception e){
        out.print("<h1>"+e);
    }
    String url = "jdbc:mysql://localhost:3306/bookdatabase?"+
            "serverTimezone=UTC&characterEncoding=utf-8";
    String user ="root";
    String password ="";
%>
<%
    request.setCharacterEncoding("utf-8");
    String username = request.getParameter("username");
    String place2 = request.getParameter("address");
    try {
        con = DriverManager.getConnection(url, user, password);        //连接数据库。
        String UPDATESQL = "UPDATE register SET place = ? WHERE username = ?";
        pre=con.prepareStatement(UPDATESQL);
        pre.setString(1,place2);
        pre.setString(2,username);
        pre.execute(); //执行更新。
    } catch (SQLException e) {
        out.print("<h1>" + e);
    }
%>
<%
    String fk = request.getParameter("fk");
    boolean A = false;
    if (fk != null){
        A = true;
    }
    if (A){
        try {
            con = DriverManager.getConnection(url, user, password);        //连接数据库。
            String deleteSQL = "delete from shopcart ";
            pre=con.prepareStatement(deleteSQL);
            pre.execute(); //执行更新。
        } catch (SQLException e) {
            out.print("<h1>" + e);
        }
    }
%>
<body>
<div class="container">
    <div class="login-wrapper">
        <div class="header">结算成功</div>
        <div class="form-wrapper">
            <form>
                <input type="button" onclick=window.location.href='shoplist.jsp' value="返回商城页面" class="input-item">
            </form>
        </div>
    </div>
</div>
</body>
</html>
