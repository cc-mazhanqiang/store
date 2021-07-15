package com.abc.store.service;

import com.abc.store.domain.Goods;
import com.abc.store.domain.PageBean;

/**
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/23 - 13:06
 */
public interface GoodService {
    void addgoods(Goods goods);

    PageBean<Goods> pageQuerygood(int currentPage, int pageSize);

    PageBean<Goods> pageQueryAll(int currentPage, int pageSize,String name, int goodone, int goodtwo);

    PageBean<Goods> pageQueryBycid(int cid, int currentPage, int pageSize);

    Goods findGoodById(String id);

}
