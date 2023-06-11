<%@ page contentType="text/html" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="java.io.*, java.util.*, org.apache.commons.fileupload.*, org.apache.commons.io.*" %>
<%@ page import="org.apache.commons.io.FileUtils"%>
<head>
    <title>商品管理页面</title>
</head>
<style>
    body {
        background-image: url("img/bj24.jpg");
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }
    .containerx {
        height: 10%;
        width: 100%;
        z-index: 2;
    }
    .container{
        height: 90%;
        width: 100%;
    }
    .container1{
        float: left;
        height: 100%;
        width: 28%;
        margin: 20px;
        padding: 20px;
        z-index: 1;
    }
    .container2{
        float: right;
        height: 100%;
        width: 60%;
        margin: 20px;
        padding: 20px;
    }
    .container3{
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .login-wrapper {
        background-color:FireBrick;
        width: 320px;
        height: 100%;
        border-radius: 20px;
        padding: 0 40px;
        position: relative;
        left: 40%;
        top: 50%;
        transform: translate(-50%,-50%);
    }
    .header {
        font-size: 38px;
        font-weight: bold;
        text-align: center;
        line-height: 200px;
    }
    .input-item {
        display: block;
        width: 100%;
        border-radius: 20px;
        margin-bottom: 20px;
        border: 0;
        padding: 10px;
        border-bottom: 0 solid rgb(128,125,125);
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
        background-image: linear-gradient(to right,#DBB676, #FFEED0);
        color: #51380E;
        cursor: pointer;
    }
    .tips {
        margin-top: 20px;
        font-size: 15px;
        font-weight: bold;
        text-align: center;
        height: 30px;
        width:100%;
    }
    table {
        border-collapse: collapse;
        width: 100%;
        margin: 1px 0;
        font-size: 18px;
    }
    td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
        background-color: #f5f5f5;
    }
    th {
        background-color: #dddddd;
        font-weight: bold;
        height: 62px;
    }
    tr:hover {
        background-color: #ddd;
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
    .nav1 {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 105px;
        z-index: 2;
    }
</style>
<HTML>
<body>
<div class="containerx">
    <div class="nav1">
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
</div>
<div class="container">
    <div class="container1">
        <div class="login-wrapper">
            <%
                Connection con;
                PreparedStatement pre=null; //预处理语句。
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
            <div class="header">添加商品</div>
            <div class="form-wrapper">
                <form action="shopadmin.jsp" method="post" enctype="multipart/form-data">
                    <input type="text" name="str1" placeholder="商品名称" class="input-item" required>
                    <input type="number" name="str2" placeholder="商品价格" class="input-item" required>
                    <input type="text" name="str3" placeholder="商品描述" class="input-item">
                    <input type="file" name="str4" id="image" class="input-item" >
                    <input type="submit" name="submit" value="提交" class="btn">
                </form>
                <%
                    String Str1 =null;
                    String Str2 =null;
                    String Str3 =null;
                    String savePath = "D:/jsp_end/src/main/webapp/pic";
                    String filePath = null;
                    String filepath = null;
                    DiskFileItemFactory factory = new DiskFileItemFactory(); // 创建DiskFileItemFactory对象
                    ServletFileUpload upload = new ServletFileUpload(factory); // 创建ServletFileUpload对象
                    upload.setHeaderEncoding("UTF-8"); // 设置编码方式
                    try {
                        List<FileItem> items = upload.parseRequest(request); // 解析请求，获取上传文件的信息
                        for (FileItem item : items) {
                            if (item.isFormField()) {
                                String fieldName = item.getFieldName(); // 获取字段名
                                String fieldValue = item.getString("UTF-8");
                                if (fieldName.equals("str1")){
                                    Str1 = fieldValue;
                                }
                                else if (fieldName.equals("str2")){
                                    Str2 = fieldValue;
                                }
                                else if (fieldName.equals("str3")){
                                    Str3 = fieldValue;
                                }
                            } else if (!item.isFormField()) {
                                // 如果是上传文件字段，获取上传的文件名
                                String filename = item.getName();
                                if (filename != null) {
                                    filename = new File(filename).getName(); // 获取文件名
                                    filePath = savePath + File.separator + filename; // 拼接文件路径
                                    filepath = "pic/" +filename;
                                    File uploadedFile = new File(filePath); // 创建File对象
                                    item.write(uploadedFile); // 将上传的文件保存到指定路径
                                    out.println("<p>文件上传成功！</p>");
                                    out.println("<p>文件名：" + filename + "</p>");
                                    out.println("<p>文件大小：" + FileUtils.byteCountToDisplaySize(item.getSize()) + "</p>");
                                }
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </div>
            <div class = tips>
            </div>
        </div>
    </div>
    <div class="container2">
        <div class="container3">
            <table>
                <thead>
                <tr>
                    <th width="25%">商品名称</th>
                    <th width="15%">商品价格</th>
                    <th width="50%">商品描述</th>
                    <th width="10%">商品操作</th>
                </tr>
                </thead>
                <tbody>
                <%
                    int id = 0;
                    boolean b = false;
                    if(Str1!=null && Str2!=null && Str3!=null){
                        b=true;
                    }
                    if(b){
                        try{
                            con = DriverManager.getConnection(url,user,password);		//连接数据库。
                            sql=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                                    ResultSet.CONCUR_UPDATABLE);			 //可更新数据库的结果集。
                            rs = sql.executeQuery("SELECT * FROM productslist");
                            rs.moveToInsertRow();
                            rs.updateString(2,Str1);
                            rs.updateString(3,Str2);
                            rs.updateString(4,Str3);
                            rs.updateString(5,filepath);
                            rs.insertRow();
                            rs=sql.executeQuery("SELECT * FROM productslist");					//查表
                            while(rs.next()) {
                                id = rs.getInt(1);
                                String one = rs.getString(2);
                                String two = rs.getString(3);
                                String three = rs.getString(4);
                %>
                <tr>
                    <td><%=one%></td>
                    <td><%=two%></td>
                    <td><%=three%></td>
                    <td>
                        <form action="shopadmin.jsp" method="post">
                            <button type="submit" class="btn-remove" name="sc" value=<%=id%> >删除</button>
                        </form>
                    </td>
                </tr>
                <% }
                    con.close();
                }
                catch(SQLException e) {
                    out.print("<h1>"+e);
                }
                }else {
                    try{
                        con = DriverManager.getConnection(url,user,password);		//连接数据库。
                        sql=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                                ResultSet.CONCUR_UPDATABLE);			 //可更新数据库的结果集。
                        rs = sql.executeQuery("SELECT * FROM productslist");
                        while(rs.next()) {
                            id = rs.getInt(1);
                            String one = rs.getString(2);
                            String two = rs.getString(3);
                            String three = rs.getString(4);
                %>
                <tr>
                    <td><%=one%></td>
                    <td><%=two%></td>
                    <td><%=three%></td>
                    <td>
                        <form action="shopadmin.jsp" method="post">
                            <button type="submit" class="btn-remove" name="sc" value=<%=id%> >删除</button>
                        </form>
                    </td>
                </tr>
                <% }
                    con.close();
                }
                catch(SQLException e) {
                    out.print("<h1>"+e);
                }
                }
                %>
                </tbody>
                <%
                    request.setCharacterEncoding("utf-8");
                    String id5 =request.getParameter("sc");
                    boolean A=false;
                    boolean B=false;
                    if(id5!=null){
                        A=true;
                    }
                %>
                <%
                    if(A){
                        try{
                            con = DriverManager.getConnection(url,user,password);			//连接数据库。
                            String deleteSQL = "delete from productslist where id = ?";
                            pre=con.prepareStatement(deleteSQL);//进行预处理返回预处理语句sql。
                            pre.setString(1,id5);
                            pre.execute(); //执行更新。
                            String querySQL = "select * from shopcart where id = ?";
                            pre=con.prepareStatement(querySQL);//进行预处理返回预处理语句sql。
                            pre.setString(1,id5);
                            rs = pre.executeQuery();
                            if (rs.next()){
                                B = true;
                            }
                            if (B){
                                String deleteSQL2 = "delete from shopcart where id = ?";
                                pre=con.prepareStatement(deleteSQL2);//进行预处理返回预处理语句sql。
                                pre.setString(1,id5);
                                pre.execute(); //执行更新。
                            }
                            response.sendRedirect("shopadmin.jsp");
                        }
                        catch(SQLException e) {
                            out.print("<h1>"+e);
                        }
                    }
                %>
            </table>
        </div>
    </div>
</div>
</body>
</HTML>
</body>
</html>
