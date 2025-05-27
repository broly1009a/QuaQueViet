/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;



import java.util.Date;

public class SaleOff {
    private int saleId;
    private String saleCode;
    private String discountType;
    private double discountValue;
    private double maxDiscount;
    private Date start_date;
    private Date end_date;
    private int quantity;

    public SaleOff() {
    }

    public SaleOff(String saleCode, String discountType, double discountValue, double maxDiscount, Date start_date, Date end_date, int quantity) {
        this.saleCode = saleCode;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.maxDiscount = maxDiscount;
        this.start_date = start_date;
        this.end_date = end_date;
        this.quantity = quantity;
    }
    
    
    public SaleOff(int saleId, String saleCode, String discountType, double discountValue, double maxDiscount, Date start_date, Date end_date, int quantity) {
        this.saleId = saleId;
        this.saleCode = saleCode;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.maxDiscount = maxDiscount;
        this.start_date = start_date;
        this.end_date = end_date;
        this.quantity = quantity;
    }

    public int getSaleId() {
        return saleId;
    }

    public void setSaleId(int saleId) {
        this.saleId = saleId;
    }

    public String getSaleCode() {
        return saleCode;
    }

    public void setSaleCode(String saleCode) {
        this.saleCode = saleCode;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public double getMaxDiscount() {
        return maxDiscount;
    }

    public void setMaxDiscount(double maxDiscount) {
        this.maxDiscount = maxDiscount;
    }

    public Date getStart_date() {
        return start_date;
    }

    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }

    public Date getEnd_date() {
        return end_date;
    }

    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
            
}
