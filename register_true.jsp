<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8" %>
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
    <title>注册成功</title>
</head>
<body>
<div class="container">
    <div class="login-wrapper">
        <div class="header">恭喜你，注册成功</div>
        <div class="form-wrapper">
            <form>
                <input type="button" onclick=window.location.href='login1.jsp' value="返回登录页面" class="input-item">
                <input type="button" onclick=window.location.href='register.jsp' value="返回注册页面" class="input-item">
            </form>
        </div>
    </div>
</div>
</body>
</html>
