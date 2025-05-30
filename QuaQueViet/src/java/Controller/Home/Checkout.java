package Controller.Home;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.billDAO;
import model.Cart;
import model.User;
import java.io.IOException;
import VnPayCommon.Config;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.TimeZone;
import model.BillRubish;

public class Checkout extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Đảm bảo múi giờ VN cho mọi thao tác thời gian (fix lỗi timeout VNPAY)
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        try {
            HttpSession session = request.getSession(true);
            Cart cart = null;
            String payment = null;
            billDAO dao = new billDAO();

            // Lấy cart
            Object o = session.getAttribute("cart");
            if (o != null) {
                cart = (Cart) o;
            } else {
                cart = new Cart();
            }

            // Kiểm tra user
            Object u = session.getAttribute("user");
            if (cart == null || cart.getItems().isEmpty()) {
                response.sendRedirect("home");
                return;
            }
            if (u == null) {
                response.sendRedirect("user?action=login");
                return;
            }

            // Lấy và trim đầu/cuối cho địa chỉ
            String address = request.getParameter("address");
            address = (address != null ? address.trim() : "");
            String phone = request.getParameter("phone");
            phone = (phone != null ? phone.trim().replaceAll("\\s+", "") : "");
            String payment_method = request.getParameter("payment_method");

            // Validate địa chỉ
            if (address.isEmpty()) {
                session.setAttribute("error_address", "Địa chỉ không được để trống");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }

            // Validate số điện thoại: chỉ chữ số, bắt đầu bằng 0 và phải là 10 chữ số
            if (phone == null || !phone.matches("0\\d{9}")) {
                session.setAttribute("error_phone", "Số điện thoại phải bắt đầu bằng '0' và gồm 10 chữ số");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }

            // Validate phương thức thanh toán
            if (payment_method == null || payment_method.trim().isEmpty()) {
                session.setAttribute("error_payment", "Vui lòng chọn phương thức thanh toán");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }

            // Xác định phương thức thanh toán
            if ("momo".equals(payment_method)) {
                payment = "MOMO";
            } else if ("vnpay".equals(payment_method)) {
                payment = "VNPAY";
            } else if ("cod".equals(payment_method)) {
                payment = "COD";
            }

            int phonenumber = Integer.parseInt(phone);
            User acc = (User) u;

            // Tạo đối tượng BillRubish để lưu tạm
            BillRubish bill = createBillRubish(acc, cart, payment, address, phone);

            if ("cod".equals(payment_method)) {
                Double finalTotal = (Double) session.getAttribute("finalTotal");
                double totalPrice = (finalTotal != null) ? finalTotal : cart.getTotalMoney();

                dao.addOrder(acc, cart, payment, address, phonenumber, totalPrice);
                session.removeAttribute("cart");
                session.setAttribute("size", 0);
                session.setAttribute("orderSuccessMessage", "Đơn hàng của bạn đã được đặt thành công!");
                response.sendRedirect("home");
                return;
            }

            if ("vnpay".equals(payment_method)) {
                // Lấy finalTotal từ session nếu có mã giảm giá
                Double finalTotal = (Double) session.getAttribute("finalTotal");
                double totalPrice = (finalTotal != null) ? finalTotal : bill.getCart().getTotalMoney();

                int total = (int) Math.round(totalPrice);

                session.setAttribute("pendingBill", bill);
                request.setAttribute("total", total);
                request.setAttribute("bill", bill);
                request.setAttribute("billId", dao.GetLastId() + 1);
                request.getRequestDispatcher("VN_Pay/vnpay_pay.jsp").forward(request, response);
                return;
            }

        } catch (Exception e) {
            request.getRequestDispatcher("404.jsp").forward(request, response);
        }
    }

    private BillRubish createBillRubish(User u, Cart c, String pay, String add, String phone) {
        BillRubish billRubish = new BillRubish();
        billRubish.setUser(u);
        billRubish.setCart(c);
        billRubish.setPayment(pay);
        billRubish.setAddress(add);
        billRubish.setPhone(phone);
        return billRubish;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        if (session.getAttribute("user") != null) {
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        } else {
            response.sendRedirect("user?action=login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}