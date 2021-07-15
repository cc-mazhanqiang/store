package com.abc.store.service.impl;

import com.abc.store.dao.GoodDao;
import com.abc.store.dao.impl.GoodDaoImpl;
import com.abc.store.domain.Goods;
import com.abc.store.domain.PageBean;
import com.abc.store.service.GoodService;

import java.util.List;

/**
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/23 - 13:06
 */
public class GoodServiceImpl implements GoodService {
    private GoodDao goodDao = new GoodDaoImpl();

    /**
     * 添加商品信息
     * @param goods
     */
    @Override
    public void addgoods(Goods goods) {
        goodDao.addgoods(goods);
    }

    /**
     * 查询所有的商品信息
     * @param currentPage
     * @param pageSize
     * @return
     */
    @Override
    public PageBean<Goods> pageQuerygood(int currentPage, int pageSize) {

        //封装PageBean对象
        PageBean<Goods> page = new PageBean<Goods>();
        //设置当前页码
        page.setCurrentPage(currentPage);
        //设置每页显示条数
        page.setPageSize(pageSize);

        //设置总记录数
        int totalCount = goodDao.findGoodTotalCount();
        page.setTotalCount(totalCount);

        //设置当前页显示的数据集合
        int start = (currentPage - 1) * pageSize;//开始的记录数
        List<Goods> list = goodDao.findGoodByPage(start,pageSize);
        page.setList(list);

        //设置总页数 = 总记录数 / 每页显示条数
        int totalPage = totalCount % pageSize == 0 ? totalCount / pageSize : (totalCount / pageSize) + 1;
        page.setTotalPage(totalPage);

        return page;
    }

    /**
     * 根据cid查询商品信息
     * @param currentPage
     * @param pageSize
     * @return
     */
    @Override
    public PageBean<Goods> pageQueryAll(int currentPage, int pageSize,String name, int goodone, int goodtwo) {
        //封装PageBean对象
        PageBean<Goods> pageAll = new PageBean<Goods>();
        //设置当前页码
        pageAll.setCurrentPage(currentPage);
        //设置每页显示条数
        pageAll.setPageSize(pageSize);

        //设置总记录数
        int totalCount = goodDao.findAllTotalCount(name,goodone,goodtwo);
        pageAll.setTotalCount(totalCount);

        //设置当前页显示的数据集合
        int start = (currentPage - 1) * pageSize;//开始的记录数
        List<Goods> list = goodDao.findAllByPage(start,pageSize,name,goodone,goodtwo);
        pageAll.setList(list);

        //设置总页数 = 总记录数 / 每页显示条数
        int totalPage = totalCount % pageSize == 0 ? totalCount / pageSize : (totalCount / pageSize) + 1;
        pageAll.setTotalPage(totalPage);

        return pageAll;
    }

    /**
     * 根据商品的cid查询信息，并进行分页操作
     * @param cid
     * @param currentPage 当前页
     * @param pageSize  每页显示的数量
     * @return
     */
    @Override
    public PageBean<Goods> pageQueryBycid(int cid, int currentPage, int pageSize) {
        //封装PageBean对象
        PageBean<Goods> pagebycid = new PageBean<Goods>();
        //设置当前页码
        pagebycid.setCurrentPage(currentPage);
        //设置每页显示条数
        pagebycid.setPageSize(pageSize);

        //设置总记录数
        int totalCount = goodDao.findBycidTotalCount(cid);
        pagebycid.setTotalCount(totalCount);

        //设置当前页显示的数据集合
        int start = (currentPage - 1) * pageSize;//开始的记录数
        List<Goods> list = goodDao.findBycidPage(cid,start,pageSize);
        pagebycid.setList(list);

        //设置总页数 = 总记录数 / 每页显示条数
        int totalPage = totalCount % pageSize == 0 ? totalCount / pageSize : (totalCount / pageSize) + 1;
        pagebycid.setTotalPage(totalPage);

        return pagebycid;
    }

    /**
     * 根据商品的id查询商品信息
     * @param id
     * @return
     */
    @Override
    public Goods findGoodById(String id) {
        return goodDao.findGoodById(id);
    }

}
