package com.abc.store.dao.impl;

import com.abc.store.dao.GoodDao;
import com.abc.store.domain.Goods;
import com.abc.store.util.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.List;

/**
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/23 - 13:07
 */
public class GoodDaoImpl implements GoodDao {

    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    /**
     * 查询商品数量
     * @return
     */
    @Override
    public int findGoodTotalCount() {
        String sql = "select count(*) from goods";

        return template.queryForObject(sql, Integer.class);
    }

    /**
     * 查询每页的数量
     * @param start 每页起始数
     * @param pageSize 每页显示的数量
     * @return
     */
    @Override
    public List<Goods> findGoodByPage(int start, int pageSize) {
        String sql = "select * from goods limit ? , ?";
        return template.query(sql, new BeanPropertyRowMapper<Goods>(Goods.class), start, pageSize);
    }

    /**
     * 添加商品信息
     *
     * @param goods
     */
    @Override
    public void addgoods(Goods goods) {

        String sql = "insert into goods(id,name,price,pic,cid) values(?,?,?,?,?)";
        template.update(sql, goods.getId(),
                goods.getName(),
                goods.getPrice(),
                goods.getPic(),
                goods.getCid()
        );

    }

    /**
     * 根据商品的名称、条件进行模糊查询
     * @param name  商品类别
     * @param goodone 起始价格区间
     * @param goodtwo 结束价格区间
     * @return
     */
    @Override
    public int findAllTotalCount(String name, int goodone, int goodtwo) {
//        String sql = "select * from goods where  name like '%冰箱%' and price BETWEEN 2000 and 6000";

        String sql = " select count(*) from goods where 1 = 1 ";
        StringBuilder sb = new StringBuilder(sql);
        List param = new ArrayList();//条件的集合

        if (name != null && name.length() > 0 && (goodone != 0 && goodtwo != 0)){
            sb.append(" and name like ?");
            param.add("%" + name + "%");
            sb.append(" and price between ? and ? ");
            param.add(goodone);
            param.add(goodtwo);
        }
        if (name != null && (goodone == 0 && goodtwo == 0)) {
            sb.append(" and name like ?");
            param.add("%" + name + "%");
        }

        if (name == null && (goodone != 0 && goodtwo != 0)) {
            sb.append(" and price between ? ");
            param.add(goodone);
            sb.append(" and ? ");
            param.add(goodtwo);
        }
        if (name == null && (goodone == 0 && goodtwo == 0)){

        }

        sql = sb.toString();

        return template.queryForObject(sql, Integer.class, param.toArray());
    }

    /**
     * 根据条件进行分页查询
     * @param start 起始数
     * @param pageSize  每页显示数量
     * @param name  商品的模糊名称
     * @param goodone   起始价格区间
     * @param goodtwo   结束价格区间
     * @return
     */
    @Override
    public List<Goods> findAllByPage(int start, int pageSize, String name, int goodone, int goodtwo) {
//        select count(*) from goods where  name like '%冰箱%' and price BETWEEN 1000 and 5000 LIMIT 0, 12

        String sql = "select * from goods where 1 = 1 ";
        StringBuilder sbs = new StringBuilder(sql);
        List params = new ArrayList();//条件的集合


        if (name != null && name.length() > 0 && (goodone != 0 && goodtwo != 0)){
            sbs.append(" and name like ? ");
            params.add("%" + name + "%");
            sbs.append(" and price between ? and ? ");
            params.add(goodone);
            params.add(goodtwo);
        }
        if (name != null && (goodone == 0 && goodtwo == 0)) {
            sbs.append(" and name like ?");
            params.add("%" + name + "%");
        }

        if (name == null && (goodone != 0 && goodtwo != 0)) {
            sbs.append(" and price between ?");
            params.add(goodone);
            sbs.append(" and ? ");
            params.add(goodtwo);
        }
        if (name == null && (goodone == 0 && goodtwo == 0)){

        }
        sbs.append(" limit ? , ? ");
        sql = sbs.toString();
        params.add(start);
        params.add(pageSize);

        return template.query(sql, new BeanPropertyRowMapper<Goods>(Goods.class), params.toArray());
    }

    /**
     * 根据商品的cid查询总数量
     * @param cid
     * @return
     */
    @Override
    public int findBycidTotalCount(int cid) {
        String sql = "select count(*) from goods where cid = ?";
        return template.queryForObject(sql, Integer.class, cid);
    }

    /**
     * 根据商品的cid进行分页查询
     * @param cid
     * @param start
     * @param pageSize
     * @return
     */
    @Override
    public List<Goods> findBycidPage(int cid, int start, int pageSize) {
        String sql = "select * from goods where cid = ? limit ? , ?";
        return template.query(sql, new BeanPropertyRowMapper<Goods>(Goods.class), cid, start, pageSize);
    }

    /**
     * 根据id查询商品的信息
     * @param id
     * @return
     */
    @Override
    public Goods findGoodById(String id) {

        Goods goods = null;

        String sql = "select * from goods where id = ?";
        goods = template.queryForObject(sql, new BeanPropertyRowMapper<Goods>(Goods.class), id);

        return goods;
    }

}
