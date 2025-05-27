/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import dal.categoryDAO;
import dal.productDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Category;
import model.User;

@WebServlet(name = "CategoryManager", urlPatterns = {"/categorymanager"})
public class CategoryManager extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response hehehe
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String page = "admin/category.jsp";
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null || (!user.getIsAdmin().equalsIgnoreCase("true") && !user.getIsStoreStaff().equalsIgnoreCase("true"))) {
                response.sendRedirect("user?action=login");
                return;
            }

            String action = request.getParameter("action");
            categoryDAO cdao = new categoryDAO();

            if (action == null) {
                List<Category> category = cdao.getCategory();
                request.setAttribute("category", category);

            } else if (action.equalsIgnoreCase("insertcategory")) {
                String name = request.getParameter("name");
                name = (name != null) ? name.trim() : "";

                if (name.isEmpty()) {
                    request.setAttribute("error", "Tên danh mục không được để trống.");
                    request.setAttribute("showAddModal", true);
                } else if (cdao.isCategoryNameExists(name)) {
                    request.setAttribute("error", "Tên danh mục đã tồn tại.");
                    request.setAttribute("showAddModal", true);
                } else {
                    cdao.insertCategory(name);
                    response.sendRedirect("categorymanager");
                    return;
                }
                request.setAttribute("category", cdao.getCategory());

            } else if (action.equalsIgnoreCase("updatecategory")) {
                String category_id = request.getParameter("category_id");
                String category_name = request.getParameter("category_name");
                category_name = (category_name != null) ? category_name.trim() : "";
                category_id = (category_id != null) ? category_id.trim() : "";

                if (category_id.isEmpty() || category_name.isEmpty()) {
                    request.setAttribute("error", "ID và Tên danh mục không được để trống.");
                    request.setAttribute("inputCategoryName", category_name);
                    request.setAttribute("openEditModalId", category_id);
                } else {
                    try {
                        int id = Integer.parseInt(category_id);
                        List<Category> all = cdao.getCategory();
                        boolean isDuplicate = false;
                        for (Category cat : all) {
                            if (cat.getCategory_name().equalsIgnoreCase(category_name) && cat.getCategory_id() != id) {
                                isDuplicate = true;
                                break;
                            }
                        }
                        if (isDuplicate) {
                            request.setAttribute("error", "Tên danh mục đã tồn tại.");
                            request.setAttribute("inputCategoryName", category_name);
                            request.setAttribute("openEditModalId", category_id);
                        } else {
                            cdao.updateCategory(id, category_name);
                            response.sendRedirect("categorymanager");
                            return;
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "ID danh mục không hợp lệ.");
                        request.setAttribute("inputCategoryName", category_name);
                        request.setAttribute("openEditModalId", category_id);
                    } catch (Exception e) {
                        request.setAttribute("inputCategoryName", category_name);
                        request.setAttribute("error", "Có lỗi xảy ra khi cập nhật danh mục.");
                        request.setAttribute("openEditModalId", category_id);
                    }
                }
                request.setAttribute("category", cdao.getCategory());

            } else if (action.equalsIgnoreCase("delete")) {
                String category_id = request.getParameter("category_id");
                int id = Integer.parseInt(category_id);
                cdao.deleteCategory(id);
                response.sendRedirect("categorymanager");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            page = "404.jsp";
        }
        RequestDispatcher dd = request.getRequestDispatcher(page);
        dd.forward(request, response);

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
        processRequest(request, response);
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
        processRequest(request, response);
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
