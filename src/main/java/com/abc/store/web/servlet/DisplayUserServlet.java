package com.abc.store.web.servlet;

import com.abc.store.domain.User;
import com.abc.store.service.UserService;
import com.abc.store.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 显示用户信息
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/18 - 2:11
 */
@WebServlet("/displayUserServlet")
public class DisplayUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        UserService service = new UserServiceImpl();
        User user = service.findByUser(username);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/index.jsp").forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
