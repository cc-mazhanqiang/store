package com.abc.store.web.servlet;

import com.abc.store.domain.Goods;
import com.abc.store.service.GoodService;
import com.abc.store.service.impl.GoodServiceImpl;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @className:
 * @author: sir
 * @description: 添加商品
 * @date: 2021/6/23 - 13:03
 */
@WebServlet("/addGoodsServlet")
public class AddGoodsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        //初始化SFU
        //获得当前WEB服务器的临时文件夹的位置
        File tempFile = new File(System.getProperty("java.io.tmpdir"));

        //在fileupload工具库中，任何一个输入域都是一个磁盘文件项
        DiskFileItemFactory factory = new DiskFileItemFactory();
        //最多能够支持一次性提供4096个磁盘文件项
        factory.setSizeThreshold(4096);
        //提供临时文件夹位置，以方便操作
        factory.setRepository(tempFile);
        //创建sfu,绑定factory
        ServletFileUpload sfu = new ServletFileUpload(factory);
        //设置单文件上传的最大体积
        sfu.setSizeMax(5000000);

        List<FileItem> fileItems = null;
        Goods goods = new Goods();

        if (sfu.isMultipartContent(request)) {  //判断request是否是多段提交
            try {
                fileItems = sfu.parseRequest(request);   //对请求进行过滤，获得所有的fileitem.
                for (FileItem item : fileItems) {
                    if (item.isFormField() && item.getFieldName().equals("goodid")) {
                        goods.setId(item.getString("utf-8"));
                    } else if (item.isFormField() && item.getFieldName().equals("goodname")) {
                        goods.setName(item.getString("utf-8"));
                    } else if (item.isFormField() && item.getFieldName().equals("goodprice")) {
                        goods.setPrice(item.getString("utf-8"));
                    } else if (item.isFormField() && item.getFieldName().equals("goodcid")) {
                        goods.setCid(Integer.parseInt(item.getString("utf-8")));
                    } else if (!item.isFormField() && item.getFieldName().equals("goodpic")) {
                        byte[] goodpic = new byte[(int) item.getSize()];
                        item.getInputStream().read(goodpic, 0, (int) item.getSize());
                        goods.setPic(goodpic);
                    }
                }
            } catch (FileUploadException e) {
                e.printStackTrace();
            }
        }

//        System.out.println(goods);

        GoodService service = new GoodServiceImpl();
        service.addgoods(goods);

        request.getRequestDispatcher("/allGoods.jsp").forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
