/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Color;
import model.Product;
import model.Product_Active;
import model.Size;


public class productDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Product> getProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "select c.category_name ,  p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img, p.category_id from  \n"
                + "product p inner join category c on p.category_id = c.category_id";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(8), rs.getString(1));
                list.add(new Product(c, rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getProductA() {
        List<Product> list = new ArrayList<>();
        String sql = "select c.category_name ,  p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img, p.category_id from  \n"
                + "product p inner join category c on p.category_id = c.category_id inner join product_active pa on pa.product_id = p.product_id Where pa.active='True'";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(8), rs.getString(1));
                list.add(new Product(c, rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;

    }

    public List<Product_Active> getActive() {
        List<Product_Active> list = new ArrayList<>();
        String sql = "select * from product_active";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product_Active(rs.getString(1), rs.getString(2)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
   public Product getProductByID(String product_id) {
        List<Product> list = new ArrayList<>();
        String sql = "select c.category_id, c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img from product p inner join category c on p.category_id = c.category_id WHERE p.product_id=?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, product_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(1), rs.getString(2));
                return (new Product(c, rs.getString(3), rs.getString(4), rs.getFloat(5), rs.getString(6), rs.getInt(7), rs.getString(8)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public List<Product> getProductHigh() {
        List<Product> list = new ArrayList<>();
        String sql = "select c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img from product p inner join category c on p.category_id = c.category_id ORDER BY p.product_price DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getString(1));
                list.add(new Product(c, rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getProductAZ() {
        List<Product> list = new ArrayList<>();
        String sql = "select c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img from product p inner join category c on p.category_id = c.category_id inner join product_active pa on pa.product_id = p.product_id Where pa.active ='True' ORDER BY p.product_name";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getString(1));
                list.add(new Product(c, rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getListByPage(List<Product> list,
            int start, int end) {
        ArrayList<Product> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

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
        }
        return list;
    }

    public List<Product> getTop10Product() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP 10 p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img FROM product p inner join product_active pa on pa.product_id = p.product_id Where pa.active ='True' ORDER BY NEWID()";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getString(1), rs.getString(2), rs.getFloat(3), rs.getString(4), rs.getInt(5), rs.getString(6)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getTrendProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP 5 p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img FROM product p inner join bill_detail bd on p.product_id = bd.product_id inner join product_active pa on pa.product_id = p.product_id Where pa.active ='True' \n"
                + "ORDER BY bd.quantity DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getString(1), rs.getString(2), rs.getFloat(3), rs.getString(4), rs.getInt(5), rs.getString(6)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getNewProducts(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP  p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img FROM product p inner join bill_detail bd on p.product_id = bd.product_id\n"
                + "ORDER BY bd.quantity";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getString(1));
                list.add(new Product(c, rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public int CountProduct() {
        int count = 0;
        String sql = "SELECT COUNT(*) as 'count'\n"
                + "  FROM product";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public int CountUser() {
        int count = 0;
        String sql = "SELECT COUNT(*) as 'count'\n"
                + "  FROM users where isAdmin = 'False' or isAdmin = 'FALSE' ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public int CountBill() {
        int count = 0;
        String sql = "SELECT COUNT(*) as 'count'\n"
                + "  FROM bill";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public int CountProductLow() {
        int count = 0;
        String sql = "SELECT COUNT(*) as 'count'\n"
                + "  FROM product where quantity < 50 ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public List<Product> getProductByPrice(int a) {
        List<Product> list = new ArrayList<>();
        String sql = "select c.category_name ,  p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img, p.category_id from  \n"
                + "product p inner join category c on p.category_id = c.category_id inner join product_active pa on pa.product_id = p.product_id Where pa.active ='True' And p.product_price >=" + a + " Order By p.product_price";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(8), rs.getString(1));
                list.add(new Product(c, rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    // search by price
    public List<Product> searchProductByPrice(double a, double b) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT c.category_name, p.product_id, p.product_name, p.product_price, p.product_describe, p.quantity, p.img, p.category_id "
                + "FROM product p INNER JOIN category c ON p.category_id = c.category_id inner join product_active pa on pa.product_id = p.product_id "
                + "WHERE pa.active='True' AND p.product_price >= ? AND p.product_price <= ? "
                + "ORDER BY p.product_price";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setDouble(1, a);
            ps.setDouble(2, b);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(8), rs.getString(1));
                list.add(new Product(c, rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (Exception e) {
            System.out.println(e);
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
                System.out.println(e);
            }
        }
        return list;
    }

    // search by color
    public List<Product> getProductByColor(String a) {
        List<Product> list = new ArrayList<>();
        String sql = "Select Distinct c.category_name ,  p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img, p.category_id, co.color\n"
                + "FROM category c \n"
                + "INNER JOIN product p ON p.category_id = c.category_id\n"
                + "INNER JOIN product_color co ON co.product_id = p.product_id\n"
                + " Inner join product_active pa on pa.product_id = p.product_id\n"
                + "WHERE pa.active ='True' and co.color = ?\n"
                + "ORDER BY p.product_id";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, a);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(8), rs.getString(1));
                list.add(new Product(c, rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (Exception e) {
            System.out.println(e);
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
                System.out.println(e);
            }
        }
        return list;
    }

    public List<Product> getProductLow() {
        List<Product> list = new ArrayList<>();
        String sql = "select c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img from product p inner join category c on p.category_id = c.category_id inner join product_active pa on pa.product_id = p.product_id Where pa.active ='True' ORDER BY p.product_price ASC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getString(1));
                list.add(new Product(c, rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> SearchAll(String text) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT DISTINCT c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img \n"
                + "FROM product p inner join category c on c.category_id = p.category_id inner join product_color ps on p.product_id = ps.product_id Inner Join Product_Active pa On pa.product_id =p.product_id\n"
                + "WHERE pa.active ='True' And product_name LIKE ? OR  product_price LIKE ? OR ps.color LIKE ? OR c.category_name LIKE ?";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + text + "%");
            ps.setString(2, "%" + text + "%");
            ps.setString(3, text);
            ps.setString(4, "_%" + text + "%_");
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getString(1));
                list.add(new Product(c, rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Product> getProductByCategory(int category_id) {
        List<Product> list = new ArrayList<>();
        String sql = "select c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img from product p inner join category c on p.category_id = c.category_id inner join product_active pa on pa.product_id = p.product_id Where pa.active ='True' And p.category_id=?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, category_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getString(1));
                list.add(new Product(c, rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Size> getSizeByID(String product_id) {
        List<Size> list = new ArrayList<>();
        String sql = "select * from product_size where product_id=?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, product_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Size(rs.getString(1), rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Color> getColorByID(String product_id) {
        List<Color> list = new ArrayList<>();
        String sql = "select * from product_color where product_id=?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, product_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Color(rs.getString(1), rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Product> getProductBySize(String sizeName) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT p.product_id, p.product_name, p.product_price, p.product_describe, p.quantity, p.img "
                + "FROM product p "
                + "JOIN product_size ps ON p.product_id = ps.product_id "
                + "WHERE ps.size = ?"; // Filter by size name

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, sizeName);  // Use size name to filter
            rs = ps.executeQuery();

            while (rs.next()) {
                String product_id = rs.getString("product_id");
                String product_name = rs.getString("product_name");
                Float product_price = rs.getFloat("product_price");
                String product_describe = rs.getString("product_describe");
                int quantity = rs.getInt("quantity");
                String img = rs.getString("img");

                Product product = new Product(product_id, product_name, product_price, product_describe, quantity, img);

                // Retrieve associated sizes for the product
                List<Size> sizes = getSizesByProductId(product_id);
                product.setSize(sizes);

                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }

    public List<Size> getSizesByProductId(String productId) {
        List<Size> sizes = new ArrayList<>();
        String sql = "SELECT size FROM product_size WHERE product_id = ?";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, productId);
            rs = ps.executeQuery();

            while (rs.next()) {
                String size = rs.getString("size");
                sizes.add(new Size(productId, size));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return sizes;
    }

    public List<Size> getAllSizes() {
    List<Size> sizeList = new ArrayList<>();
    String sql = "SELECT DISTINCT size FROM product_size";  // Get all unique sizes

    try {
        conn = new DBContext().getConnection();
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();

        while (rs.next()) {
            String sizeName = rs.getString("size").trim();  // Trim to remove leading/trailing whitespace

            // Only add non-empty sizes to the list
            if (!sizeName.isEmpty()) {  // Ignore empty or invalid sizes
                Size size = new Size();
                size.setSize(sizeName); // Set the size name
                sizeList.add(size);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return sizeList;
}

public void insertProduct(Product product) {
        String sql = "insert into product (product_id,category_id,product_name,product_price,product_describe,quantity,img) values(?,?,?,?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, product.getProduct_id());
            ps.setInt(2, product.getCate().getCategory_id());
            ps.setString(3, product.getProduct_name());
            ps.setFloat(4, product.getProduct_price());
            ps.setString(5, product.getProduct_describe());
            ps.setInt(6, product.getQuantity());
            ps.setString(7, product.getImg());
            ps.executeUpdate();
        } catch (Exception e) {
        }
        String sql1 = "INSERT INTO product_size (product_id,size) VALUES(?,?)";
        try {
            conn = new DBContext().getConnection();
            for (Size i : product.getSize()) {
                ps = conn.prepareStatement(sql1);
                ps.setString(1, i.getProduct_id());
                ps.setString(2, i.getSize());
                ps.executeUpdate();
            }
        } catch (Exception e) {
        }
        String sql2 = "INSERT INTO product_color (product_id,color) VALUES(?,?)";
        try {
            conn = new DBContext().getConnection();
            for (Color i : product.getColor()) {
                ps = conn.prepareStatement(sql2);
                ps.setString(1, i.getProduct_id());
                ps.setString(2, i.getColor());
                ps.executeUpdate();
            }
        } catch (Exception e) {

        }
        String sql3 = "INSERT INTO product_active (product_id,active) VALUES(?,?)";
        try {
            conn = new DBContext().getConnection();
            Product_Active i =product.getActive();
                ps = conn.prepareStatement(sql3);
                ps.setString(1, product.getProduct_id());
                ps.setString(2, i.getAcitve());
                ps.executeUpdate();
        }catch(Exception e){
        }
    }

    
public void ProductDelete(String product_id) {
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Kết nối cơ sở dữ liệu và bắt đầu giao dịch
        conn = new DBContext().getConnection();
        conn.setAutoCommit(false); // Tắt auto-commit để thực hiện giao dịch

        // Xóa dữ liệu từ bảng product_comment
        String sql1 = "DELETE FROM product_comment WHERE product_id=?";
        ps = conn.prepareStatement(sql1);
        ps.setString(1, product_id);
        ps.executeUpdate();

        // Xóa dữ liệu từ bảng product_color
        String sql3 = "DELETE FROM product_color WHERE product_id=?";
        ps = conn.prepareStatement(sql3);
        ps.setString(1, product_id);
        ps.executeUpdate();

        // Xóa dữ liệu từ bảng product_size
        String sql4 = "DELETE FROM product_size WHERE product_id=?";
        ps = conn.prepareStatement(sql4);
        ps.setString(1, product_id);
        ps.executeUpdate();

        // Xóa dữ liệu từ bảng cart
        String sql5 = "DELETE FROM cart WHERE product_id=?";
        ps = conn.prepareStatement(sql5);
        ps.setString(1, product_id);
        ps.executeUpdate();

        // Xóa dữ liệu từ bảng product_active
        String sql6 = "DELETE FROM product_active WHERE product_id=?";
        ps = conn.prepareStatement(sql6);
        ps.setString(1, product_id);
        ps.executeUpdate();

        // Xóa dữ liệu từ bảng bill_detail
        String sql7 = "DELETE FROM bill_detail WHERE product_id=?";
        ps = conn.prepareStatement(sql7);
        ps.setString(1, product_id);
        ps.executeUpdate();

        // Xóa dữ liệu từ bảng product
        String sql8 = "DELETE FROM product WHERE product_id=?";
        ps = conn.prepareStatement(sql8);
        ps.setString(1, product_id);
        ps.executeUpdate();

        // Commit giao dịch sau khi tất cả các câu lệnh SQL đã thành công
        conn.commit();
    } catch (Exception e) {
        // Nếu có lỗi, rollback tất cả các thay đổi
        try {
            if (conn != null) {
                conn.rollback();
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        System.out.println("Lỗi xóa sản phẩm: " + e.getMessage());
    } finally {
        // Đóng kết nối và chuẩn bị giải phóng tài nguyên
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            System.out.println("Lỗi đóng kết nối: " + e.getMessage());
        }
    }
}


    public void updateProduct(Product product, int cid, List<Color> listColor, List<Size> listSize) {
        try {
            // Update product details
            String sql = "UPDATE product SET category_id=?, product_name=?, product_price=?, product_describe=?, quantity=?" + (!product.getImg().equalsIgnoreCase("images/") ? ", img=?" : "") + " WHERE product_id=?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cid);
            ps.setString(2, product.getProduct_name());
            ps.setFloat(3, product.getProduct_price());
            ps.setString(4, product.getProduct_describe());
            ps.setInt(5, product.getQuantity());
            if (!product.getImg().isEmpty()) {
                ps.setString(6, product.getImg());
            }
            ps.setString(!product.getImg().equalsIgnoreCase("images/") ? 7 : 6, product.getProduct_id());
            ps.executeUpdate();

            // Delete existing sizes and colors and actives
            String deleteSizesSQL = "DELETE FROM product_size WHERE product_id=?";
            ps = conn.prepareStatement(deleteSizesSQL);
            ps.setString(1, product.getProduct_id());
            ps.executeUpdate();

            String deleteColorsSQL = "DELETE FROM product_color WHERE product_id=?";
            ps = conn.prepareStatement(deleteColorsSQL);
            ps.setString(1, product.getProduct_id());
            ps.executeUpdate();
             String deleteActiveSQL = "DELETE FROM product_active WHERE product_id=?";
            ps = conn.prepareStatement(deleteActiveSQL);
            ps.setString(1, product.getProduct_id());
            ps.executeUpdate();
            // Insert new sizes
            String insertSizeSQL = "INSERT INTO product_size (product_id, size) VALUES (?, ?)";
            for (Size size : listSize) {
                ps = conn.prepareStatement(insertSizeSQL);
                ps.setString(1, product.getProduct_id());
                ps.setString(2, size.getSize());
                ps.executeUpdate();
            }
            //Insert new Active
                String insertActiveSQL = "INSERT INTO product_active (product_id, active) VALUES (?, ?)";
                ps = conn.prepareStatement(insertActiveSQL);
                ps.setString(1, product.getProduct_id());
                ps.setString(2, product.getActive().getAcitve());
                ps.executeUpdate();
            

            // Insert new colors
            String insertColorSQL = "INSERT INTO product_color (product_id, color) VALUES (?, ?)";
            for (Color color : listColor) {
                ps = conn.prepareStatement(insertColorSQL);
                ps.setString(1, product.getProduct_id());
                ps.setString(2, color.getColor());
                ps.executeUpdate();
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
   
    public List<Size> getSize() {
        List<Size> list = new ArrayList<>();
        String sql = "select * from product_size";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Size(rs.getString(1), rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Color> getColor() {
        List<Color> list = new ArrayList<>();
        String sql = "select * from product_color";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Color(rs.getString(1), rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list;
    }


    public Category getCategoryByName(String name) {
        String sql = "select * from Category where category_name = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Category(rs.getInt(1), rs.getString(2));
            }
        } catch (Exception e) {
        }
        return null;
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
    public static void main(String[] args) {
        // Tạo đối tượng của DAO
        productDAO dao = new productDAO();

        // Gọi phương thức CountUser để lấy số lượng người dùng
        int countUser = dao.CountUser();

        // In kết quả ra console
        System.out.println("Tổng số người dùng: " + countUser);
    }
}
