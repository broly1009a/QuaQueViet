/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public boolean updatePassword(User user) throws Exception {
        String sql = "UPDATE users set user_pass = ? where user_email = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUser_pass()); // Mật khẩu mới
            ps.setString(2, user.getUser_email());// ID người dùng

            int result = ps.executeUpdate();
            return result > 0; // Nếu có dòng bị ảnh hưởng, trả về true
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public List<User> getUser() {
        List<User> list = new ArrayList<>();
        String sql = "select *, CAST(banned AS BIT) AS banned FROM users";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean("banned"), rs.getString(10), rs.getString(11)));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public void setAdmin(int user_id, String isAdmin, String isStoreStaff, String adminReason) {
        String sql = "UPDATE users SET isAdmin = ?, isStoreStaff = ?, adminReason = ? WHERE user_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, isAdmin.toUpperCase());
            ps.setString(2, isStoreStaff.toUpperCase());
            ps.setString(3, adminReason);
            ps.setInt(4, user_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    public User checkUser(String user_email, String user_pass) {
        try {
            String query = "select * from users where user_email = ? and user_pass = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user_email);
            ps.setString(2, user_pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(9), rs.getString(10), rs.getString(11));
                return user;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean updateUser(int user_id, String user_name, String user_email, String dateOfBirth, String address, String phoneNumber) throws Exception {
        String sql = "UPDATE users SET user_name = ?, user_email = ?, dateOfBirth = ?, address = ?, phoneNumber = ? WHERE user_id = ?";
        boolean updateSuccess = false;

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user_name);
            ps.setString(2, user_email);
            ps.setString(3, dateOfBirth);
            ps.setString(4, address);
            ps.setString(5, phoneNumber);
            ps.setInt(6, user_id);

            int rowsUpdated = ps.executeUpdate();
            updateSuccess = (rowsUpdated > 0);
        } catch (SQLException e) {
            e.printStackTrace(); // Log the error (optional)
        }
        return updateSuccess;
    }

    public User checkAcc(String user_email) {
        try {
            String query = "select * from users where user_email = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user_email);
            rs = ps.executeQuery();
            while (rs.next()) {
                User a = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(9), rs.getString(10), rs.getString(11));
                return a;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void deleteUser(int user_id) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void banUser(int user_id) {
        String sql = "UPDATE users SET banned = 1 WHERE user_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void unbanUser(int user_id) {
        String sql = "UPDATE users SET banned = 0 WHERE user_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void signup(String user_email, String user_pass) {
        try {
            String query = "insert into users values(?,?,?,?,?,?,?,?,?,?)";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "");
            ps.setString(2, user_email);
            ps.setString(3, user_pass);
            ps.setString(4, "False");
            ps.setString(5, "");
            ps.setString(6, "");
            ps.setString(7, "");
            ps.setString(8, "");
            ps.setString(9, "");
            ps.setString(10, "False");
            ps.executeUpdate();
        } catch (Exception e) {
        };
    }

    public void change(User a) {
        String sql = "UPDATE users SET user_pass = ? WHERE user_id= ?";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, a.getUser_pass());
            ps.setInt(2, a.getUser_id());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
