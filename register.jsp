<%@ page contentType="text/html" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %>
<HTML>
<title>账号注册</title>
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
        height: 90%;
        background-image: url("img/bj34.jpg");
    }
    .login-wrapper {
        background-color: bisque;
        width: 358px;
        height: 588px;
        border-radius: 15px;
        padding: 0 50px;
        position: relative;
        left: 50%;
        top: 45%;
        transform: translate(-50%,-50%);
    }
    .header {
        font-size: 38px;
        font-weight: bold;
        text-align: center;
        line-height: 170px;
    }
    .err1 {
        margin-top: 20px;
        font-size: 20px;
        font-weight: bold;
        text-align: center;
        height: 30px;
        width:100%;
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
        margin-top: 40px;
        background-image: linear-gradient(to right,#36DAD4, #80845A);
        color: #fff;
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
    .warning {
        position: relative;
        text-align: center;
        font-size: 25px;
        font-weight: bold;
    }
</style>
<body>
<%
    Connection con;
    PreparedStatement pre; //预处理语句。
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
            <div class="menu">
                <a href="login1.jsp">登录页</a>
                <a href="shoplist.jsp">购物商城</a>
                <a href="#">服务</a>
                <a href="#">关于</a>
                <a href="#">联系我们</a>
            </div>
        </nav>
    </div>
</div>
<div class="container">
    <div class="login-wrapper">
        <div class="header">注册账号</div>
        <div class="form-wrapper">
            <form action="register.jsp" method="post">
                <input type="text" name="str1" placeholder="用户名" value="" class="input-item" required>
                <input type="password" name="str2" placeholder="密码" value="" class="input-item" required>
                <input type="password" name="str3" placeholder="再次确认密码" value="" class="input-item" required>
                <input type="submit" name="提交注册" value="提交注册" class="btn"/>
            </form>
            <%request.setCharacterEncoding("utf-8");
            String str1=request.getParameter("str1");
            String str2=request.getParameter("str2");
            String str3=request.getParameter("str3");
            String err = "请重新输入密码";
            boolean a = false;
            boolean A = false;
            %>
            <%
                if(str1!=null&&str2!=null&&str3!=null){
                    if (Objects.equals(str2, str3)){
                        a = true;
                    }else {
                        a = false;
                        A = true;
                    }
                }
                else {
                    a=false;
                }
            %>
        </div>
        <div class="err1"><%
            if (A){
                out.print(err);
            }
        %></div>
    </div>
<%
    if(a) {
        try {
            con = DriverManager.getConnection(url, user, password);        //连接数据库。
            sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);             //可更新数据库的结果集。
            rs = sql.executeQuery("SELECT * FROM register");                    //查表。
            rs.moveToInsertRow();
            rs.updateString(1, str1);
            rs.updateString(2, str2);
            rs.insertRow();
            rs = sql.executeQuery("SELECT * FROM register");
            if (rs.next()) {
                response.sendRedirect("register_true.jsp");
            }
            con.close();
        } catch (SQLException e) {
            out.print("<div class=warning>");
            out.print("已有此用户名，请修改用户名");
            out.print("</div>");
        }
    }
%>
</div>
</body>
</HTML>