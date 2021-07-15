<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.min.css"/>
    <script type="text/javascript" src="./jquery/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="./popper.js/popper.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap.min.js"></script>

    <script type="text/javascript">
        function previewImage(file) {

            var img = document.getElementById('picImg');

            if (file.files && file.files[0]) {

                //准备一个文件读取器对象，并告诉它文件读取完毕之后要做什么。
                var reader = new FileReader();
                //成功读取了图片信息后，把读取结果赋予

                //FileReader.readAsDataURL()
                //开始读取指定的Blob中的内容。一旦完成，result属性中将包含一个data: URL格式的字符串以表示所读取文件的内容。
                reader.onload = function (evt) {
                    img.src = evt.target.result;
                    console.log("read ok! img src get value!" + evt.target.result);
                }

                console.log("start to read!")
                reader.readAsDataURL(file.files[0]);

            } else {
                img.src = "/store/img/defaultPic.jpg";
                // alert("no upload file!");
            }

        }
    </script>
</head>
<body style="background-color: gainsboro;">

<div class="container">

    <ul class="nav nav-pills nav-justified" style="margin-top: 50px;">
        <li role="presentation" class="active"><a href="main.jsp">首页</a></li>
        <li role="presentation" class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"
               aria-expanded="false">
                用户管理 <span class="caret"></span>
            </a>
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
            </ul>
        </li>
    </ul>

    <div class="container-fluid">

        <div class="col-12 col-md-6" style="margin-left: 270px;margin-top: 60px;">
            <form action="/store/addGoodsServlet" method="post" enctype="multipart/form-data">

                <input type="hidden" name="" value=""/>
                <div class="form-group">
                    <label>商品识别码：</label>
                    <input name="goodid" class="form-control" placeholder="请输入商品识别码">
                </div>
                <div class="form-group">
                    <label>商品名称：</label>
                    <input name="goodname" class="form-control" placeholder="请输入商品名称">
                </div>
                <div class="form-group">
                    <label>商品价格：</label>
                    <input name="goodprice" class="form-control" placeholder="请输入商品价格">
                </div>
                <div class="form-group">
                    <label>商品类型：</label>
                    <input name="goodcid" class="form-control" placeholder="1:冰箱、2:空调、3:洗衣机、4:热水器">
                </div>
                <div class="form-group">
                    <label>商品图片</label><br>
                    <img id="picImg" src="./img/defaultPic.jpg" width="250" height="250" class="py-1"><br>
                    <input type="file" name="goodpic" class="form-control-file" onchange="previewImage(this)">
                </div>
                <input type="submit" class="btn btn-primary" value="添加商品">
            </form>
        </div>
    </div>


</div>
</body>
</html>
