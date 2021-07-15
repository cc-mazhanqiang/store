package com.abc.store.dao;

import com.abc.store.domain.User;

import java.util.List;

/**
 * @className: com.abc.store.dao.UserDao
 * @author: sir
 * @description: TODO
 * @date: 2021/6/15 - 23:11
 */
public interface UserDao {
    /**
     * 根据用户名称查询用户信息
     * @param username
     * @return
     */
    public User findByUsername(String username);

    /**
     * 保存用户的信息
     * @param user
     */
    public void save(User user);

    User findByUsernameAndpassword(String username,String password);

    void updateUsers(User user);

    User findByUsers(String username);

    List<User> findAllUsers();

    int findTotalCount();

    List<User> findByPage(int start, int pageSize);
}
