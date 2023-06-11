<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>购物网站</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* 样式表 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url("img/bj30.jpg");
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            height: 90%;
        }
        .container3 {
            position: fixed;
            width: 200px;
            height: 90%;
            left: 10px;
            padding: 70px 20px 0 70px;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }
        .login {
            display: flex;
            align-items: center;
        }
        .login p{
            background-color: #333;
            color: #fff;
            border: none;
            padding: 5px 10px;
            cursor: auto;
        }
        .login p:hover {
            background-color: #555;
        }
        .products {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            grid-gap: 20px;
            margin-top: 40px;
        }
        .product {
            height: 330px;
            width: 200px;
            border: 4px solid #210404;
            padding: 10px;
            text-align: center;
            background-color: white;
        }
        .product img {
            max-width: 100%;
            height: 200px;
            margin-bottom: 10px;
            border: 1px solid #000000;
        }
        .product h3 {
            font-size: 18px;
            margin: 0;
        }
        .product p {
            font-size: 20px;
            color: #210404;
            margin: 5px 0;
        }
        .product button {
            background-color: #333;
            color: #fff;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }
        .product button:hover {
            background-color: #555;
        }
        .footer {
            border-top: 0px solid #ccc;
            padding: 10px 0;
            text-align: center;
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
        .form-wrapper {
            color: #000;
            text-decoration: none;
            margin: 20px 0 0 400px;
            font-size: 18px;
            font-weight: bold;
            position: fixed;
            z-index: 2;
            transition: color 0.2s;
        }
        .input-item {
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
            margin-top: 0px;
            background-image: linear-gradient(to right,#000000, #333333);
            color: #fff;
            cursor: pointer;
        }
    </style>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
%>
<% Connection con;
    PreparedStatement pre = null; //预处理语句。
    ResultSet rs;
    Statement sql;
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
            <div class="form-wrapper">
                <form action="shoplist.jsp" method="post">
                    <input type="text" name="shopname" placeholder="输入商品名搜索商品" class="input-item">
                    <input type="submit" value="提交" class="btn">
                </form>
            </div>
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
    <div class="products">
        <%
            request.setCharacterEncoding("utf-8");
            String shopname = request.getParameter("shopname");
            boolean A = false;
            if (shopname != null){
                A = true;
            }
            if (A) {
                try {
                    con = DriverManager.getConnection(url, user, password);        //连接数据库。
                    String querySQL = "select * from productslist where name = ?";
                    pre = con.prepareStatement(querySQL);
                    pre.setString(1,shopname);
                    rs = pre.executeQuery();
                    if (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        double price = rs.getDouble("price");
                        String ww = rs.getString("img");
        %>
        <div class="product">
            <img src="<%=ww%>" alt="商品1">
            <h3><%=name%></h3>
            <p><%=price%>元</p>
            <a href="shopdetail.jsp?id=<%=id%>">商品详情</a>
        </div>
        <%
            }
                con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }else{//可更新数据库的结果集。
                try {
                    con = DriverManager.getConnection(url, user, password);        //连接数据库。
                    sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                            ResultSet.CONCUR_UPDATABLE);             //可更新数据库的结果集。
                    rs = sql.executeQuery("SELECT * FROM Productslist");
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        double price = rs.getDouble("price");
                        String ww = rs.getString("img");
        %>
        <div class="product">
            <img src="<%=ww%>" alt="商品1">
            <h3><%=name%></h3>
            <p><%=price%>元</p>
            <a href="shopdetail.jsp?id=<%=id%>">商品详情</a>
        </div>
        <%
                    }
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
    %>
    </div>
    <div class="footer">
        版权所有 &copy; 购物网站——Well-Known 2023
    </div>
</div>
</body>
</html>
