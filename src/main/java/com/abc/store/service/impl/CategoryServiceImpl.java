package com.abc.store.service.impl;


import com.abc.store.dao.CategoryDao;
import com.abc.store.dao.impl.CategoryDaoImpl;
import com.abc.store.domain.Category;
import com.abc.store.domain.Category_son;
import com.abc.store.service.CategoryService;
import com.abc.store.util.JedisUtil;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.Tuple;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/18 - 21:49
 */
public class CategoryServiceImpl implements CategoryService {

    private CategoryDao categoryDao = new CategoryDaoImpl();

    /**
     * 查询导航栏分类的信息
     * 使用redis缓存
     *
     * @return
     */
    @Override
    public List<Category> findAllCategory() {
        //使用工具类连接redis
        Jedis jedis = JedisUtil.getJedis();
        //从redis中查询cid、cname
        Set<Tuple> categorys = jedis.zrangeWithScores("category", 0, -1);
        List<Category> all = null;
        if (categorys == null || categorys.size() == 0) {
            //从数据库查询并存入redis中
            all = categoryDao.findAll();
            for (int i = 0; i < all.size(); i++) {
                jedis.zadd("category", all.get(i).getCid(), all.get(i).getCname());

            }

        } else {
            //将set集合中的数据存到list集合中，统一数据
            all = new ArrayList<Category>();
            for (Tuple tuple : categorys) {
                Category category = new Category();
                category.setCid((int) tuple.getScore());
                category.setCname(tuple.getElement());
                all.add(category);//添加到list集合中
            }
        }
        return all;
    }

    /**
     * 查询子菜单导航栏分类的信息
     *
     * @return
     */
    @Override
    public List<Category_son> findAllCategory_Son() {
        //使用工具类连接redis
        Jedis jedis = JedisUtil.getJedis();
        Set<Tuple> category_sons = jedis.zrangeWithScores("category_son", 0, -1);
        List<Category_son> all_son = null;
        if (category_sons == null || category_sons.size() == 0) {
            //从数据库查询并存入redis中
            all_son = categoryDao.findAllCategory_Son();
            for (int i = 0; i < all_son.size(); i++) {
                jedis.zadd("category_son", all_son.get(i).getCid(), all_son.get(i).getCname());

            }

        } else {
            //将set集合中的数据存到list集合中，统一数据
            all_son = new ArrayList<Category_son>();
            for (Tuple tuple_son : category_sons) {
                Category_son category_son = new Category_son();
                category_son.setCid((int) tuple_son.getScore());
                category_son.setCname(tuple_son.getElement());
                all_son.add(category_son);//添加到list集合中
            }
        }
        return all_son;
    }
}
