package dal;

import model.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class commentRatingDAO extends DBContext {

    // Khai báo các đối tượng kết nối
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Thêm bình luận từ người dùng
    public void addComment(String productId, String userId, String comment, int rating, String user_name) throws Exception {
        String sql = "INSERT INTO product_comment (product_id, user_id, comment, rating, created_at, user_name) "
                + "VALUES (?, ?, ?, ?, GETDATE(), ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, productId);
            ps.setString(2, userId);
            ps.setString(3, comment);
            ps.setInt(4, rating);
            ps.setString(5, user_name);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
    }

    public void updateAdminReply(int commentId, String adminReply) throws Exception {
        String sql = "UPDATE product_comment SET admin_reply = ? WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, adminReply);
            ps.setInt(2, commentId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeConnection();
        }
    }

    // Thêm phản hồi từ admin vào bình luận
    public void addAdminReply(int commentId, String adminReply) {
        String sql = "UPDATE product_comment SET admin_reply = ? WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, adminReply);
            ps.setInt(2, commentId);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    // Lấy danh sách bình luận theo productId
    public List<Comment> getCommentsByProductId(String productId) throws Exception {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT * FROM product_comment WHERE product_id = ? ORDER BY created_at DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, productId);
            rs = ps.executeQuery();
            while (rs.next()) {
                comments.add(new Comment(
                        rs.getInt("id"),
                        rs.getString("product_id"),
                        rs.getInt("user_id"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("rating"),
                        rs.getString("user_name"),
                        rs.getString("admin_reply")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return comments;
    }

    // Lấy tất cả bình luận
    public List<Comment> getComment() throws Exception {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT * from product_comment";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                comments.add(new Comment(
                        rs.getInt("id"),
                        rs.getString("product_id"),
                        rs.getInt("user_id"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("rating"),
                        rs.getString("user_name"),
                        rs.getString("admin_reply")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return comments;
    }

    // Xóa bình luận theo ID
    public void deleteComment(int commentId) throws Exception {
        String sql = "DELETE FROM product_comment WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, commentId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
    }

    // Lấy đánh giá trung bình của sản phẩm theo productId
    public double getAverageRatingForProduct(String productId) throws Exception {
        String sql = "SELECT ROUND(CAST(SUM(rating) AS FLOAT) / CAST(COUNT(rating) AS FLOAT), 1) AS avg_rating "
                + "FROM product_comment "
                + "WHERE product_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("avg_rating");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return 0;
    }

    // Kiểm tra xem người dùng đã bình luận sản phẩm chưa
    public boolean hasUserCommented(String productId, String userId) throws Exception {
        String sql = "SELECT COUNT(*) FROM product_comment WHERE product_id = ? AND user_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, productId);
            ps.setString(2, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return false;
    }

    // Đóng kết nối sau khi sử dụng
    private void closeConnection() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy danh sách bình luận theo đánh giá rating
    public List<Comment> getCommentsByRating(int rating) throws Exception {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT * FROM product_comment WHERE rating = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, rating);
            rs = ps.executeQuery();
            while (rs.next()) {
                comments.add(new Comment(
                        rs.getInt("id"),
                        rs.getString("product_id"),
                        rs.getInt("user_id"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("rating"),
                        rs.getString("user_name"),
                        rs.getString("admin_reply")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return comments;
    }
}
