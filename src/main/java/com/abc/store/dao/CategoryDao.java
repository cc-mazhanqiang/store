package com.abc.store.dao;

import com.abc.store.domain.Category;
import com.abc.store.domain.Category_son;

import java.util.List;

/**
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/18 - 21:43
 */
public interface CategoryDao {

    public List<Category> findAll();

    public List<Category_son> findAllCategory_Son();
}
