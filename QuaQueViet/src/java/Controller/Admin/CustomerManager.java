package Controller.Admin;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dal.UserDAO;
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
import model.User;

@WebServlet(urlPatterns = {"/customermanager"})
public class CustomerManager extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String page = "";
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user != null && "true".equalsIgnoreCase(user.getIsAdmin())) {
                String action = request.getParameter("action");
                UserDAO dao = new UserDAO();

                if (action == null) {
                    List<User> userList = dao.getUser();
                    request.setAttribute("user", userList);
                    page = "admin/customer.jsp";

                } else if (action.equals("update")) {
                    int id = Integer.parseInt(request.getParameter("user_id"));
                    if (user.getUser_id() == id) {
                        // Nếu là admin và cố gắng thay đổi quyền của chính mình, không cho phép
                        session.setAttribute("error_message", "Admin không thể thay đổi quyền của bản thân.");
                        response.sendRedirect("customermanager");  // Quay lại trang quản lý khách hàng
                        return;
                    }
                    dao.setAdmin(id,
                            request.getParameter("permission"),
                            request.getParameter("storeStaffPermission"),
                            request.getParameter("adminReason"));
                    response.sendRedirect("customermanager");
                    return;

                } else if (action.equals("delete")) {
                    dao.deleteUser(Integer.parseInt(request.getParameter("user_id")));
                    response.sendRedirect("customermanager");
                    return;

                } else if (action.equals("ban")) {
                    dao.banUser(Integer.parseInt(request.getParameter("user_id")));
                    response.sendRedirect("customermanager");
                    return;

                } else if (action.equals("unban")) {
                    dao.unbanUser(Integer.parseInt(request.getParameter("user_id")));
                    response.sendRedirect("customermanager");
                    return;
                }

            } else {
                response.sendRedirect("user?action=login");
                return;
            }

        } catch (Exception e) {
            page = "404.jsp";
        }

        RequestDispatcher dd = request.getRequestDispatcher(page);
        dd.forward(request, response);
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
