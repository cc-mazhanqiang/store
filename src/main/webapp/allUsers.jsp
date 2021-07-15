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

    <script>

        $(function () {
            
            load();
            
        });

        function load(currentPage) {
            $.get("/store/findAllUserServlet",{currentPage:currentPage},function (pageBean) {
                //显示查询的结果
                var lis = '';

                for (var i = 0; i < pageBean.list.length; i++) {
                    //获取{uid:1,username:张三 ...}
                    var user = pageBean.list[i];
                    var tr = '<tr>\n' +
                        '                    <td>'+user.username+'</td>\n' +
                        '                    <td>'+user.password+'</td>\n' +
                        '                    <td>'+user.name+'</td>\n' +
                        '                    <td>'+user.birthday+'</td>\n' +
                        '                    <td>'+user.sex+'</td>\n' +
                        '                    <td>'+user.telephone+'</td>\n' +
                        '                    <td>'+user.email+'</td>\n' +
                        '                    <td>'+user.status+'</td>\n' +
                        '                    <td>'+user.ban+'</td>\n' +
                        '                    <td>\n' +
                        '                        <button class="btn btn-primary btn-sm">修改</button>\n' +
                        '                        <button class="btn btn-danger btn-sm" onclick="">删除</button>\n' +
                        '                    </td>\n' +
                        '                </tr>';

                    lis += tr;
                }
                $("#list").html(lis);


                var lis = '';

                var display = '共'+pageBean.totalCount+'条,第'+pageBean.currentPage+'/'+pageBean.totalPage+'页&nbsp;&nbsp;|&nbsp;&nbsp;';
                var firstPage = '<a class="btn btn-sm btn-info" href="javascript:load()">首页</a>&nbsp;';

                //计算上一页的页码
                var preNum = pageBean.currentPage - 1;
                if (preNum <= 0){
                    preNum = 1;
                }
                var prePage = '<a class="btn btn-sm btn-info" href="javascript:load('+preNum+')">上一页</a>&nbsp;';

                //计算下一页的页码
                var nextNum = pageBean.currentPage + 1;
                if (nextNum >= pageBean.totalPage){
                    nextNum = pageBean.totalPage;
                }
                var nextPage = '<a class="btn btn-sm btn-info" href="javascript:load('+nextNum+')">下一页</a>&nbsp;';

                var totalPage = pageBean.totalPage;
                var lastPage = '<a class="btn btn-sm btn-info" href="javascript:load('+totalPage+')">末页</a>&nbsp;';

                //跳转到第几页
                var  pageGo = $("#pageNo").val();//获取输入框中当前的页码

                if (pageGo <= 0){
                    pageGo = 1;
                }
                if (pageGo >= pageBean.totalPage){
                    pageGo = pageBean.totalPage;
                }
                var goto = ' &nbsp;|&nbsp;\n' +
                    '                到&nbsp;<input type="text" class="text-center" id="pageNo" size=4 style="text-align:right;"/> 页\n' +
                    '                <a id="btn" class="btn btn-sm btn-info" href="javascript:load('+pageGo+')"> 跳 转 </a>';

                lis += display;
                lis += firstPage;
                lis += prePage;
                lis += nextPage;
                lis += lastPage;
                lis += goto;

                $("#page").html(lis);

            });
        }

        // $("#btn").click(function () {
        //     var pageGo = $("#pageNo").val();
        // });


    </script>


</head>
<body>

<div class="container">

    <ul class="nav nav-pills nav-justified" style="margin-top: 50px;">
        <li role="presentation" class="active"><a href="main.jsp">首页</a></li>
        <%--<li role="presentation" class="dropdown">--%>
        <%--<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"--%>
        <%--aria-expanded="false">--%>
        <%--用户管理 <span class="caret"></span>--%>
        <%--</a>--%>
        <%--<ul class="dropdown-menu" style="width: 100%;text-align: center;">--%>
        <%--<li><a href="#">查询用户信息</a></li>--%>
        <%--</ul>--%>
        <%--</li>--%>
        <li role="presentation" class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"
               aria-expanded="false">
                商品管理 <span class="caret"></span>
            </a>
            <ul class="dropdown-menu" style="width: 100%;text-align: center;">
                <li><a href="allGoods.jsp">查询商品信息</a></li>
                <li><a href="addgoods.jsp">添加商品信息</a></li>
            </ul>
        </li>
    </ul>

    <div class="col-md-12" style="margin-top: 60px;">

        <ul class="nav navbar-nav navbar-right" style="margin-top: -30px;margin-bottom: 10px">
            <li><span class="glyphicon glyphicon-user" aria-hidden="true" style="margin-top: 16px;"></span></li>

            <li><a>${loginUser.name}</a></li>
            <li><a href="javascript:location.href='exitServlet'">退出系统</a></li>
        </ul>
        </ul>

        <!-- 用户显示、商品显示、分页 -->
        <table class="table table-hover" style="text-align: center">
            <thead>
            <tr>
                <th style="text-align: center;">账号名称</th>
                <th style="text-align: center;">账号密码</th>
                <th style="text-align: center;">用户姓名</th>
                <th style="text-align: center;">出生日期</th>
                <th style="text-align: center;">用户性别</th>
                <th style="text-align: center;">用户手机</th>
                <th style="text-align: center;">用户邮箱</th>
                <th style="text-align: center;">用户类型</th>
                <th style="text-align: center;">登录状态</th>
                <th style="text-align: center;">操作</th>
            </tr>
            </thead>
            <tbody id="list">
            <%--<c:forEach items="${page.list}" var="user">--%>

                <tr>
                    <td>${user.username}</td>
                    <td>${user.password}</td>
                    <td>${user.name}</td>
                    <td>${user.birthday}</td>
                    <td>${user.sex}</td>
                    <td>${user.telephone}</td>
                    <td>${user.email}</td>
                    <td>${user.status}</td>
                    <td>${user.ban}</td>
                    <td>
                        <button class="btn btn-primary btn-sm">修改</button>
                        <button class="btn btn-danger btn-sm" onclick="">删除</button>
                    </td>
                </tr>
            <%--</c:forEach>--%>
            </tbody>
        </table>


        <!-- 分页 -->
        <div class="col-12 text-right" id="page">
            共<span id="totalCount"></span>条,第<span id="currentPage"></span>/<span id="totalPage"></span>页 |

            <a class="btn btn-sm btn-info" href="#">首页</a>&nbsp;


            <a class="btn btn-sm btn-info" href="#">上一页</a>&nbsp;

            <a class="btn btn-sm btn-info" href="#">下一页</a>&nbsp;


            <a class="btn btn-sm btn-info" href="#">末页</a>&nbsp;

            &nbsp;|&nbsp;
            到&nbsp;<input type="text" class="text-center" id="pageNo" size=4 style="text-align:right;"/> 页
            <a class="btn btn-sm btn-info" href="#"> 跳 转 </a>
        </div>

    </div>

</div>
</body>
</html>
