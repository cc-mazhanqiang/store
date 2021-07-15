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
 * @date: 2021/6/16 - 23:01
 */
@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //验证码的校验
        String check = request.getParameter("check");
        //从session中获取验证码
        HttpSession session = request.getSession();
        String checkcode_server = (String) session.getAttribute("CHECKCODE_SERVER");

        //防止验证码重复
        session.removeAttribute("CHECKCODE_SERVER");
        if (checkcode_server == null || !checkcode_server.equalsIgnoreCase(check)) {
            request.setAttribute("errMsg", "验证码错误！");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        //1.接收参数
        Map<String, String[]> map = request.getParameterMap();

        //2.封装到实体中
        User user = new User();
        try {
            BeanUtils.populate(user, map);
            //3.调用业务层处理封装的数据
            UserService service = new UserServiceImpl();
            boolean flag = service.regist(user);


            //4.页面跳转
            if (flag) {
                request.setAttribute("msg", "注册成功，请前往首页登录！");
                request.getRequestDispatcher("/register_ok.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "注册失败，请重新注册！");
                request.getRequestDispatcher("/register_error.jsp").forward(request, response);
            }

        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
