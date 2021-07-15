<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>用户信息修改和显示</title>

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
        <nav class="navbar navbar-default" style="margin-top: 10px;">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed"
                            data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                            aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span> <span
                            class="icon-bar"></span> <span class="icon-bar"></span> <span
                            class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">首页</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse"
                     id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li><a href="#" style="margin-left: 50px">冰箱</a></li>
                        <li><a href="#" style="margin-left: 30px">空调</a></li>
                        <li><a href="#" style="margin-left: 30px">洗衣机</a></li>
                        <li><a href="#" style="margin-left: 30px">热水器</a></li>
                        <li class="dropdown"><a href="#" class="dropdown-toggle"
                                                data-toggle="dropdown" role="button" aria-haspopup="true"
                                                aria-expanded="false" style="margin-left: 30px">智能家电<span
                                class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">电视</a></li>
                                <li><a href="#">冷柜</a></li>
                            </ul>
                        </li>
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                        <c:if test="${not empty loginUser}">
                            <li><a href="${pageContext.request.contextPath}/publicUser.jsp">
                            <span class="glyphicon glyphicon-user" aria-hidden="true" style="margin-top: 3px">
                            </span></a></li>
                        </c:if>
                        <c:if test="${empty loginUser}">
                            <li><a href="${pageContext.request.contextPath}/login.jsp">登录</a></li>
                            <li><a href="${pageContext.request.contextPath}/register.jsp">注册</a></li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link">
                                <i class="fas fa-user" style="color:deeppink"></i> ${user.name}
                            </a>
                        </li>
                        <c:if test="${not empty loginUser}">
                            <li class="nav-item">
                                <a class="nav-link" href="javascript:location.href='exitServlet'">退出系统</a>
                            </li>

                            <li><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"
                                      style="margin-top: 16px;margin-left: 20px"></span></li>
                            <li><a href="#">购物车</a></li>
                        </c:if>

                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container-fluid --> </nav>
    </div>

    <div class="container">
        <div class="row">
            <h2><b>个人信息</b></h2>
            <hr>
        </div>
        <div class="row">
            <table class="table table-hover">
                <tr>
                    <th>用户账号：</th>
                    <td>${user.username}</td>
                </tr>
                <tr>

                    <th>账号密码：</th>
                    <td>${user.password}</td>

                </tr>

                <tr>

                    <th>用户姓名：</th>
                    <td>${user.name}</td>

                </tr>

                <tr>
                    <th>用户性别：</th>
                    <td>${user.sex}</td>

                </tr>

                <tr>
                    <th>出生日期：</th>
                    <td>${user.birthday}</td>

                </tr>
                <tr>
                    <th>用户手机：</th>
                    <td>${user.telephone}</td>

                </tr>
                <tr>
                    <th>用户邮箱：</th>
                    <td>${user.email}</td>

                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>

