package com.abc.store.service;

import com.abc.store.domain.PageBean;
import com.abc.store.domain.User;

import java.util.List;

/**
 * @className: com.abc.store.service.UserService
 * @author: sir
 * @description: TODO
 * @date: 2021/6/15 - 23:10
 */
public interface UserService {

    PageBean<User> pageQuery(int currentPage, int pageSize);

    boolean regist(User user);

    User login(User user);

    void updateUser(User user);

    User findByUser(String username);

    List<User> findAllUser();
}
