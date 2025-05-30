/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.List;

public class Product {
    Category cate;
    String product_id;
    String product_name;
    Float product_price;
    String product_describe;
    int quantity;
    String img;
    List<Size> size = new ArrayList<>();
    List<Color> color = new ArrayList<>();
    Product_Active active;

    public Product() {
    }

    public Product(Category cate, String product_id, String product_name, Float product_price, String product_describe, int quantity, String img) {
        this.cate = cate;
        this.product_id = product_id;
        this.product_name = product_name;
        this.product_price = product_price;
        this.product_describe = product_describe;
        this.quantity = quantity;
        this.img = img;
    }
    
    public Product(String product_id, String product_name, Float product_price, String product_describe, int quantity, String img) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.product_price = product_price;
        this.product_describe = product_describe;
        this.quantity = quantity;
        this.img = img;
    }
    
    public Product(String product_id, String product_name, String img) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.img = img;
    }

    public Category getCate() {
        return cate;
    }

    public void setCate(Category cate) {
        this.cate = cate;
    }

    public String getProduct_id() {
        return product_id;
    }

    public void setProduct_id(String product_id) {
        this.product_id = product_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public Float getProduct_price() {
        return product_price;
    }

    public void setProduct_price(Float product_price) {
        this.product_price = product_price;
    }

    public String getProduct_describe() {
        return product_describe;
    }

    public void setProduct_describe(String product_describe) {
        this.product_describe = product_describe;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public List<Size> getSize() {
        return size;
    }

    public void setSize(List<Size> size) {
        this.size = size;
    }

    public List<Color> getColor() {
        return color;
    }

    public void setColor(List<Color> color) {
        this.color = color;
    }
    public Product_Active getActive() {
        return active;
    }

    public void setActive(Product_Active active) {
        this.active = active;
    }



    @Override
    public String toString() {
        return "Product{" + "cate=" + cate + ", product_id=" + product_id + ", product_name=" + product_name + ", product_price=" + product_price + ", product_describe=" + product_describe + ", quantity=" + quantity + ", img=" + img + ", size=" + size + ", color=" + color + '}';
    }
}