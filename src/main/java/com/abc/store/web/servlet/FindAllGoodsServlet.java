package com.abc.store.web.servlet;

import com.abc.store.domain.Goods;
import com.abc.store.domain.PageBean;
import com.abc.store.service.GoodService;
import com.abc.store.service.impl.GoodServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @className:
 * @author: sir
 * @description: 查找所有的商品信息，并进行分页操作
 * @date: 2021/6/23 - 13:13
 */
@WebServlet("/findAllGoodsServlet")
public class FindAllGoodsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        GoodService service = new GoodServiceImpl();

        String currentPageStr = request.getParameter("currentPage");
        String pageSizeStr = request.getParameter("pageSize");

        int currentPage = 0;//当前页码 如果值为空 则默认为1
        if (currentPageStr != null && currentPageStr.length() > 0) {
            currentPage = Integer.parseInt(currentPageStr);
        } else {
            currentPage = 1;
        }

        int pageSize = 0;//每页显示的条数，如果值为空 则默认为6条
        if (pageSizeStr != null && pageSizeStr.length() > 0) {
            pageSize = Integer.parseInt(pageSizeStr);
        } else {
            pageSize = 6;
        }


        PageBean<Goods> pageBean = service.pageQuerygood(currentPage, pageSize);


        //使用序列化json返回到页面
        ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json;charset=utf-8");
        mapper.writeValue(response.getOutputStream(),pageBean);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }
}
