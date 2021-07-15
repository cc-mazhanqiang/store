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
 * @description: 组合查询、分页
 * @date: 2021/6/23 - 23:45
 */
@WebServlet("/goodListServlet")
public class GoodListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        GoodService goodService = new GoodServiceImpl();

        String currentPageStr = request.getParameter("currentPage");
        String pageSizeStr = request.getParameter("pageSize");

        String goodoneStr = request.getParameter("goodone");
        String goodtwoStr = request.getParameter("goodtwo");
        String nameStr = request.getParameter("gname");

        String name = null;
        if (nameStr != null && nameStr.length() > 0){
            name = new String(nameStr.getBytes("iso-8859-1"),"utf-8");
        }

        int goodone = 0;
        if (goodoneStr != null && goodoneStr.length() > 0 && !"null".equals(goodoneStr)){
            goodone = Integer.parseInt(goodoneStr);
        }
        int goodtwo = 0;
        if (goodtwoStr != null && goodtwoStr.length() > 0 && !"null".equals(goodoneStr)){
            goodtwo = Integer.parseInt(goodtwoStr);
        }

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
            pageSize = 12;
        }


        PageBean<Goods> pageBean = goodService.pageQueryAll(currentPage, pageSize,name,goodone,goodtwo);

        //使用序列化json返回到页面
        ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json;charset=utf-8");
        mapper.writeValue(response.getOutputStream(),pageBean);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }
}
