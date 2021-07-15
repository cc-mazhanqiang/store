package com.abc.store.web.servlet;

import com.abc.store.domain.Goods;
import com.abc.store.service.GoodService;
import com.abc.store.service.impl.GoodServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @className:
 * @author: sir
 * @description: 根据商品的id查询商品信息
 * @date: 2021/6/24 - 13:43
 */
@WebServlet("/findGoodByIdServlet")
public class FindGoodByIdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id = request.getParameter("id");
        GoodService service = new GoodServiceImpl();

        Goods good = service.findGoodById(id);


        request.setAttribute("good",good);

        request.getRequestDispatcher("/good_details.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }
}
