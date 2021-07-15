package com.abc.store.dao.impl;

import com.abc.store.dao.CategoryDao;
import com.abc.store.domain.Category;
import com.abc.store.domain.Category_son;
import com.abc.store.util.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

/**
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/18 - 21:44
 */
public class CategoryDaoImpl implements CategoryDao {

    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    /**
     * 查询导航栏分类信息
     *
     * @return
     */
    @Override
    public List<Category> findAll() {
        String sql = "select * from tab_category";
        return template.query(sql,new BeanPropertyRowMapper<Category>(Category.class));
    }

    /**
     * 查询子菜单导航分类信息
     * @return
     */
    @Override
    public List<Category_son> findAllCategory_Son() {
        String sql = "select * from tab_category_son";
        return template.query(sql,new BeanPropertyRowMapper<Category_son>(Category_son.class));
    }
}
