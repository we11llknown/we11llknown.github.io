<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>商城登录页面</title>
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
        }
        .container1 {
            height: 10%;
        }
        .container2 {
            height: 80%;
            width: 100%;
            background: url("img/bj15.jpg") ;
            background-repeat: no-repeat;
            background-size: cover;
        }
        .container3{
            height: 10%;
            border-top: 1px solid #ccc;
            padding: 10px 0;
            text-align: center;
        }
        .login-wrapper {
            background-color: bisque;
            width: 200px;
            height: 350px;
            border-radius: 15px;
            padding: 0 50px;
            position: relative;
            left: 85%;
            top: 50%;
            transform: translate(-50%,-50%);
        }
        .header {
            font-size: 30px;
            font-weight: bold;
            text-align: center;
            line-height: 100px;
        }
        .input-item {
            display: block;
            width: 100%;
            margin-bottom: 20px;
            border: 0;
            padding: 10px;
            border-bottom: 1px solid rgb(128,125,125);
            font-size: 15px;
            outline: none;
        }
        .input-item::placeholder {
            text-transform: uppercase;
        }
        .btn {
            text-align: center;
            padding: 10px;
            width: 100%;
            margin-top: 15px;
            background-image: linear-gradient(to right,#36DAD4, #80845A);
            color: #fff;
            cursor: pointer;
        }
        .msg {
            text-align: center;
            line-height: 75px;
        }
        .msg a {
            text-decoration-line: none;
            color: #abc1ee;
        }
        nav {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            position: relative;
        }
        nav .logo {
            color: #000;
            text-decoration: none;
            margin-right: auto;
            position: relative;
            z-index: 2;
        }
        nav img {
            height: 65px;
            width: 210px;
        }
        nav .logo:before {
            content: "";
            display: block;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: #f00;
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s ease-in-out;
            z-index: -1;
        }
        nav .logo:hover:before {
            transform: scaleX(1);
        }
        nav .menu {
            display: flex;
            justify-content: center;
            align-items: center;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            z-index: 2;
        }
        nav .menu a {
            color: #000;
            text-decoration: none;
            margin: 0 20px;
            font-size: 18px;
            font-weight: bold;
            position: relative;
            z-index: 2;
            transition: color 0.2s ease-in-out;
        }
        nav .menu a:before {
            content: "";
            display: block;
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: #f00;
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s ease-in-out;
            z-index: -1;
        }
        nav .menu a:hover:before {
            transform: scaleX(1);
        }
    </style>
</head>
<body>
<% Connection con;
    PreparedStatement pre; //预处理语句。
    ResultSet rs;
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
<div class="container">
<div class="container1">
    <nav>
        <a href="shoplist.jsp" class="logo"><img src="img/logo2.jpg"></a>
        <div class="menu">
            <a href="shoplist.jsp">商城首页</a>
            <a href="shopcart.jsp">购物车</a>
            <a href="#">服务</a>
            <a href="#">关于</a>
            <a href="#">联系我们</a>
        </div>
    </nav>
</div>
<div class="container2">
        <div class="login-wrapper">
            <div class="header">登录</div>
            <div class="form-wrapper">
                <form>
                    <input type="text" name="username1" placeholder="用户名" class="input-item">
                    <input type="password" name="password1" placeholder="密码" class="input-item">
                    <input type="submit" name="登录" class="btn">
                </form>
            </div>
            <div class="msg">
                无法登录？
                <a href="register.jsp">注册账号</a>
            </div>
        </div>
        <%
            request.setCharacterEncoding("utf-8");
            String username1 = request.getParameter("username1");
            String password1 = request.getParameter("password1");
            String userType = "";
            boolean a = true;
            if(username1==null||password1==null) {
                a = false;
            }
            if (a) {
                // 检查是否为管理员
                if (username1.equals("admin") && password1.equals("1234")) {
                    userType = "admin";
                }
                else {// 检查是否为常规用户
                    try {
                        con = DriverManager.getConnection(url, user, password);
                        String querySQL = "SELECT * FROM register WHERE username = ? AND password = ?";
                        pre = con.prepareStatement(querySQL);
                        pre.setString(1, username1);
                        pre.setString(2, password1);
                        rs = pre.executeQuery();
                        if (rs.next()) {
                            userType = "user";
                        }
                        con.close();
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    }
                }
            }
        %>
        <%
            if (userType.equals("admin"))
            {
                session.setAttribute("username", username1);
                response.sendRedirect("shopadmin.jsp");
            }
            else if (userType.equals("user"))
            {
            session.setAttribute("username", username1);
            response.sendRedirect("shoplist.jsp");
            }
        %>
</div>
<div class="container3">版权所有 &copy; 购物网站——Well-Known 2023</div>
</div>
</body>
</html>


