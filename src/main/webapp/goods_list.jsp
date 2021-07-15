<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <title>商品分类列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.min.css"/>
    <script type="text/javascript" src="./jquery/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="./popper.js/popper.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap.min.js"></script>

    <script>
        $(function () {

            $.get("/store/categoryServlet", {}, function (data) {
                //[{cid:1,cname:冰箱},{},{}]
                //遍历数组,拼接字符串<li>
                var lis = '';
                for (var i = 0; i < data.length; i++) {
                    var li = '<li><a href="goods_list.jsp?cid=' + data[i].cid + '" style="margin-left: 50px">' + data[i].cname + '</a></li>';
                    lis += li;
                }

                lis += '<li class="dropdown"><a href="#" class="dropdown-toggle"\n' +
                    '                                                data-toggle="dropdown" role="button" aria-haspopup="true"\n' +
                    '                                                aria-expanded="false" style="margin-left: 30px">智能家电<span\n' +
                    '                                class="caret"></span></a>\n' +
                    '                            <ul id="category_son" class="dropdown-menu">\n' +

                    '                            </ul>\n' +
                    '                        </li>';
                //将lis字符串，设置到ul的内容中
                $("#nav").html(lis);

                /*
                 <li><a href="index.jsp">首页</a></li>
            <!-- <li><a href="#">Library</a></li> -->
            <li class="active"></li>
                 */

                var search = location.search;
                var cid = search.split("=")[1];
                var cname = '';
                var shouye = '';
                var current = '';
                var leibie = '';

                var bg = '';
                var bx = '';
                var kt = '';
                var xyj = '';
                var rsq = '';

                if (cid == 1) {
                    cname = "冰箱";
                    shouye = ' <li><a href="index.jsp">首页</a></li>';
                    current = ' <li class="active">' + cname + '</li>';

                    bx = ' <img src="./img/bac1.jpg" class="img-responsive">';
                    bg += bx;

                    leibie += shouye;
                    leibie += current;
                    // $("#leibie").html(leibie);
                } else if (cid == 2) {
                    cname = "空调";
                    shouye = ' <li><a href="index.jsp">首页</a></li>';
                    current = ' <li class="active">' + cname + '</li>';

                    kt = ' <img src="./img/bac2.jpg" class="img-responsive">';
                    bg += kt;

                    leibie += shouye;
                    leibie += current;
                }else if (cid == 3) {
                    cname = "洗衣机";
                    shouye = ' <li><a href="index.jsp">首页</a></li>';
                    current = ' <li class="active">' + cname + '</li>';

                    xyj = '<img src="./img/bac3.jpg" class="img-responsive">';
                    bg += xyj;

                    leibie += shouye;
                    leibie += current;
                }else if (cid == 4) {
                    cname = "热水器";
                    shouye = ' <li><a href="index.jsp">首页</a></li>';
                    current = ' <li class="active">' + cname + '</li>';

                    rsq = '<img src="./img/bac4.jpg" class="img-responsive">';
                    bg += rsq;

                    leibie += shouye;
                    leibie += current;
                }


                $("#leibie").html(leibie);
                $("#bg").html(bg);

            });

            <%--查询首页子菜单导航栏分类数据--%>
            $.get("/store/categorySonServlet", {}, function (data) {
                //[{cid:1,cname:电视},{},{}]
                //遍历数组,拼接字符串<li>
                var lis = '';
                for (var i = 0; i < data.length; i++) {
                    var li = '<li><a href="#">' + data[i].cname + '</a></li>';
                    lis += li;
                }

                //将lis字符串，设置到ul的内容中
                $("#category_son").html(lis);

            });

        });

        $(function () {

            var search = location.search;
            var cid = search.split("=")[1];
            load(cid);

        });


        function load(cid,currentPage) {
            $.get("/store/findGoodsServlet", {cid:cid,currentPage: currentPage}, function (pageBean) {
                //显示查询的结果
                var lists = '';

                for (var i = 0; i < pageBean.list.length; i++) {
                    //获取{id:1,name:   ...}
                    var goods = pageBean.list[i];

                    var div = '<div class="col-md-3">\n' +
                        '                <div style="height: 280px;background-color: gainsboro;">\n' +
                        '                    <a href="/store/findGoodByIdServlet?id='+goods.id+'" class="thumbnail"><img src="data:image/jpeg;base64,' + goods.pic + '" style="height: 150px;"></a>\n' +
                        '                    <div class="caption" style="text-align: center;">\n' +
                        '                        <h3>' + goods.name + '</h3>\n' +
                        '                        <p style="font-size: larger;font-weight: bolder;">\n' +
                        '                            参考价：<span style="color: #0071ba">￥' + goods.price + '</span>\n' +
                        '                        </p>\n' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        '            </div>';

                    lists += div;
                }
                $("#list").html(lists);


                var lis = '';

                var display = '共' + pageBean.totalCount + '条,第' + pageBean.currentPage + '/' + pageBean.totalPage + '页&nbsp;&nbsp;|&nbsp;&nbsp;';
                var firstPage = '<a class="btn btn-sm btn-info" href="javascript:load('+cid+')">首页</a>&nbsp;';

                //计算上一页的页码
                var preNum = pageBean.currentPage - 1;
                if (preNum <= 0) {
                    preNum = 1;
                }
                var prePage = '<a class="btn btn-sm btn-info" href="javascript:load('+cid+',' + preNum + ')">上一页</a>&nbsp;';

                //计算下一页的页码
                var nextNum = pageBean.currentPage + 1;
                if (nextNum >= pageBean.totalPage) {
                    nextNum = pageBean.totalPage;
                }
                var nextPage = '<a class="btn btn-sm btn-info" href="javascript:load('+cid+',' + nextNum + ')">下一页</a>&nbsp;';

                var totalPage = pageBean.totalPage;
                var lastPage = '<a class="btn btn-sm btn-info" href="javascript:load('+cid+',' + totalPage + ')">末页</a>&nbsp;';

                //跳转到第几页
                var pageGo = $("#pageNo").val();//获取输入框中当前的页码

                if (pageGo <= 0) {
                    pageGo = 1;
                }
                if (pageGo >= pageBean.totalPage) {
                    pageGo = pageBean.totalPage;
                }
                var goto = ' &nbsp;|&nbsp;\n' +
                    '                到&nbsp;<input type="text" class="text-center" id="pageNo" size=4 style="text-align:right;"/> 页\n' +
                    '                <a id="btn" class="btn btn-sm btn-info" href="javascript:load('+cid+',' + pageGo + ')"> 跳 转 </a>';

                lis += display;
                lis += firstPage;
                lis += prePage;
                lis += nextPage;
                lis += lastPage;
                lis += goto;

                $("#page").html(lis);
                window.scrollTo(0, 0);
            });
        }


    </script>

</head>
<body>
<div class="container">
    <div class="row">
        <nav class="navbar navbar-default" style="margin-top: 10px;">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                            data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand">首页</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav" id="nav">
                        <%--<li><a href="#">冰箱</a></li>--%>
                        <%--<li><a href="#">空调</a></li>--%>
                        <%--<li><a href="#">洗衣机</a></li>--%>
                        <%--<li><a href="#">热水器</a></li>--%>
                        <%--<li class="dropdown">--%>
                        <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"--%>
                        <%--aria-haspopup="true" aria-expanded="false">智能家电<span class="caret"></span></a>--%>
                        <%--<ul class="dropdown-menu">--%>
                        <%--<li><a href="#">电视</a></li>--%>
                        <%--<li><a href="#">冷柜</a></li>--%>
                        <%--</ul>--%>
                        <%--</li>--%>
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                        <c:if test="${not empty loginUser}">
                            <li>
                                <a href="${pageContext.request.contextPath}/findByUserServlet?username=${loginUser.username}">
                            <span class="glyphicon glyphicon-user" aria-hidden="true" style="margin-top: 3px">
                            </span></a></li>
                        </c:if>
                        <c:if test="${empty loginUser}">
                            <li><a href="${pageContext.request.contextPath}/login.jsp">登录</a></li>
                            <li><a href="${pageContext.request.contextPath}/register.jsp">注册</a></li>
                        </c:if>
                        <c:if test="${empty user}">
                            <li class="nav-item">
                                <a class="nav-link">
                                    <i class="fas fa-user" style="color:deeppink"></i>${loginUser.name}
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${not empty user}">
                            <li class="nav-item">
                                <a class="nav-link">
                                    <i class="fas fa-user" style="color:deeppink"></i>${user.name}
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${not empty loginUser}">
                            <li class="nav-item">
                                <a class="nav-link" href="javascript:location.href='exitServlet'">退出系统</a>
                            </li>

                            <li><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"
                                      style="margin-top: 16px;margin-left: 20px"></span></li>
                            <li><a href="#">购物车</a></li>
                        </c:if>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
    </div>

    <!-- 商品信息的显示 -->

    <div class="row" id="bg">

        <%--<img src="./img/bac1.jpg" class="img-responsive">--%>

    </div>


    <div class="page-header" style="margin-top: 30px;">

        <ol class="breadcrumb" id="leibie">
            <li><a href="index.jsp">首页</a></li>
            <!-- <li><a href="#">Library</a></li> -->
            <li class="active"></li>
        </ol>

    </div>


    <div class="row" id="list">
        <div class="col-xs-6 col-md-3">
            <a href="#" class="thumbnail"><img src="./img/list2.jpg"></a>
            <div class="caption" style="text-align: center;">
                <h3>无外桶波轮洗衣机</h3>
                <p style="font-size: larger;font-weight: bolder;">
                    参考价：<span style="color: #0071ba">￥18888</span>
                </p>
            </div>
        </div>
        <div class="col-xs-6 col-md-3">
            <a href="#" class="thumbnail">
                <img src="./img/hei2.jpg">
            </a>
            <h3>无外桶波轮洗衣机</h3>
            <p style="font-size: larger;font-weight: bolder;">
                参考价：<span style="color: #0071ba">￥18888</span>
            </p>
        </div>
        <div class="col-xs-6 col-md-3">
            <a href="#" class="thumbnail">
                <img src="./img/hei3.jpg">
            </a>
            <h3>无外桶波轮洗衣机</h3>
            <p style="font-size: larger;font-weight: bolder;">
                参考价：<span style="color: #0071ba">￥18888</span>
            </p>
        </div>
        <div class="col-xs-6 col-md-3">
            <a href="#" class="thumbnail">
                <img src="./img/hei4.jpg">
            </a>
            <h3>无外桶波轮洗衣机</h3>
            <p style="font-size: larger;font-weight: bolder;">
                参考价：<span style="color: #0071ba">￥18888</span>
            </p>
        </div>
    </div>

    <%--<div class="row">--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/list2.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/hei2.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/hei3.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/hei4.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--</div>--%>

    <%--<div class="row">--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/list2.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/hei2.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/hei3.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/hei4.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--</div>--%>

    <%--<div class="row">--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/list2.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/hei2.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/hei3.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--<div class="col-xs-6 col-md-3">--%>
    <%--<a href="#" class="thumbnail">--%>
    <%--<img src="./img/hei4.jpg">--%>
    <%--</a>--%>
    <%--<h3>无外桶波轮洗衣机</h3>--%>
    <%--<p style="font-size: larger;font-weight: bolder;">--%>
    <%--参考价：<span style="color: #0071ba">￥18888</span>--%>
    <%--</p>--%>
    <%--</div>--%>
    <%--</div>--%>

    <!-- 分页 -->
    <div class="col-md-12 text-right" id="page" style="margin-bottom: 10px;margin-right: 15px;">
        共<span id="totalCount"></span>条,第<span id="currentPage"></span>/<span id="totalPage"></span>页 |

        <a class="btn btn-md btn-info" href="#">首页</a>&nbsp;


        <a class="btn btn-md btn-info" href="#">上一页</a>&nbsp;

        <a class="btn btn-md btn-info" href="#">下一页</a>&nbsp;


        <a class="btn btn-md btn-info" href="#">末页</a>&nbsp;

        &nbsp;|&nbsp;
        到&nbsp;<input type="text" class="text-center" id="pageNo" size=4 style="text-align:right;"/> 页
        <a class="btn btn-md btn-info" href="#"> 跳 转 </a>
    </div>

</div>

</body>
</html>
