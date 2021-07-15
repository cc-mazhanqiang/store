<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>商品详细信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.min.css"/>
    <script type="text/javascript" src="./jquery/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="./popper.js/popper.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap.min.js"></script>

    <script>

        $(function () {

            var search = location.search;
            var id = search.split("=")[1];

            $.get("/store/getpicServlet", {id:id}, function (data) {

                var imgs = '';

                var ss = '<img src="data:image/jpeg;base64,'+data+'" style="width: 600px;" height="600px">';

                imgs += ss;

                $("#bigImg").html(imgs);

            });
        });

    </script>

</head>
<body>
<div class="container">
    <div class="page-header" style="margin-top: 30px;">
        <h5>
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <!-- <li><a href="#">Library</a></li> -->

                <c:if test="${good.cid == 1}">
                    <li class="active">冰箱</li>
                </c:if>
                <c:if test="${good.cid == 2}">
                    <li class="active">空调</li>
                </c:if>
                <c:if test="${good.cid == 3}">
                    <li class="active">洗衣机</li>
                </c:if>
                <c:if test="${good.cid == 4}">
                    <li class="active">热水器</li>
                </c:if>

                <li>${good.id}</li>
            </ol>
        </h5>
        <p style="font-size: 26px;margin-left: 30px;">&gt;商品详细信息</p>
    </div>

    <div>
        <div class="col-md-6" id="bigImg">
            <%--<img src="data:image/jpeg;base64," style="width: 600px;" height="600px">--%>
        </div>
        <div class="col-md-6" style="text-align: center;margin-top: 160px;">
            <h2>${good.name}</h2>
            <p>${good.id}</p>
            <div>
                <p style="margin-top: 100px;">参考价：<span style="font-weight: bolder;font-size: 26px;">￥7999</span></p>
            </div>
            <div style="margin: 100px;">
                <button type="button" class="btn btn-default btn-lg" style="margin-right: 20px;">在线购买</button>
                <button type="button" class="btn btn-default btn-lg">
                    <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>加入购物车
                </button>

            </div>
        </div>
    </div>

</div>
</body>
</html>
