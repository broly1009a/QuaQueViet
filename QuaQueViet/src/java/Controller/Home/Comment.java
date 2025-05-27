package Controller.Home;

import dal.commentRatingDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "Comment", urlPatterns = {"/comment"})
public class Comment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String productId = request.getParameter("product_id");
        String userId = request.getParameter("user_id");
        String userName = request.getParameter("user_name");
        String commentText = request.getParameter("comment");
        int rating = Integer.parseInt(request.getParameter("rating"));

        // Lưu bình luận vào DB
        commentRatingDAO dao = new commentRatingDAO();
        try {
            dao.addComment(productId, userId, commentText, rating, userName);
            // Nếu thành công, gửi thông báo và giữ lại trang hiện tại
            request.setAttribute("message", "Gửi bình luận thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Đã xảy ra lỗi khi gửi bình luận. Vui lòng thử lại!");
        }

        // Tạo lại URL để giữ lại trang chi tiết sản phẩm
        String redirectUrl = "search?action=productdetail&product_id=" + productId;

        // Forward lại trang hiện tại với thông báo
        RequestDispatcher dispatcher = request.getRequestDispatcher(redirectUrl);
        dispatcher.forward(request, response);
    }
}
