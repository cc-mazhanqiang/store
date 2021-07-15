package com.abc.store.service.impl;

import com.abc.store.dao.UserDao;
import com.abc.store.dao.impl.UserDaoImpl;
import com.abc.store.domain.PageBean;
import com.abc.store.domain.User;
import com.abc.store.service.UserService;

import java.util.List;

/**
 * @className: com.abc.store.service.impl.UserServiceImpl
 * @author: sir
 * @description: TODO
 * @date: 2021/6/15 - 23:10
 */
public class UserServiceImpl implements UserService {

    private UserDao userDao = new UserDaoImpl();

    /**
     * 对所有的用户信息进行分页操作
     * @param currentPage 当前页
     * @param pageSize 每页显示的数量
     * @return
     */
    @Override
    public PageBean<User> pageQuery(int currentPage, int pageSize) {

        //封装PageBean对象
        PageBean<User> pageBean = new PageBean<User>();
        //设置当前页码
        pageBean.setCurrentPage(currentPage);
        //设置每页显示条数
        pageBean.setPageSize(pageSize);

        //设置总记录数
        int totalCount = userDao.findTotalCount();
        pageBean.setTotalCount(totalCount);

        //设置当前页显示的数据集合
        int start = (currentPage - 1) * pageSize;//开始的记录数
        List<User> list = userDao.findByPage(start,pageSize);
        pageBean.setList(list);

        //设置总页数 = 总记录数 / 每页显示条数
        int totalPage = totalCount % pageSize == 0 ? totalCount / pageSize : (totalCount / pageSize) + 1;
        pageBean.setTotalPage(totalPage);

        return pageBean;
    }

    /**
     * 用户注册
     *
     * @param user
     * @return
     */
    @Override
    public boolean regist(User user) {
        //根据用户名查询用户对象
        User u = userDao.findByUsername(user.getUsername());
        if (u != null) {
            return false;
        }
        //当数据库中没有该用户调用save方法保存用户
        user.setStatus("普通会员");//默认设置为普通会员
        user.setBan("Y");//默认设置为允许登录
        userDao.save(user);

        return true;
    }

    /**
     * 登录方法
     *
     * @param user
     * @return
     */
    @Override
    public User login(User user) {

        return userDao.findByUsernameAndpassword(user.getUsername(), user.getPassword());
    }

    /**
     * 修改普通用户的信息
     *
     * @param user
     * @return
     */
    @Override
    public void updateUser(User user) {
        userDao.updateUsers(user);
    }

    /**
     * 根据username查询用户
     * @param username
     * @return
     */
    @Override
    public User findByUser(String username) {
        return userDao.findByUsers(username);
    }

    /**
     * 查询所有的用户信息
     * @return
     */
    @Override
    public List<User> findAllUser() {
        return userDao.findAllUsers();
    }

}
