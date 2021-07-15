<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.min.css"/>
    <script type="text/javascript" src="./jquery/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="./popper.js/popper.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap.min.js"></script>
</head>
<body style="background-color: gainsboro;">
<div class="container">
    <div class="row" style="margin-top:100px">
        <h2><b>普通会员登录</b></h2>
        <hr>
    </div>
    <div class="row">
        <form action="/store/loginServlet" method="post" class="col-md-4">
            <input type="hidden" name="task" value="login"/>
            <div class="form-group">
                <label>账户名称</label>
                <input type="text" name="username" class="form-control" placeholder="请输入账号信息" maxlength="15">
            </div>
            <div class="form-group">
                <label>账户密码</label>
                <input type="password" name="password" class="form-control" placeholder="请输入密码信息" maxlength="6">
            </div>
            <div class="form-group">
                <label>验证码</label>
                <input type="text" name="check" class="form-control" placeholder="请输入验证码" maxlength="4">
                <img src="checkCode" height="32px" alt="" onclick="changeCheckCode(this)">
                <script type="text/javascript">
                    //图片点击事件
                    function changeCheckCode(img) {
                        img.src = "checkCode?" + new Date().getTime();
                    }
                </script>
            </div>
            <c:if test="${not empty errMsg}">
                <div class="alert alert-danger text-center">
                        ${ errMsg }
                </div>
            </c:if>
            <div class="reg">没有账户？<a href="javascript:location.href='/store/register.jsp';">立即注册</a></div>
            <div>
                <button class="btn btn-primary">登录</button>
            </div>
        </form>

    </div>
</div>
</body>
</html>
