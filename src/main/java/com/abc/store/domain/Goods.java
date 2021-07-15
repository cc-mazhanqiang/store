package com.abc.store.domain;

import java.util.Arrays;

/**
 * @className:
 * @author: sir
 * @description: TODO
 * @date: 2021/6/23 - 13:00
 */
public class Goods {

    private String id;
    private String name;
    private String price;
    private byte[] pic;//商品的图片
    private int cid;//商品种类的id

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public byte[] getPic() {
        return pic;
    }

    public void setPic(byte[] pic) {
        this.pic = pic;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    @Override
    public String toString() {
        return "Goods{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price='" + price + '\'' +
                ", pic=" + Arrays.toString(pic) +
                ", cid=" + cid +
                '}';
    }
}
