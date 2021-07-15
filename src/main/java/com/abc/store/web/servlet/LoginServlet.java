package com.abc.store.web.servlet;

import com.abc.store.domain.User;
import com.abc.store.service.UserService;
import com.abc.store.service.impl.UserServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

/**
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/16 - 19:04
 */
@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //验证码的校验
        String check = request.getParameter("check");
        //从session中获取验证码
        HttpSession session = request.getSession();
        String checkcode_server = (String) session.getAttribute("CHECKCODE_SERVER");

        //防止验证码重复
        session.removeAttribute("CHECKCODE_SERVER");

        Map<String, String[]> map = request.getParameterMap();
        User user = new User();

        try {
            BeanUtils.populate(user, map);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

        UserService service = new UserServiceImpl();
        User u = service.login(user);
        if (checkcode_server == null || !checkcode_server.equalsIgnoreCase(check)) {
            request.setAttribute("errMsg", "验证码错误！");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else if (u == null) {
            request.setAttribute("errMsg", "用户名或密码错误！");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else if (u != null && "Y".equals(u.getBan()) && "普通会员".equals(u.getStatus())) {
            request.getSession().setAttribute("loginUser", u);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else if (u != null && "Y".equals(u.getBan()) && "管理员".equals(u.getStatus())) {
            request.getSession().setAttribute("loginUser", u);
            request.getRequestDispatcher("/main.jsp").forward(request, response);
        } else if (u != null && "N".equals(u.getBan())) {
            request.setAttribute("errMsg", "您的账户被冻结，请联系管理员！");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

}
