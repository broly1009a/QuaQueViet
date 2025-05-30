package Controller.Home;

import dal.SaleOffDAO;
import dal.billDAO;
import dal.UserDAO;
import model.BillDetail;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class User extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        if (action.equals("login")) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else if (action.equals("checkLogin")) {
            String user_email = request.getParameter("user_email");
            String user_pass = request.getParameter("user_pass");
            String remember = request.getParameter("remember");
            UserDAO dao = new UserDAO();
            model.User user = dao.checkUser(user_email, user_pass);
            if (user == null) {
                HttpSession session = request.getSession();
                session.setAttribute("error_exist", "Tài khoản không tồn tại !");
                request.getRequestDispatcher("user?action=login").forward(request, response);
            } else if (user.isBanned()) {
                HttpSession session = request.getSession();
                session.setAttribute("error_ban", "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ quản trị viên.");
                request.getRequestDispatcher("user?action=login").forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("loginMessage", "Đăng nhập thành công!");
                Cookie email = new Cookie("email", user_email);
                Cookie pass = new Cookie("pass", user_pass);
                Cookie rem = new Cookie("remember", remember);
                if (remember != null) {
                    email.setMaxAge(60 * 60 * 24 * 30);
                    pass.setMaxAge(60 * 60 * 24 * 30);
                    rem.setMaxAge(60 * 60 * 24 * 30);
                } else {
                    email.setMaxAge(0);
                    pass.setMaxAge(0);
                    rem.setMaxAge(0);
                }
                response.addCookie(email);
                response.addCookie(pass);
                response.addCookie(rem);
                response.sendRedirect("home");
            }
        } else if (action.equals("logout")) {
            HttpSession session = request.getSession();
            session.removeAttribute("user");
            session.setAttribute("logoutMessage", "Đăng xuất thành công!");
            response.sendRedirect("home");
        } else if (action.equals("myaccount")) {
            try {
                HttpSession session = request.getSession();
                model.User user = (model.User) session.getAttribute("user");
                if (user != null) {
                    String tab = request.getParameter("tab");

                    // Nếu là tab Mã Giảm Giá
                    if ("discounts".equals(tab)) {
                        SaleOffDAO sdao = new SaleOffDAO();
                        // hoặc getAllAvailableSales() nếu bạn đặt tên khác

                        List<model.SaleOff> discounts = sdao.getAvailableCodes();
                        request.setAttribute("availableCodes", discounts);
                        request.getRequestDispatcher("my-account.jsp").forward(request, response);
                        return;
                    }
                    int user_id = user.getUser_id();
                    billDAO dao = new billDAO();
                    List<model.Bill> allBills = dao.getBillByID(user_id);

                    String paymentFilter = request.getParameter("paymentFilter");
                    String sortBy = request.getParameter("sortBy");

                    // Lọc theo hình thức giao dịch
                    if (paymentFilter != null && !paymentFilter.isEmpty()) {
                        allBills = allBills.stream()
                                .filter(b -> b.getPayment() != null && b.getPayment().equalsIgnoreCase(paymentFilter))
                                .collect(Collectors.toList());
                    }

                    // Sắp xếp theo ngày hoặc tổng đơn
                    if (sortBy != null && !sortBy.isEmpty()) {
                        switch (sortBy) {
                            case "date_asc":
                                allBills.sort((a, b) -> a.getDate().compareTo(b.getDate()));
                                break;
                            case "date_desc":
                                allBills.sort((a, b) -> b.getDate().compareTo(a.getDate()));
                                break;
                            case "total_asc":
                                allBills.sort((a, b) -> Float.compare(a.getTotal(), b.getTotal()));
                                break;
                            case "total_desc":
                                allBills.sort((a, b) -> Float.compare(b.getTotal(), a.getTotal()));
                                break;
                        }
                    }

                    // Phân trang
                    int itemsPerPage = 5;
                    int totalItems = allBills.size();
                    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

                    String pageParam = request.getParameter("page");
                    int currentPage = 1;
                    if (pageParam != null) {
                        try {
                            currentPage = Integer.parseInt(pageParam);
                        } catch (NumberFormatException e) {
                            currentPage = 1;
                        }
                    }
                    currentPage = Math.max(1, Math.min(currentPage, totalPages));

                    int startIndex = (currentPage - 1) * itemsPerPage;
                    int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

                    List<model.Bill> paginatedBills = (totalItems > 0 && startIndex < endIndex)
                            ? allBills.subList(startIndex, endIndex)
                            : new java.util.ArrayList<>();

                    request.setAttribute("bill", paginatedBills);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("itemsPerPage", itemsPerPage);

                    request.getRequestDispatcher("my-account.jsp").forward(request, response);
                } else {
                    response.sendRedirect("user?action=login");
                }
            } catch (Exception e) {
                response.sendRedirect("user?action=login");
            }
        } else if (action.equals("showdetail")) {
            String bill_id = request.getParameter("bill_id");
            int id = Integer.parseInt(bill_id);
            billDAO dao = new billDAO();
            List<BillDetail> detail = dao.getDetail(id);
            request.setAttribute("detail", detail);
            request.getRequestDispatcher("billdetail.jsp").forward(request, response);
        } else if (action.equals("updateinfo")) {
            try {
                HttpSession session = request.getSession();
                model.User user = (model.User) session.getAttribute("user");
                if (user != null) {
                    String user_name = request.getParameter("user_name");
                    String user_pass = request.getParameter("user_pass");
                    String dateOfBirth = request.getParameter("dateOfBirth");
                    String address = request.getParameter("address");
                    String phoneNumber = request.getParameter("phoneNumber");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    address = (address != null ? address.trim() : "");
                    if (address.isEmpty()) {
                        session.setAttribute("error_address", "Địa chỉ không được để trống");
                        request.getRequestDispatcher("user?action=myaccount").forward(request, response);
                        return;
                    }
                    try {
                        Date dob = sdf.parse(dateOfBirth);
                        Date currentDate = new Date();
                        if (dob.after(currentDate)) {
                            session.setAttribute("error_dob", "Ngày sinh không được lớn hơn ngày hiện tại");
                            request.getRequestDispatcher("user?action=myaccount").forward(request, response);
                            return;
                        }
                    } catch (Exception ex) {
                    }

                    boolean isValidPassword = false;
                    if (user_pass != null && !user_pass.isEmpty()) {
                        boolean hasUpperCase = !user_pass.equals(user_pass.toLowerCase());
                        boolean hasNumber = user_pass.matches(".*\\d.*");
                        isValidPassword = hasUpperCase && hasNumber;
                    }

                    if (isValidPassword) {
                        int user_id = user.getUser_id();
                        UserDAO dao2 = new UserDAO();
                        dao2.updateUser(user_id, user_name, user_pass, dateOfBirth, address, phoneNumber);
                        model.User user1 = new model.User(user.getUser_id(), user_name, user.getUser_email(), user_pass, user.getIsAdmin(), dateOfBirth, address, phoneNumber, user.isBanned(), user.getAdminReason(), user.getIsStoreStaff());
                        session.setAttribute("user", user1);
                        session.setAttribute("updateMessage", "Cập nhật thông tin thành công!");
                        response.sendRedirect("user?action=myaccount");
                    } else {
                        session.setAttribute("error_pass", "Mật khẩu chữ cái đầu phải viết hoa và có ít nhất 1 số");
                        request.getRequestDispatcher("user?action=myaccount").forward(request, response);
                    }
                } else {
                    response.sendRedirect("user?action=login");
                }
            } catch (Exception ex) {
                response.sendRedirect("user?action=login");
            }
        } else if (action.equals("signup")) {
            HttpSession session = request.getSession();
            UserDAO da = new UserDAO();
            String email = request.getParameter("user_email");
            String pass = request.getParameter("user_pass");
            String repass = request.getParameter("re_pass");
            String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
            boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);
            String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{6,}$";
            if (!pass.matches(passwordRegex)) {
                session.setAttribute("error_match", "Mật khẩu phải có ít nhất 6 ký tự, bao gồm ít nhất một chữ cái viết hoa và một chữ số");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            if (!verify) {
                session.setAttribute("Recaptcha", "Vui lòng xác nhận mã captcha");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            if (!pass.equals(repass)) {
                session.setAttribute("error_rePass", "Vui lòng nhập lại mật khẩu cho đúng");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                model.User a = da.checkAcc(email);
                if (a == null) {
                    SendEmail sm = new SendEmail();
                    String code = sm.getRandom();
                    UserC userc = new UserC(code, email);
                    boolean test = sm.sendEmail1(userc);
                    if (test && userc != null) {
                        session.setAttribute("userc", userc);
                        session.setAttribute("email", email);
                        session.setAttribute("pass", pass);
                        response.sendRedirect("verify.jsp");
                        return;
                    }
                } else {
                    session.setAttribute("msg", "Email đã tồn tại");
                    response.sendRedirect("user?action=login");
                }
            }
        }
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
        return "Short description";
    }
}
