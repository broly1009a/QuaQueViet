/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class categoryDAO extends DBContext {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Category> getCategory() {
        List<Category> list = new ArrayList<>();
        String sql = "select * from category";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1), rs.getString(2)));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public void insertCategory(String name) {
        String sql = " insert into Category (category_name) values(?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateCategory(int categoryId, String categoryName) {
        try {
            String sql = "UPDATE category SET category_name = ? WHERE category_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, categoryName);
            ps.setInt(2, categoryId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCategory(int categoryId) {
        try {
            String sql = "DELETE FROM category WHERE category_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Category> getCategoryCounts() throws Exception {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT c.category_id, c.category_name, COUNT(p.product_id) AS count "
                + "FROM category c LEFT JOIN product p ON c.category_id = p.category_id "
                + "GROUP BY c.category_id, c.category_name";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1), rs.getString(2), rs.getInt(3)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public boolean isCategoryNameExists(String name) {
        String query = "SELECT COUNT(*) FROM Category WHERE LOWER(category_name) = LOWER(?)";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, name.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

  

    public boolean isCategoryNameExistsForUpdate(String name, int id) {
        String sql = "SELECT 1 FROM category WHERE LOWER(category_name) = LOWER(?) AND category_id != ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // tồn tại tên nhưng khác ID hiện tại
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
