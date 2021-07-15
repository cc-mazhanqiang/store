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
 * 根据username查询用户
 *
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/17 - 20:46
 */
@WebServlet("/findByUserServlet")
public class FindByUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        UserService service = new UserServiceImpl();
        User user = service.findByUser(username);
        request.getSession().setAttribute("user", user);

        request.getRequestDispatcher("/updateUser.jsp").forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
