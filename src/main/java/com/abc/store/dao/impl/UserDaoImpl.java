package com.abc.store.dao.impl;

import com.abc.store.dao.UserDao;
import com.abc.store.domain.User;
import com.abc.store.util.JDBCUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

/**
 * @className: com.abc.store.dao.impl.UserDaoImpl
 * @author: sir
 * @description: TODO
 * @date: 2021/6/15 - 23:11
 */
public class UserDaoImpl implements UserDao {

    //使用JdbcTemplate连接数据库
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    /**
     * 根据username判断用户是否存在
     * @param username
     * @return
     */
    @Override
    public User findByUsername(String username) {

        User user = null;
        //处理异常，防止保存失败
        try {
            String sql = "select * from user where username = ?";
            user = template.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class), username);
        } catch (Exception e) {

        }

        return user;
    }

    /**
     * 插入普通用户
     * @param user
     */
    @Override
    public void save(User user) {

        String sql = "insert into user (username,password,name,birthday,sex,telephone,email,status,ban)" +
                "values(?,?,?,?,?,?,?,?,?)";
        template.update(sql, user.getUsername(),
                user.getPassword(),
                user.getName(),
                user.getBirthday(),
                user.getSex(),
                user.getTelephone(),
                user.getEmail(),
                user.getStatus(),
                user.getBan()
        );

    }

    /**
     * 根据用户名和密码查询
     * @param username
     * @param password
     * @return
     */
    @Override
    public User findByUsernameAndpassword(String username,String password) {
        User user = null;
        //处理异常，防止保存失败
        try {
            String sql = "select * from user where username = ? and password = ?";
            user = template.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class), username,password);
        } catch (Exception e) {

        }

        return user;
    }

    /**
     * 修改普通用户的信息
     * @param user
     */
    @Override
    public void updateUsers(User user) {

        String sql = "update user set password=?,name=?,sex=?,birthday=?,telephone=?,email=? where username=?";

        template.update(sql, user.getPassword(),
                user.getName(),
                user.getSex(),
                user.getBirthday(),
                user.getTelephone(),
                user.getEmail(),
                user.getUsername()
                );
    }

    /**
     * 根据普通用户的username查询
     * @param username
     * @return
     */
    @Override
    public User findByUsers(String username) {
        User user = null;
        try {
            String sql = "select * from user where username=?";
            user = template.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class),username);
        } catch (DataAccessException e) {
            e.printStackTrace();
        }

        return user;
    }

    /**
     * 查询所有的用户信息
     * @return
     */
    @Override
    public List<User> findAllUsers() {

        String sql = "select * from user";
        List<User> userList = template.query(sql, new BeanPropertyRowMapper<User>(User.class));

        return userList;
    }

    /**
     * 分页查询用户的信息
     * @return
     */
    @Override
    public int findTotalCount() {

        String sql = "select count(*) from user";

        return template.queryForObject(sql,Integer.class);
    }

    /**
     * 对用户信息进行分页查询
     * @param start
     * @param pageSize  每页显示的数量
     * @return
     */
    @Override
    public List<User> findByPage(int start, int pageSize) {
        String sql = "select * from user limit ? , ?";
        return template.query(sql,new BeanPropertyRowMapper<User>(User.class),start,pageSize);
    }

}
