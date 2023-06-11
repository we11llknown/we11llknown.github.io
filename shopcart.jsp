<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="utf-8">
    <title>购物车</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: "Helvetica Neue", Arial, "Hiragino Sans GB", "Microsoft YaHei", sans-serif;
            font-size: 14px;
            color: #666;
            background-image: url("img/bj25.jpg");
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px 30px;
            background-color: white;
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }
        .cart-table thead {
            background-color: #f5f5f5;
        }
        .cart-table tr {
            border-bottom: 1px solid #ddd;
        }
        .cart-table th, .cart-table td {
            text-align: center;
            vertical-align: middle;
            padding: 10px;
        }
        .cart-table td img {
            display: block;
            width: 80px;
            height: 80px;
            margin: 0 auto;
        }
        .cart-table td.title {
            text-align: left;
            padding-left: 20px;
        }
        .cart-table td.title a {
            color: #333;
            text-decoration: none;
        }
        .cart-table td.operator {
            text-align: center;
        }
        .cart-table td.operator input {
            width: 60px;
            height: 30px;
            padding: 0 5px;
            text-align: center;
            border: 1px solid #ddd;
        }
        .cart-table td.price {
            font-weight: bold;
            color: #f40;
        }
        .cart-summary {
            margin-top: 30px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), 0 1px 2px rgba(0, 0, 0, 0.05);
        }
        .cart-summary h2 {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .cart-summary p {
            margin-bottom: 5px;
        }
        .cart-summary .total-price {
            font-size: 24px;
            font-weight: bold;
            color: #f40;
        }
        .cart-summary .btn-checkout {
            margin-top: 20px;
            display: block;
            width: 100%;
            height: 44px;
            line-height: 44px;
            text-align: center;
            background-color: #f40;
            border-radius: 4px;
            color: #fff;
            font-size: 16px;
            text-decoration: none;
            transition: .3s;
        }
        .cart-summary .btn-checkout:hover {
            background-color: #e20;
        }
        .btn-remove{
            cursor: pointer;
        }
        .btn-gx {
            cursor: pointer;
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
<%
    int numberall = 0;
    double priceall = 0;
    int id2 = 0;
    String number = request.getParameter("quantity");
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    double price = 0;
    if(request.getParameter("price")!=null){
    price = Double.parseDouble(request.getParameter("price"));
    }
    String ww = request.getParameter("ww");
    boolean a = false;
    boolean c = true;
%>
<%
    if(number!=null && id!=null && name!=null && price!= 0 && ww != null){
        a = true;
    }
%>
<% Connection con;
    PreparedStatement pre = null; //预处理语句。
    PreparedStatement pre2 = null; //预处理语句。
    ResultSet rs;
    Statement sql = null;
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
    try {
        con = DriverManager.getConnection(url, user, password);        //连接数据库。
        String SQL = "SELECT * from shopcart WHERE id = ?";
        pre=con.prepareStatement(SQL);
        pre.setString(1,id);
        rs = pre.executeQuery();
        if (rs.next()){
           int number_have = rs.getInt("number");
           int number_final= Integer.parseInt(number) + number_have;
           String insertSQL = "UPDATE shopcart SET number = ? where id = ?";
           pre2=con.prepareStatement(insertSQL);
           pre2.setInt(1,number_final);
           pre2.setString(2,id);
           pre2.execute();
           rs = pre.executeQuery();
           c = false;
        }
    } catch (SQLException e) {
        out.print("<h1>" + e);
    }
%>
<%
    if(c) {
        try {
            con = DriverManager.getConnection(url, user, password);        //连接数据库。
            sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);             //可更新数据库的结果集。
            rs = sql.executeQuery("SELECT * FROM shopcart");                    //查表。
            rs.moveToInsertRow();
            rs.updateString(1, id);
            rs.updateString(2, name);
            rs.updateDouble(3, price);
            rs.updateString(4, number);
            rs.updateString(5,ww);
            rs.insertRow();
            con.close();
        } catch (SQLException e) {
        }
    }
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
    <h1>购物车</h1>
    <table class="cart-table">
        <thead>
        <tr>
            <th>商品</th>
            <th>单价(元)</th>
            <th>数量</th>
            <th>小计(元)</th>
            <th>操作</th>
        </tr>
        </thead>
        <%
                try {
                    con = DriverManager.getConnection(url,user,password);		//连接数据库。
                    sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                            ResultSet.CONCUR_UPDATABLE);		 //可更新数据库的结果集。
                    rs = sql.executeQuery("SELECT * FROM shopcart");
                    while (rs.next()) {
                        id2 = rs.getInt("id");
                        String name2 = rs.getString("name");
                        double price2 = rs.getDouble("price");
                        int number2 = rs.getInt("number");
                        String ww2 = rs.getString("img");
        %>
        <tbody>
        <tr>
            <td>
                <img src=<%=ww2%> >
                <div class="title"><%=name2%></div>
            </td>
            <td class="price"><%=price2%></td>
            <td class="operator">
                <form  method="post" action="shopcart.jsp">
                    <input type="number" name="data" value=<%=number2%>>
                    <input type="hidden" name="ddd" value=<%=id2%>>
                    <input type="hidden" name="dd" value=<%=id2%>>
                    <input type="submit" name="tj" class="btn-gx" value="更新">
                </form>
                <%
                    request.setCharacterEncoding("utf-8");
                    String id3 =request.getParameter("ddd");
                    String id4 =request.getParameter("dd");
                    String num2 = null;
                    boolean b = false;
                    if (id3!=null && id4!=null) {
                        if (id3.equals(id4)) {
                            num2 = request.getParameter("data");
                            b = true;
                        }
                    }
                %>
                <%
                    if(b) {
                        try {
                            con = DriverManager.getConnection(url, user, password);        //连接数据库。
                            String SQL = "UPDATE shopcart SET number = ? WHERE id = ?";
                            pre=con.prepareStatement(SQL);
                            pre.setString(1,num2);
                            pre.setString(2,id3);
                            pre.execute(); //执行更新。
                            response.sendRedirect("shopcart.jsp");
                        } catch (SQLException e) {
                            out.print("<h1>" + e);
                        }
                    }
                %>
            </td>
            <td class="subtotal">
                <%=price2 * number2%>
            </td>
            <td>
                <form action="shopcart.jsp" method="post">
                    <button type="submit" class="btn-remove" name="sc" value=<%=id2%> >删除</button>
                </form>
                <%
                    request.setCharacterEncoding("utf-8");
                    String id5 =request.getParameter("sc");
                    boolean A=false;
                    if(id5!=null){
                        A=true;
                    }
                %>
                <%
                    if(A){
                        try{
                            con = DriverManager.getConnection(url,user,password);			//连接数据库。
                            String deleteSQL = "delete from shopcart where id = ?";
                            pre=con.prepareStatement(deleteSQL);//进行预处理返回预处理语句sql。
                            pre.setString(1,id5);
                            pre.execute(); //执行更新。
                            response.sendRedirect("shopcart.jsp");
                        }
                        catch(SQLException e) {
                            out.print("<h1>"+e);
                        }
                    }
                %>
            </td>
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
    <div class="cart-summary">
        <%
            try {
                con = DriverManager.getConnection(url,user,password);		//连接数据库。
                sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                        ResultSet.CONCUR_UPDATABLE);		 //可更新数据库的结果集。
                rs = sql.executeQuery("SELECT * FROM shopcart");
                while (rs.next()) {
                    double price2 = rs.getDouble("price");
                    int number2 = rs.getInt("number");
                    numberall += number2;
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
        <h2>总结算</h2>
        <p>商品数量：<span class="total-quantity"><%=numberall%></span></p>
        <p>商品总价：<span class="total-price"><%=priceall%></span> 元</p>
        <a href="account.jsp?username=<%=username%>" class="btn-checkout">去结算</a>
    </div>
</div>
</body>
</html>