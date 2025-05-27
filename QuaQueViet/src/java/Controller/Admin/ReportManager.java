/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import dal.reportDAO;
import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Report;
import model.User;

@WebServlet(name = "reportManager", urlPatterns = {"/reportmanager"})
public class ReportManager extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String page = "404.jsp";

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            String action = request.getParameter("action");

            if (user.getIsAdmin().equalsIgnoreCase("true")) {
                if (action == null) {
                    // Load tất cả phản hồi
                    session.setAttribute("Reports", new reportDAO().getAll());
                    page = "admin/report.jsp";
                } else if ("delete".equalsIgnoreCase(action)) {
                    // Xóa phản hồi
                    int id = Integer.parseInt(request.getParameter("id_report"));
                    new reportDAO().deleteReport(id);
                    response.sendRedirect("reportmanager");
                    return;
                } else if ("reply".equalsIgnoreCase(action)) {
                    int reportId = Integer.parseInt(request.getParameter("id_report"));
                    String adminReply = request.getParameter("admin_reply");
                    new reportDAO().replyToReport(reportId, adminReply);

                    // Gửi thông báo và forward lại
                    session.setAttribute("Reports", new reportDAO().getAll()); // load lại
                    request.setAttribute("message", "Phản hồi đã được gửi thành công!");
                    page = "admin/report.jsp";
                }
            }
        } catch (Exception e) {
            page = "404.jsp";
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
