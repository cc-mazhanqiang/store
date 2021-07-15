<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>后台管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.min.css"/>
    <script type="text/javascript" src="./jquery/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="./popper.js/popper.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap.min.js"></script>
</head>
<body>
<div class="container my-2" style="margin-top: 200px;">
    <div class="row py-5">
        <div class="jumbotron">
            <ul class="nav nav-pills nav-justified" style="margin-top: 50px;">
                <li role="presentation"><a href="#">首页</a></li>
                <li role="presentation" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"
                       aria-expanded="false" class="btn btn-info">
                        用户管理 <span class="caret"></span></a>
                    <ul class="dropdown-menu" style="width: 100%;text-align: center;">
                        <li><a href="/store/allUsers.jsp">查询用户信息</a></li>
                    </ul>
                </li>
                <li role="presentation" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"
                       aria-expanded="false">
                        商品管理 <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" style="width: 100%;text-align: center;">
                        <li><a href="/store/allGoods.jsp">查询商品信息</a></li>
                        <li><a href="/store/addgoods.jsp">添加商品信息</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right" style="margin-top: 50px;margin-right: 120px;">
                <li><span class="glyphicon glyphicon-user" aria-hidden="true" style="margin-top: 16px;"></span></li>
                <li><a>${loginUser.name}</a></li>
                <li><a href="javascript:location.href='exitServlet'">退出系统</a></li>
            </ul>
            <hr class="my-4">
            <h1 class="display-4">欢迎来到电子商城管理</h1>
        </div>
    </div>
</div>
</body>
</html>
