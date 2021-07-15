package com.abc.store.web.servlet;

import com.abc.store.domain.Category_son;
import com.abc.store.service.CategoryService;
import com.abc.store.service.impl.CategoryServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @className:
 * @author: sir
 * @description: 查询子菜单导航分类栏目，并返回json对象
 * @date: 2021/6/18 - 23:36
 */
@WebServlet("/categorySonServlet")
public class CategorySonServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryService service = new CategoryServiceImpl();
        List<Category_son> son_list = service.findAllCategory_Son();

        //使用序列化json返回到页面
        ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json;charset=utf-8");
        mapper.writeValue(response.getOutputStream(), son_list);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
