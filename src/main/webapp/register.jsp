<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>注册</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.min.css"/>
    <script type="text/javascript" src="./jquery/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="./popper.js/popper.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap.min.js"></script>

</head>

<body style="background-color: gainsboro;">
<div class="container">
    <div class="row">
        <h2><b>普通会员注册</b></h2>
        <hr>
    </div>
    <div class="row">
        <form action="/store/registerServlet" method="post" class="col-md-6">
            <input type="hidden" name="task" value="register"/>
            <c:if test="${not empty errMsg}">
                <div class="alert alert-danger text-center">
                        ${errMsg}
                </div>
            </c:if>
            <div class="form-group">
                <label>账户名称:</label>
                <input type="text" name="username" class="form-control" placeholder="请输入账号信息" maxlength="15">
            </div>
            <div class="form-group">
                <label>账户密码:</label>
                <input type="password" name="password" class="form-control" placeholder="请输入密码信息">
            </div>
            <div class="form-group">
                <label>用户姓名:</label>
                <input type="text" name="name" class="form-control" placeholder="请输入真实姓名">
            </div>
            <div class="form-group">
                <label>出生日期:</label>
                <input type="date" name="birthday" class="form-control" placeholder="年/月/日">
            </div>
            <div class="form-group">
                <label style="margin-right: 20px">用户性别:</label>
                <br/>
                <input type="radio" name="sex" value="男" checked>男
                <input type="radio" name="sex" value="女" style="margin-left: 20px">女
            </div>
            <div class="form-group">
                <label>用户手机:</label>
                <input type="text" name="telephone" class="form-control" placeholder="请输入您的手机号" maxlength="11">
            </div>
            <div class="form-group">
                <label>用户邮箱:</label>
                <input type="text" name="email" class="form-control" placeholder="请输入邮箱信息">
            </div>
            <div class="form-group">
                <label>验证码:</label>
                <input type="text" name="check" class="check">
                <img src="checkCode" height="32px" alt="" onclick="changeCheckCode(this)">
                <script type="text/javascript">
                    //图片点击事件
                    function changeCheckCode(img) {
                        img.src = "checkCode?" + new Date().getTime();
                    }
                </script>
            </div>

            <div>
                <button class="btn btn-primary">注册</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>

