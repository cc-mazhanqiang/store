package com.abc.store.web.servlet;

import com.abc.store.domain.Goods;
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
 * @description: 获取图片，返回json对象
 * @date: 2021/6/24 - 14:48
 */
@WebServlet("/getpicServlet")
public class GetpicServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id = request.getParameter("id");
        GoodService service = new GoodServiceImpl();

        Goods good = service.findGoodById(id);

        byte[] pic = good.getPic();

        //使用序列化json返回到页面
        ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json;charset=utf-8");
        mapper.writeValue(response.getOutputStream(), pic);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }
}
