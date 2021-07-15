package com.abc.store.service;

import com.abc.store.domain.Category;
import com.abc.store.domain.Category_son;

import java.util.List;

/**
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/18 - 21:48
 */
public interface CategoryService {

    public List<Category> findAllCategory();

    public List<Category_son> findAllCategory_Son();
}
