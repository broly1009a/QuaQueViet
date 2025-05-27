package Controller.Home;

import dal.reportDAO;
import model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.BillDetail;
import dal.billDAO;
import model.Bill;

@WebServlet(name = "Report", urlPatterns = {"/report"})
public class Report extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        reportDAO dao = new reportDAO();

        // Nếu action=viewReport thì chỉ lấy report
        if ("viewReport".equalsIgnoreCase(action)) {
            // Chỉ lấy report của user
            List<model.Report> reports = dao.getReportsByUserId(user.getUser_id());
            request.setAttribute("reports", reports);

            // Load thêm danh sách bill detail
            List<BillDetail> details = getBillDetails(user);
            request.setAttribute("detail", details);

            RequestDispatcher dispatcher = request.getRequestDispatcher("billdetail.jsp");
            dispatcher.forward(request, response);
            return; // Dừng lại không xử lý dưới nữa
        }

        // Nếu không phải viewReport thì xử lý bình thường (gửi phản hồi)
        String subjectReport = request.getParameter("subject_report");
        String contentReport = request.getParameter("content_report");

        if (subjectReport != null && contentReport != null && !subjectReport.isEmpty() && !contentReport.isEmpty()) {
            try {
                dao.InsertReport(String.valueOf(user.getUser_id()), contentReport, subjectReport, user.getUser_email());
                request.setAttribute("msgc", "Phản hồi của bạn đã được gửi thành công!");
            } catch (Exception e) {
                request.setAttribute("msgc", "Đã xảy ra lỗi khi gửi phản hồi. Vui lòng thử lại!");
                e.printStackTrace();
            }
        } 

        // Load lại dữ liệu sau khi gửi
        List<BillDetail> details = getBillDetails(user);
        request.setAttribute("detail", details);

        List<model.Report> reports = dao.getReportsByUserId(user.getUser_id());
        request.setAttribute("reports", reports);

        RequestDispatcher dispatcher = request.getRequestDispatcher("billdetail.jsp");
        dispatcher.forward(request, response);
    }

    private List<BillDetail> getBillDetails(User user) {
        List<BillDetail> details = new ArrayList<>();
        try {
            billDAO billDao = new billDAO();
            List<Bill> bills = billDao.getBillByID(user.getUser_id());

            if (bills != null && !bills.isEmpty()) {
                Bill lastBill = bills.get(bills.size() - 1);
                details = billDao.getDetail(lastBill.getBill_id());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return details;
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
