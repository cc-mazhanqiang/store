package com.abc.store.domain;

/**
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/18 - 21:39
 */
public class Category_son {

    private int cid;//导航栏子菜单分类的id
    private String cname;//导航栏子菜单分类的名字

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    @Override
    public String toString() {
        return "Category_son{" +
                "cid=" + cid +
                ", cname='" + cname + '\'' +
                '}';
    }
}
