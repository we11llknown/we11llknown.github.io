<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>商品结算</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url("img/bj27.jpg");
            margin: 0;
            padding: 0;
        }
        .container {
            height: auto;
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 4px;
            margin-top: 50px;
        }
        h1 {
            text-align: center;
            margin-top: 0;
        }
        form {
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 20px;
        }
        label {
            display: inline-block;
            width: 100px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        input[type="text"], input[type="number"] {
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
            font-size: 14px;
            width: 300px;
            margin-bottom: 10px;
        }
        table {
            border-collapse: collapse;
            margin-bottom: 20px;
            width: 100%;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #f5f5f5;
            font-weight: bold;
        }
        tbody tr:hover {
            background-color: #f5f5f5;
        }
        button[type="submit"] {
            background-color: #ff4400;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color: #ff5f1f;
        }
        .total-price {
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
        }
        .container img {
            display: block;
            width: 100px;
            height: 100px;
            margin: 0 auto;
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
        .nav1 {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 105px;
        }
        nav .logo {
            color: #000;
            text-decoration: none;
            margin-right: auto;
            position: relative;
            z-index: 2;
        }
        nav .Name {
            color: #000;
            text-decoration: none;
            margin-right: 55px;
            font-size: 18px;
            font-weight: bold;
            position: relative;
            z-index: 2;
            transition: color 0.2s ease-in-out;
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
        .container1 {
            height: 10%;
        }
    </style>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    if (username==null){
        response.sendRedirect("login1.jsp");
    }
%>
<% Connection con;
    PreparedStatement pre = null; //预处理语句。
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
<div class="container1">
    <div class="nav1">
        <nav>
            <a href="shoplist.jsp" class="logo"><img src="img/logo2.jpg"></a>
            <div class="menu">
                <a href="login1.jsp">登录页</a>
                <a href="shopcart.jsp">购物车</a>
                <a href="#">服务</a>
                <a href="#">关于</a>
                <a href="#">联系我们</a>
            </div>
            <a class="Name">用户:<%=username%></a>
        </nav>
    </div>
</div>
<div class="container">
    <h1>商品结算</h1>
    <form method="post" action="account_true.jsp?username=<%=username%>">
        <label >收货人:</label>
        <p><%=username%></p><br>
        <%
            try {
                con = DriverManager.getConnection(url, user, password);        //连接数据库。
                String SQL = "SELECT * FROM register where username = ?";
                pre=con.prepareStatement(SQL);
                pre.setString(1,username);
                rs = pre.executeQuery();
                if (rs.next()) {
                    place = rs.getString("place");
                }
                con.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        %>
        <label >收货地址：</label>
        <input type="text" name="address"  value="<%=place%>" required><br>
        <table>
            <thead>
            <tr>
                <th>商品图</th>
                <th>商品名称</th>
                <th>数量</th>
                <th>价格</th>
            </tr>
            </thead>
            <%
                try {
                    con = DriverManager.getConnection(url,user,password);		//连接数据库。
                    sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                            ResultSet.CONCUR_UPDATABLE);		 //可更新数据库的结果集。
                    rs = sql.executeQuery("SELECT * FROM shopcart");
                    while (rs.next()) {
                        int id2 = rs.getInt("id");
                        String name2 = rs.getString("name");
                        double price2 = rs.getDouble("price");
                        int number2 = rs.getInt("number");
                        String ww2 = rs.getString("img");
            %>
            <tbody>
            <tr>
                <td><img src=<%=ww2%>></td>
                <td><%=name2%></td>
                <td><%=number2%></td>
                <td><%=price2%></td>
            </tr>
            </tbody>
            <%
                    }
                    rs.close();
                    sql.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
        <%
            double priceall = 0;
            try {
                con = DriverManager.getConnection(url,user,password);		//连接数据库。
                sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                        ResultSet.CONCUR_UPDATABLE);		 //可更新数据库的结果集。
                rs = sql.executeQuery("SELECT * FROM shopcart");
                while (rs.next()) {
                    double price2 = rs.getDouble("price");
                    int number2 = rs.getInt("number");
                    double price3 = number2 * price2;
                    priceall += price3;
                }
                rs.close();
                sql.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <p class="total-price">总价：￥<span id="totalPrice"><%=priceall%></span></p>
        <button type="submit" name="fk" value="fk">付款</button>
    </form>
</div>
</body>
</html>