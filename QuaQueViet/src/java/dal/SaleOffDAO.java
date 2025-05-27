package dal;

import model.SaleOff;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

import java.text.SimpleDateFormat;
import java.time.LocalDate;

public class SaleOffDAO extends DBContext {

    public List<SaleOff> getAllSaleOffs() {
        List<SaleOff> saleOffs = new ArrayList<>();
        String sql = "SELECT * FROM sale_off";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SaleOff saleOff = new SaleOff(
                        rs.getInt("sale_off_id"),
                        rs.getString("sale_off_code"),
                        rs.getString("discount_type"),
                        rs.getDouble("discount_value"),
                        rs.getDouble("max_discount"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getInt("quantity")
                );
                saleOffs.add(saleOff);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return saleOffs;
    }

    public boolean updateSaleOff(SaleOff saleOff) throws Exception {
        String sql = "UPDATE sale_off SET sale_off_code = ?, discount_type = ?, discount_value = ?, max_discount = ?, start_date = ?, end_date = ?, quantity = ? WHERE sale_off_id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            // Cài đặt các tham số trong câu lệnh SQL
            ps.setString(1, saleOff.getSaleCode());
            ps.setString(2, saleOff.getDiscountType());
            ps.setDouble(3, saleOff.getDiscountValue());
            ps.setDouble(4, saleOff.getMaxDiscount());
            ps.setDate(5, new Date(saleOff.getStart_date().getTime()));
            ps.setDate(6, new Date(saleOff.getEnd_date().getTime()));
            ps.setInt(7, saleOff.getQuantity());
            ps.setInt(8, saleOff.getSaleId());

            // Thực thi câu lệnh update
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một dòng bị ảnh hưởng
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public List<SaleOff> searchSaleOffs(String saleCode, String discountType, String sortDiscountValue) {
        List<SaleOff> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            StringBuilder sql = new StringBuilder("SELECT * FROM sale_off  WHERE 1=1");

            if (saleCode != null && !saleCode.trim().isEmpty()) {
                sql.append(" AND sale_off_code LIKE ?");
            }
            if (discountType != null && !discountType.trim().isEmpty()) {
                sql.append(" AND discount_type = ?");
            }
            if (sortDiscountValue != null && !sortDiscountValue.trim().isEmpty()) {
                sql.append(" ORDER BY discount_value ").append(sortDiscountValue.equalsIgnoreCase("asc") ? "ASC" : "DESC");
            }

            ps = conn.prepareStatement(sql.toString());

            int index = 1;
            if (saleCode != null && !saleCode.trim().isEmpty()) {
                ps.setString(index++, "%" + saleCode + "%");
            }
            if (discountType != null && !discountType.trim().isEmpty()) {
                ps.setString(index++, discountType);
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                SaleOff saleOff = new SaleOff();
                saleOff.setSaleId(rs.getInt("sale_off_id"));
                saleOff.setSaleCode(rs.getString("sale_off_code"));
                saleOff.setDiscountType(rs.getString("discount_type"));
                saleOff.setDiscountValue(rs.getDouble("discount_value"));
                saleOff.setStart_date(rs.getDate("start_date"));
                saleOff.setEnd_date(rs.getDate("end_date"));
                list.add(saleOff);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public SaleOff getValidSaleOff(String code, Date today) {
        String sql = "SELECT * FROM sale_off WHERE sale_off_code = ? AND start_date <= ? AND end_date >= ? AND quantity > 0";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setDate(2, today);
            ps.setDate(3, today);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new SaleOff(
                        rs.getInt("sale_off_id"),
                        rs.getString("sale_off_code"),
                        rs.getString("discount_type"),
                        rs.getDouble("discount_value"),
                        rs.getDouble("max_discount"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getInt("quantity")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void reduceQuantity(int id) {
        String sql = "UPDATE sale_off SET quantity = quantity - 1 WHERE sale_off_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean addSaleOff(SaleOff newSale) {
        String sql = "INSERT INTO sale_off (sale_off_code, discount_type, discount_value, max_discount, start_date, end_date, quantity) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newSale.getSaleCode());
            ps.setString(2, newSale.getDiscountType());
            ps.setDouble(3, newSale.getDiscountValue());
            ps.setDouble(4, newSale.getMaxDiscount());
            ps.setDate(5, new java.sql.Date(newSale.getStart_date().getTime()));
            ps.setDate(6, new java.sql.Date(newSale.getEnd_date().getTime()));
            ps.setInt(7, newSale.getQuantity());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteSaleOff(int saleId) {
        String sql = "DELETE FROM sale_off WHERE sale_off_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, saleId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isSaleCodeExists(String saleCode) {
        String sql = "SELECT 1 FROM sale_off WHERE sale_off_code = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, saleCode);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // nếu có dòng nào, tức là mã đã tồn tại
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isSaleCodeExistsForOther(int saleId, String saleCode) {
        String sql = "SELECT 1 FROM sale_off WHERE sale_off_code = ? AND sale_off_id != ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, saleCode);
            ps.setInt(2, saleId);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // nếu có dòng -> trùng mã với bản ghi khác
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<SaleOff> getValidSaleOffs(Date today) {
        List<SaleOff> validSales = new ArrayList<>();
        String sql = "SELECT * FROM sale_off WHERE start_date <= ? AND end_date >= ? AND quantity > 0";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, new java.sql.Date(today.getTime()));
            ps.setDate(2, new java.sql.Date(today.getTime()));

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SaleOff sale = new SaleOff(
                        rs.getInt("sale_off_id"),
                        rs.getString("sale_off_code"),
                        rs.getString("discount_type"),
                        rs.getDouble("discount_value"),
                        rs.getDouble("max_discount"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getInt("quantity")
                );
                validSales.add(sale);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return validSales;
    }

    public List<SaleOff> getAvailableCodes() {
        List<SaleOff> list = new ArrayList<>();
        String sql = "SELECT * FROM sale_off WHERE GETDATE() BETWEEN start_date AND end_date AND quantity > 0";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SaleOff s = new SaleOff();
                s.setSaleCode(rs.getString("sale_off_code"));
                s.setDiscountType(rs.getString("discount_type"));
                s.setDiscountValue(rs.getDouble("discount_value"));
                s.setMaxDiscount(rs.getDouble("max_discount"));
                s.setStart_date(rs.getDate("start_date"));
                s.setEnd_date(rs.getDate("end_date"));
                s.setQuantity(rs.getInt("quantity"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }

}
