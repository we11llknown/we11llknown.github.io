<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品详情页</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            font-size: 16px;
            background-image: url("img/bj26.jpg");
        }
        .container {
            max-width: 1100px;
            height: auto;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            background-image: url("img/bj28.jpg");
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #333;
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
        .nav2 a {
            padding: 10px;
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }
        .nav2 a:hover {
            background-color: #f5f5f5;
        }
        .container1 {
            width: 440px;
            height: auto;
            margin: 10px;
            padding: 50px 20px;
            float: left;
        }
        .product-img img {
            display: block;
            max-width: 400px;
            border-radius: 15px;
            height: 400px;
            margin-bottom: 20px;
        }
        .product-info {
            width: 400px;
            height: auto;
            margin: 10px;
            padding: 50px 20px;
            float: left;
        }
        .product-info h1 {
            font-size: 38px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .price-wrap {
            margin-bottom: 20px;
        }
        .price {
            display: inline-block;
            font-size: 30px;
            font-weight: bold;
            color: #ff0000;
            margin: 0;
        }
        .stock {
            display: inline-block;
            font-size: 30px;
            color: #210404;
            margin: 0 0 0 20px;
        }
        .product-info p {
            margin: 0 0 10px;
        }
        .product-info p:first-child {
            margin-top: 20px;
        }
        .product-info a {
            text-decoration: none;
            color: #333;
            border-bottom: 1px solid #333;
        }
        .container2 {
            display: flex;
            align-items: center;
        }
        p {
            display: inline-block;
        }
        .bottom2 {
            margin-bottom: 10px;
        }
        input[type="number"] {
            width: 60px;
            margin-right: 10px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: center;
        }
        .button-row {
            display: block; /* 使 div 标签生成块级元素 */
            margin: 10px; /* 为两个按钮之间添加一些垂直间距 */
            float: left;
        }
        input[type="submit"] {
            background-color: #ff0000;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #cc0000;
        }
        button[type="submit"] {
            background-color: #ff0000;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
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
        .container2 {
            height: 10%;
        }

        .container3 {
            max-width: 800px;
            margin: 530px auto auto auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 20px;
        }
        .container3 h1 {
            text-align: center;
        }
        .container3 form {
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 10px;
        }
        .form-group p {
            font-size: 25px;
            font-weight: bold;
        }
        .container3 label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .container3 input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            resize: vertical;
        }
        .container3 input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .container3 input[type="submit"]:hover {
            background-color: #45a049;
        }
        .comment {
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
        }
        .comment-header {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .comment-body {
            margin-left: 20px;
        }
    </style>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String content = request.getParameter("content");
    out.print(content);
%>
<%
    Connection con;
    PreparedStatement pre=null; //预处理语句。
    ResultSet rs = null;
    Statement sql;
    Timestamp now = new Timestamp(System.currentTimeMillis());//获取目前系统时间
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
    String id = request.getParameter("id");
    String name =null;
    double price = 0;
    String description = null;
    String ww = null;
    try {
        con = DriverManager.getConnection(url,user,password);		//连接数据库。
        sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_UPDATABLE);			 //可更新数据库的结果集。
        String querySQL = "SELECT * FROM productslist WHERE id = ?";
        pre = con.prepareStatement(querySQL);
        pre.setString(1, id);
        rs = pre.executeQuery();
        if (rs.next()) {
             name = rs.getString("name");
             price = rs.getDouble("price");
             description = rs.getString("description");
             ww = rs.getString("img");
        }
        rs.close();
        sql.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<%
    String username = (String) session.getAttribute("username");
%>
<div class="container2">
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
    <div class="container1">
        <div class="product-img">
            <img src="<%=ww%>" alt="商品">
        </div>
    </div>
    <div class="product-info">
        <h1><%=name%></h1>
        <div class="price-wrap">
            <p class="price"><%=price%></p>
            <p class="stock">元</p>
        </div>
        <p>描述：<%=description%></p>
        <form action="shopcart.jsp?id=<%=id%>&name=<%=name%>&price=<%=price%>&ww=<%=ww%>&username=<%=username%>" method="post">
        <div class="container2">
            <div class="bottom2"><p>数量：</p></div>
                <input type="number" name="quantity" value="1" min="1" max="100" required>
        </div>
        <div class="button-row">
            <% if(session.getAttribute("username")!=null)
            { %>
            <input type="submit" name="加入购物车" value="加入购物车">
            <% }else{ %>
            <button type="submit" onclick=window.location.href="login1.jsp">加入购物车</button>
            <% } %>
        </div>
        </form>
    </div>
    <div class="container3">
        <h1>评论区</h1>
        <form action="shopdetail.jsp?id=<%=id%>" method="post" accept-charset="UTF-8">
            <div class="form-group">
                <label>姓名：</label>
                <p><%=username%></p>
            </div>
            <div class="form-group">
                <label for="content">评论内容：</label>
                <textarea id="content" name="content" rows="3" required></textarea>
            </div>
            <input type="submit" value="提交评论">
        </form>
        <hr>
        <h3>评论列表</h3>
        <%
            try {
                con = DriverManager.getConnection(url, user, password);        //连接数据库。
                String querySQL = "select * from comment where id = ? order by create_time desc ";
                pre = con.prepareStatement(querySQL);
                pre.setString(1,id);
                rs = pre.executeQuery();
                while (rs.next()) {
        %>
        <div class="comment">
            <div class="comment-header"><%= rs.getString("name") %> 评论于 <%= rs.getString("create_time") %></div>
            <div class="comment-body"><%= rs.getString("content") %></div>
        </div>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
        <%
            boolean b = false;
            if (id != null && name != null && content != null) {
                b = true;
            }
                if (b){
                    try {
                        con = DriverManager.getConnection(url,user,password);		//连接数据库。
                        sql=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                                ResultSet.CONCUR_UPDATABLE);			 //可更新数据库的结果集。
                        rs = sql.executeQuery("SELECT * FROM comment");
                        rs.moveToInsertRow();
                        rs.updateString(2,id);
                        rs.updateString(3,username);
                        rs.updateString(4,content);
                        rs.updateTimestamp(5,now);
                        rs.insertRow();
                        response.sendRedirect("shopdetail.jsp?id="+id);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
            }
        %>
    </div>
</div>
</body>
</html>