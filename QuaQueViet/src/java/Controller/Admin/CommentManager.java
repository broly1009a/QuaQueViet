package Controller.Admin;

import dal.commentRatingDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Comment;
import model.User;

@WebServlet(name = "CommentManager", urlPatterns = {"/commentmanager"})
public class CommentManager extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String page = "";
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            String action = request.getParameter("action");
            String ratingFilter = request.getParameter("ratingFilter");

            if (user != null && user.getIsAdmin().equalsIgnoreCase("true")) {
                if (action == null) {
                    commentRatingDAO dao = new commentRatingDAO();
                    List<Comment> comments;
                    if (ratingFilter != null && !ratingFilter.isEmpty()) {
                        int rating = Integer.parseInt(ratingFilter);
                        comments = dao.getCommentsByRating(rating);
                    } else {
                        comments = dao.getComment();
                    }
                    request.setAttribute("comment", comments);
                    page = "admin/comment.jsp";
                } else if (action.equals("delete")) {
                    String comment_id = request.getParameter("comment_id");
                    if (comment_id != null) {
                        try {
                            int id = Integer.parseInt(comment_id);
                            commentRatingDAO dao = new commentRatingDAO();
                            dao.deleteComment(id);
                            response.sendRedirect("commentmanager");
                            return;
                        } catch (NumberFormatException e) {
                            e.printStackTrace();
                            response.sendRedirect("error.jsp");
                        }
                    }
                } else if (action.equals("reply")) {
                    String comment_id = request.getParameter("comment_id");
                    String admin_reply = request.getParameter("admin_reply");

                    if (comment_id != null && admin_reply != null) {
                        try {
                            int id = Integer.parseInt(comment_id);
                            commentRatingDAO dao = new commentRatingDAO();
                            dao.updateAdminReply(id, admin_reply);  // Thêm phương thức để xử lý cập nhật
                            
                            // Thiết lập thông báo thành công vào session
                            session.setAttribute("replySuccess", "Phản hồi đã được gửi thành công!");
                            response.sendRedirect("commentmanager");
                            return;
                        } catch (NumberFormatException e) {
                            e.printStackTrace();
                            response.sendRedirect("error.jsp");
                        }
                    }
                }
            } else {
                response.sendRedirect("user?action=login");
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

    @Override
    public String getServletInfo() {
        return "Quản lý bình luận";
    }
}
