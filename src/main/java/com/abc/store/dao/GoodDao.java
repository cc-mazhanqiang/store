package com.abc.store.dao;

import com.abc.store.domain.Goods;

import java.util.List;

/**
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/23 - 13:07
 */
public interface GoodDao {

    public int findGoodTotalCount();

    public List<Goods> findGoodByPage(int start, int pageSize);

    void addgoods(Goods goods);

    int findAllTotalCount(String name, int goodone, int goodtwo);

    List<Goods> findAllByPage(int start, int pageSize,String name, int goodone, int goodtwo);

    int findBycidTotalCount(int cid);

    List<Goods> findBycidPage(int cid, int start, int pageSize);

    Goods findGoodById(String id);

}
