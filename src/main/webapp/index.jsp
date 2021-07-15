<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>store</title>
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


    <script>
        <%--查询首页导航栏分类数据--%>
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
                $("#category").html(lis);

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
            // var search = location.search;
            // var name = search.split("=")[1].split("&")[0];
            // var goodone = search.split("=")[2].split("&")[0];
            // var goodtwo = search.split("=")[3];

            var gname = getParameter("gname");
            var goodone = getParameter("goodone");
            var goodtwo = getParameter("goodtwo");


            if (gname){
                gname = window.decodeURIComponent(gname);
                // alert(gname);
            }

            if (gname == null){

                gname = "";
                gname = window.decodeURIComponent(gname);
                // alert(0);

            }


            // alert(gname);
            // alert(goodone);
            // alert(goodtwo);

            if (goodone === null){
                goodone = 0;
                // alert(0)
            }


            if(goodtwo === null){
                goodtwo = 0;
                // alert(0);
            }

            load(null, gname, goodone, goodtwo);

        });


        function load(currentPage, gname, goodone, goodtwo) {
            $.get("/store/goodListServlet", {currentPage: currentPage, gname: gname, goodone: goodone, goodtwo: goodtwo}, function (pageBean) {
                //显示查询的结果
                var lists = '';

                for (var i = 0; i < pageBean.list.length; i++) {
                    //获取{id:1,name:   ...}
                    var goods = pageBean.list[i];
                    var div = '<div class="col-md-3">\n' +
                        '                <div style="height: 280px;background-color: gainsboro;">\n' +
                        '                    <a href="/store/findGoodByIdServlet?id=' + goods.id + '" class="thumbnail"><img src="data:image/jpeg;base64,' + goods.pic + '" style="height: 150px;"></a>\n' +
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
                var firstPage = '<a class="btn btn-sm btn-info" href="javascript:load(1,\'' + gname + '\', ' + goodone + ',' + goodtwo + ')">首页</a>&nbsp;';

                //计算上一页的页码
                var preNum = pageBean.currentPage - 1;
                if (preNum <= 0) {
                    preNum = 1;
                }
                var prePage = '<a class="btn btn-sm btn-info" href="javascript:load(' + preNum + ',\'' + gname + '\',' + goodone + ',' + goodtwo + ')">上一页</a>&nbsp;';

                //计算下一页的页码
                var nextNum = pageBean.currentPage + 1;
                if (nextNum >= pageBean.totalPage) {
                    nextNum = pageBean.totalPage;
                }
                var nextPage = '<a class="btn btn-sm btn-info" href="javascript:load(' + nextNum + ',\'' + gname + '\', ' + goodone + ',' + goodtwo + ')">下一页</a>&nbsp;';

                var totalPage = pageBean.totalPage;
                var lastPage = '<a class="btn btn-sm btn-info" href="javascript:load(' + totalPage + ',\'' + gname + '\', ' + goodone + ',' + goodtwo + ')">末页</a>&nbsp;';

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
                    '                <a id="btn" class="btn btn-sm btn-info" href="javascript:load(' + pageGo + ',\'' + gname + '\',' + goodone + ',' + goodtwo + ')"> 跳 转 </a>';

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

    <%--引入外部文件获取链接的值--%>
    <script type="text/javascript" src="./js/getParameter.js"></script>

</head>

<body style="background-color: gainsboro;">

<div class="container">
    <!-- 导航栏 -->
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
                    <a class="navbar-brand">首页</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul id="category" class="nav navbar-nav">
                        <%--<li><a href="#" style="margin-left: 30px">冰箱</a></li>--%>
                        <%--<li><a href="#" style="margin-left: 30px">空调</a></li>--%>
                        <%--<li><a href="#" style="margin-left: 30px">洗衣机</a></li>--%>
                        <%--<li><a href="#" style="margin-left: 30px">热水器</a></li>--%>
                        <%--<li class="dropdown"><a href="#" class="dropdown-toggle"--%>
                        <%--data-toggle="dropdown" role="button" aria-haspopup="true"--%>
                        <%--aria-expanded="false" style="margin-left: 30px">智能家电<span--%>
                        <%--class="caret"></span></a>--%>
                        <%--<ul id="category_son" class="dropdown-menu">--%>
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
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container-fluid --> </nav>
    </div>

    <!-- 轮播图 -->
    <div class="row">

        <div id="carousel-example-generic" class="carousel slide"
             data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#carousel-example-generic" data-slide-to="0"
                    class="active"></li>
                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <img src="./img/1.jpg">
                </div>
                <div class="item">
                    <img src="./img/2.jpg">
                </div>
                <div class="item">
                    <img src="./img/3.jpg">
                </div>
            </div>

            <!-- Controls -->
            <a class="left carousel-control" href="#carousel-example-generic"
               role="button" data-slide="prev"> <span
                    class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a> <a class="right carousel-control" href="#carousel-example-generic"
                    role="button" data-slide="next"> <span
                class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
        </div>
    </div>


    <!-- 商品列表 -->
    <div>

        <div>
            <hr style="border-color: #000000; margin-bottom: 0px;"/>
            <ul class="nav nav-tabs nav-justified" style="font-size: 24px;">
                <li role="presentation"><a>颜值控</a></li>
                <!-- 		<li role="presentation"><a href="#">黑科技</a></li>
                    <li role="presentation"><a href="#">青春时尚</a></li> -->
            </ul>
            <hr style="border-color: #000000; margin-top: 0px;"/>
        </div>

        <!-- 组合查询 -->

        <div class="row" style="margin-bottom: 20px;">
            <div class="col-md-2">
                <%--<input type="text" id="goodname" class="form-control" placeholder="请输入名称">--%>
            </div>
            <div class="col-md-4">
                <%--<input type="text" id="goodname" class="form-control" placeholder="请输入名称">--%>
                <select id="goodname" class="form-control">
                    <option value="">-请选择类别-</option>
                    <option value="冰箱">冰箱</option>
                    <option value="空调">空调</option>
                    <option value="洗衣机">洗衣机</option>
                    <option value="热水器">热水器</option>
                </select>
            </div>
            <div class="col-md-4">
                <%--<input type="text" id="goodpriceone" class="form-control" placeholder="请输入价格">--%>
                <select id="goodprice" class="form-control">
                    <option value="">-请选择价格-</option>
                    <option value="1-1999">1-1999</option>
                    <option value="2000-3999">2000-3999</option>
                    <option value="4000-5999">4000-5999</option>
                    <option value="6000-7999">6000-7999</option>
                    <option value="8000-9999">8000-9999</option>
                    <option value="10000-12999">10000-12999</option>
                </select>
            </div>
            <div class="col-md-2">
                <%--<input type="text" id="goodpricetwo" class="form-control" placeholder="请输入价格">--%>
            </div>
            <div class="col-md-1" id="sousuo">
                <a class="btn btn-primary" id="search" href="javascript:;">搜索</a>
            </div>

            <script>

                //获取搜索框的内容，给按钮绑定点击事件
                $("#search").click(function () {
                    var gname = "";
                    var goodone = 0;
                    var goodtwo = 0;
                    //获取第一个输入框的值
                    var name = $("#goodname").val();

                    if (name){
                        gname = window.decodeURIComponent(name);
                    }

                    //获取第二个输入框的值
                    var goodprice = $("#goodprice").val();
                    if (goodprice === "1-1999") {
                        goodone = 1;
                        goodtwo = 1999;
                    } else if (goodprice === "2000-3999") {
                        // alert("你好")
                        goodone = 2000;
                        goodtwo = 3999;
                    } else if (goodprice === "4000-5999") {
                        // alert("你好")
                        goodone = 4000;
                        goodtwo = 5999;
                    } else if (goodprice === "6000-7999") {
                        // alert("你好")
                        goodone = 6000;
                        goodtwo = 7999;
                    } else if (goodprice === "8000-9999") {
                        // alert("你好")
                        goodone = 8000;
                        goodtwo = 9999;
                    } else if (goodprice === "10000-12999") {
                        // alert("你好")
                        goodone = 10000;
                        goodtwo = 12999;
                    }
                    location.href = "http://localhost:8080/store/index.jsp?gname=" + gname + "&goodone=" + goodone + "&goodtwo=" + goodtwo;

                });

            </script>

        </div>


        <div id="list">

            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list2.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>变频十字对开门冰箱</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list2.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>高富氧蓝焰燃气热水器</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list3.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>13公斤滚筒洗烘一体机</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list4.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>58寸4K超高清平板电视</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list5.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>电子触摸按键吸油烟机</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list2.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>变频十字对开门冰箱</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list2.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>高富氧蓝焰燃气热水器</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list3.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>13公斤滚筒洗烘一体机</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list4.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>58寸4K超高清平板电视</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list5.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>电子触摸按键吸油烟机</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list5.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>电子触摸按键吸油烟机</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="thumbnail" style="height: 280px;background-color: gainsboro;">
                    <a href="#"><img src="./img/list5.jpg" style="height: 150px;"></a>
                    <div class="caption" style="text-align: center;">
                        <h3>电子触摸按键吸油烟机</h3>
                        <p style="font-size: larger;font-weight: bolder;">
                            参考价：<span style="color: #0071ba">￥18888</span>
                        </p>
                    </div>
                </div>
            </div>

        </div>
    </div>

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
</div>


</div>
</body>
</html>

