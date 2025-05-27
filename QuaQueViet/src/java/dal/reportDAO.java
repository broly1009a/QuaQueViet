/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Report;

public class reportDAO extends DBContext {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public void InsertReport(String user_id, String content_report, String subject_report, String user_email) {
        try {
            String sql = "INSERT INTO [dbo].[report] ([user_id], [content_report], [subject_report], [user_email]) VALUES (?, ?, ?, ?)";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user_id);
            ps.setString(2, content_report);
            ps.setString(3, subject_report);
            ps.setString(4, user_email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void replyToReport(int reportId, String replyContent) {
        String sql = "UPDATE report SET admin_reply = ? WHERE id_report = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            // Set dữ liệu vào PreparedStatement
            ps.setString(1, replyContent);
            ps.setInt(2, reportId);

            // Thực thi câu lệnh SQL
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Reply updated successfully!");
            } else {
                System.out.println("No rows updated. Check if report ID is correct.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Phương thức lấy tất cả phản hồi
    public List<Report> getAll() {
        List<Report> list = new ArrayList<>();
        String sql = "SELECT r.id_report, r.user_id, r.content_report, r.subject_report, u.user_email, r.admin_reply "
                + "FROM report r "
                + "INNER JOIN users u ON u.user_id = r.user_id";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Report(rs.getInt("id_report"),
                        rs.getInt("user_id"),
                        rs.getString("content_report"),
                        rs.getString("subject_report"),
                        rs.getString("user_email"),
                        rs.getString("admin_reply")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Report> getReportsByUserId(int userId) {
        List<Report> list = new ArrayList<>();
        String sql = "SELECT r.id_report, r.user_id, r.content_report, r.subject_report, u.user_email, r.admin_reply "
                + "FROM report r "
                + "INNER JOIN users u ON u.user_id = r.user_id "
                + "WHERE r.user_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Report(
                        rs.getInt("id_report"),
                        rs.getInt("user_id"),
                        rs.getString("content_report"),
                        rs.getString("subject_report"),
                        rs.getString("user_email"),
                        rs.getString("admin_reply")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Phương thức xóa phản hồi
    public void deleteReport(int reportId) {
        try {
            String sql = "DELETE FROM report WHERE id_report = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, reportId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
