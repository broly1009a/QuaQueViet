/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Home;

import dal.commentRatingDAO;
import dal.productDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.awt.Desktop;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Size;

public class Product_Search extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        // Auto-clear filter attributes after 15 seconds
        clearExpiredSessionAttribute(session, "selectedPrices_time", "selectedPrices");
        clearExpiredSessionAttribute(session, "selectedColors_time", "selectedColors");
        clearExpiredSessionAttribute(session, "selectedSize_time", "selectedSize");
        clearExpiredSessionAttribute(session, "selectedCategoryId_time", "selectedCategoryId");

        if (action == null || action.equalsIgnoreCase("product")) {
            session.removeAttribute("selectedPrices");
            session.removeAttribute("selectedColors");
            session.removeAttribute("selectedSize");
            session.removeAttribute("selectedCategoryId");
            session.removeAttribute("selectedPrices_time");
            session.removeAttribute("selectedColors_time");
            session.removeAttribute("selectedSize_time");
            session.removeAttribute("selectedCategoryId_time");

            productDAO dao = new productDAO();
            List<Category> category = dao.getCategory();
            List<model.Product> productList = dao.getProduct();
            request.setAttribute("SizeData", dao.getAllSizes());
            paginateAndForward(request, response, dao, productList, category);
            return;
        }

        if (action.equalsIgnoreCase("searchByPrice")) {
            productDAO dao = new productDAO();
            List<Category> category = dao.getCategory();
            String[] choose = request.getParameterValues("price");
            session.setAttribute("selectedPrices", choose);
            session.setAttribute("selectedPrices_time", System.currentTimeMillis());

            List<model.Product> list1 = dao.searchProductByPrice(0, 50000);
            List<model.Product> list2 = dao.searchProductByPrice(50000, 200000);
            List<model.Product> list3 = dao.searchProductByPrice(200000, 500000);
            List<model.Product> list4 = dao.searchProductByPrice(500000, 1000000);
            List<model.Product> list5 = dao.getProductByPrice(1000000);
            List<model.Product> list0 = dao.getProduct();
            List<model.Product> listc = new ArrayList<>();

            if (choose != null) {
                for (String val : choose) {
                    switch (val) {
                        case "0": listc.addAll(list1); break;
                        case "1": listc.addAll(list2); break;
                        case "2": listc.addAll(list3); break;
                        case "3": listc.addAll(list4); break;
                        case "4": listc.addAll(list5); break;
                    }
                }
            } else {
                listc.addAll(list0);
            }

            request.setAttribute("SizeData", dao.getAllSizes());
            paginateAndForward(request, response, dao, listc, category);
        }

        
         if (action.equalsIgnoreCase("SearchByColor")) {
            productDAO dao = new productDAO();
            List<Category> category = dao.getCategory();
            String[] choose = request.getParameterValues("colors");
            session.setAttribute("selectedColors", choose);
            session.setAttribute("selectedColors_time", System.currentTimeMillis());

            List<model.Product> listp = new ArrayList<>();
            if (choose == null || choose.length == 0 || choose.length == 4) {
                listp.addAll(dao.getProduct());
            } else {
                for (String color : choose) {
                    switch (color) {
                        case "0": listp.addAll(dao.getProductByColor("Đỏ")); break;
                        case "1": listp.addAll(dao.getProductByColor("Xanh")); break;
                        case "2": listp.addAll(dao.getProductByColor("Trắng")); break;
                        case "3": listp.addAll(dao.getProductByColor("Đen")); break;
                    }
                }
            }
            paginateAndForward(request, response, dao, listp, category);
        }

        if (action.equalsIgnoreCase("listByCategory")) {
            String category_id = request.getParameter("category_id");
            int category_id1 = Integer.parseInt(category_id);
            session.setAttribute("selectedCategoryId", category_id1);
            session.setAttribute("selectedCategoryId_time", System.currentTimeMillis());
            productDAO c = new productDAO();
            List<model.Product> productList = c.getProductByCategory(category_id1);
            List<Category> category = c.getCategory();
            paginateAndForward(request, response, c, productList, category);
        }

        // sort by low, high, a-z
        if (action.equals("sort")) {
            String type = request.getParameter("type");
            if (type.equals("low")) {
                productDAO c = new productDAO();
                List<model.Product> productList = c.getProductLow();
                List<Category> category = c.getCategory();
                int page, numperpage = 9;
                int size = productList.size();
                int num = (size % 9 == 0 ? (size / 9) : ((size / 9)) + 1);//so trang
                String xpage = request.getParameter("page");
                if (xpage == null) {
                    page = 1;
                } else {
                    page = Integer.parseInt(xpage);
                }
                int start, end;
                start = (page - 1) * numperpage;
                end = Math.min(page * numperpage, size);
                List<model.Product> product = c.getListByPage(productList, start, end);
                request.setAttribute("page", page);
                request.setAttribute("num", num);
                request.setAttribute("CategoryData", category);
                request.setAttribute("ProductData", product);
                request.getRequestDispatcher("shop_category.jsp").forward(request, response);
            }
            if (type.equals("high")) {
                productDAO c = new productDAO();
                List<model.Product> productList = c.getProductHigh();
                List<Category> category = c.getCategory();
                int page, numperpage = 9;
                int size = productList.size();
                int num = (size % 9 == 0 ? (size / 9) : ((size / 9)) + 1);//so trang
                String xpage = request.getParameter("page");
                if (xpage == null) {
                    page = 1;
                } else {
                    page = Integer.parseInt(xpage);
                }
                int start, end;
                start = (page - 1) * numperpage;
                end = Math.min(page * numperpage, size);
                List<model.Product> product = c.getListByPage(productList, start, end);
                request.setAttribute("page", page);
                request.setAttribute("num", num);
                request.setAttribute("CategoryData", category);
                request.setAttribute("ProductData", product);
                request.getRequestDispatcher("shop_category.jsp").forward(request, response);
            }
            if (type.equals("a-z")) {
                productDAO c = new productDAO();
                List<model.Product> productList = c.getProductAZ();
                List<Category> category = c.getCategory();
                int page, numperpage = 9;
                int size = productList.size();
                int num = (size % 9 == 0 ? (size / 9) : ((size / 9)) + 1);//so trang
                String xpage = request.getParameter("page");
                if (xpage == null) {
                    page = 1;
                } else {
                    page = Integer.parseInt(xpage);
                }
                int start, end;
                start = (page - 1) * numperpage;
                end = Math.min(page * numperpage, size);
                List<model.Product> product = c.getListByPage(productList, start, end);
                request.setAttribute("page", page);
                request.setAttribute("num", num);
                request.setAttribute("CategoryData", category);
                request.setAttribute("ProductData", product);
                request.getRequestDispatcher("shop_category.jsp").forward(request, response);
            }
        }

         if (action.equals("search")) {
            session.removeAttribute("selectedPrices");
            session.removeAttribute("selectedColors");
            session.removeAttribute("selectedSize");
            session.removeAttribute("selectedCategoryId");
            session.removeAttribute("selectedPrices_time");
            session.removeAttribute("selectedColors_time");
            session.removeAttribute("selectedSize_time");
            session.removeAttribute("selectedCategoryId_time");
            String text = request.getParameter("text");
            productDAO c = new productDAO();
            List<model.Product> productList = c.SearchAll(text);
            List<Category> category = c.getCategory();
            paginateAndForward(request, response, c, productList, category);
        }


        if (action.equalsIgnoreCase("searchproductbysize")) {
            String size = request.getParameter("size");
            if (size == null || size.trim().isEmpty()) {
                size = null;
            }
            session.setAttribute("selectedSize", size);

            productDAO dao = new productDAO();
            List<model.Product> productList = dao.getProductBySize(size);
            List<Size> sizes = dao.getAllSizes();

            paginateAndForwardSize(request, response, dao, productList, sizes);
        }
        
        if (action.equalsIgnoreCase("productdetail")) {
            String product_id = request.getParameter("product_id");
            productDAO c = new productDAO();
            List<model.Size> sizeList = c.getSizeByID(product_id);
            List<model.Color> colorList = c.getColorByID(product_id);
            model.Product product = c.getProductByID(product_id);
            int category_id = product.getCate().getCategory_id();
            List<model.Product> productByCategory = c.getProductByCategory(category_id);
            commentRatingDAO crDAO = new commentRatingDAO();
            List<model.Comment> comments = crDAO.getCommentsByProductId(product_id);
            double averageRating = crDAO.getAverageRatingForProduct(product_id);
            request.setAttribute("ProductData", product);
            request.setAttribute("SizeData", sizeList);
            request.setAttribute("ColorData", colorList);
            request.setAttribute("ProductByCategory", productByCategory);
            request.setAttribute("comments", comments);
            request.setAttribute("averageRating", averageRating);
            request.getRequestDispatcher("product-details.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("addComment")) {
            String productId = request.getParameter("product_id");
            String userId = request.getParameter("user_id");  // Retrieve userId from session
            String userName = request.getParameter("user_name");  // Retrieve userId from session
            int rating = Integer.parseInt(request.getParameter("rating"));
            String commentText = request.getParameter("comment");

            // Call DAO method to add rating
            commentRatingDAO dao = new commentRatingDAO();
            if (dao.hasUserCommented(productId, userId)) {
                session.setAttribute("errorMessage", "Bạn đã đánh giá và bình luận cho sản phẩm này rồi.");
            } else {
                dao.addComment(productId, userId, commentText, rating, userName);
                session.setAttribute("successMessage", "Hãy tiến hành mua sản phẩm để được đánh giá và bình luận");
            }
            response.sendRedirect("search?action=productdetail&product_id=" + productId);
        }
    }
    
    private void clearExpiredSessionAttribute(HttpSession session, String timeKey, String valueKey) {
        Long time = (Long) session.getAttribute(timeKey);
        if (time != null) {
            long now = System.currentTimeMillis();
            if (now - time > 15 * 1000) {
                session.removeAttribute(timeKey);
                session.removeAttribute(valueKey);
            }
        }
    }

    private void paginateAndForward(HttpServletRequest request, HttpServletResponse response,
                                     productDAO dao, List<model.Product> productList, List<Category> category)
            throws ServletException, IOException {
        int page, numperpage = 9;
        int size = productList.size();
        int num = (size % numperpage == 0 ? (size / numperpage) : ((size / numperpage)) + 1);
        String xpage = request.getParameter("page");
        page = (xpage == null) ? 1 : Integer.parseInt(xpage);
        int start = (page - 1) * numperpage;
        int end = Math.min(page * numperpage, size);
        List<model.Product> product = productList.subList(start, end);

        request.setAttribute("page", page);
        request.setAttribute("num", num);
        request.setAttribute("CategoryData", category);
        request.setAttribute("ProductData", product);
        request.setAttribute("SizeData", dao.getAllSizes());
        request.getRequestDispatcher("shop_category.jsp").forward(request, response);
    }

    private void paginateAndForwardSize(HttpServletRequest request, HttpServletResponse response,
                                        productDAO dao, List<model.Product> productList, List<Size> sizes)
            throws ServletException, IOException {
        int page, numperpage = 9;
        int size = productList.size();
        int num = (size % numperpage == 0 ? (size / numperpage) : ((size / numperpage)) + 1);
        String xpage = request.getParameter("page");
        page = (xpage == null) ? 1 : Integer.parseInt(xpage);
        int start = (page - 1) * numperpage;
        int end = Math.min(page * numperpage, size);
        List<model.Product> product = productList.subList(start, end);

        request.setAttribute("page", page);
        request.setAttribute("num", num);
        request.setAttribute("SizeData", sizes);
        request.setAttribute("ProductData", product);
        request.getRequestDispatcher("shop_category.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(Product_Search.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(Product_Search.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
