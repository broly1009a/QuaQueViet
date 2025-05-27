package Controller.Admin;

import dal.SaleOffDAO;
import model.SaleOff;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.User;

@WebServlet(name = "SaleOffServlet", urlPatterns = {"/saleoff"})
public class SaleOffServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        try {
            HttpSession session = request.getSession();
            model.User user = (User) session.getAttribute("user");
            // Kiểm tra người dùng có phải admin không

            if (user != null && user.getIsAdmin().equalsIgnoreCase("true")) {
                String action = request.getParameter("action");
                SaleOffDAO saleOffDAO = new SaleOffDAO();

                // Các tham số tìm kiếm
                String saleCode = request.getParameter("saleCode");
                String discountType = request.getParameter("discountType");
                String sortDiscountValue = request.getParameter("sortDiscountValue");

                // Các tham số phân trang
                String pageIndexStr = request.getParameter("page");
                int pageIndex = 1;
                if (pageIndexStr != null) {
                    try {
                        pageIndex = Integer.parseInt(pageIndexStr);
                    } catch (NumberFormatException e) {
                        pageIndex = 1;
                    }
                }
                int pageSize = 5; // ví dụ 5 sản phẩm mỗi trang
                if (action == null || action.equals("")) {
                    List<SaleOff> saleOffList;

                    //nếu không nhập gì, lấy tất cả sale off
                    if ((saleCode == null || saleCode.trim().isEmpty())
                            && (discountType == null || discountType.trim().isEmpty())
                            && (sortDiscountValue == null || sortDiscountValue.trim().isEmpty())) {

                        saleOffList = saleOffDAO.getAllSaleOffs();
                    } else {
                        //nếu có nhập vào thanh tìm kiếm
                        saleOffList = saleOffDAO.searchSaleOffs(saleCode, discountType, sortDiscountValue);
                    }
                    int totalRecords = saleOffList.size();
                    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

                    int fromIndex = (pageIndex - 1) * pageSize;
                    int toIndex = Math.min(fromIndex + pageSize, totalRecords);

                    List<SaleOff> allSaleOffList = new ArrayList<>();
                    if (fromIndex < totalRecords) {
                        saleOffList = saleOffList.subList(fromIndex, toIndex);
                    }

                    // Gửi dữ liệu qua JSP
                    request.setAttribute("saleOffs", saleOffList);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("pageIndex", pageIndex);

                    // Giữ lại thông tin tìm kiếm khi phân trang
                    request.setAttribute("saleCode", saleCode);
                    request.setAttribute("discountType", discountType);
                    request.setAttribute("sortDiscountValue", sortDiscountValue);
                    HttpSession s = request.getSession();
                    List<String> errors = (List<String>) s.getAttribute("errors");
                    Integer editId = (Integer) s.getAttribute("editId");

                    Boolean addFail = (Boolean) session.getAttribute("addFail");
                    String successMessage = (String) session.getAttribute("successMessage");

                    if (errors != null) {
                        request.setAttribute("errors", errors);
                        session.removeAttribute("errors");
                    }
                    if (editId != null) {
                        request.setAttribute("editId", editId);
                        session.removeAttribute("editId");
                    }
                    if (addFail != null) {
                        request.setAttribute("addFail", addFail);
                        session.removeAttribute("addFail");
                    }
                    if (successMessage != null) {
                        request.setAttribute("successMessage", successMessage);
                        session.removeAttribute("successMessage");
                    }
                    session.removeAttribute("inputSaleCode");
                    session.removeAttribute("inputDiscountType");
                    session.removeAttribute("inputDiscountValue");
                    session.removeAttribute("inputMaxDiscount");
                    session.removeAttribute("inputStartDate");
                    session.removeAttribute("inputEndDate");
                    session.removeAttribute("inputQuantity");

                    request.setAttribute("saleOffs", saleOffList);
                    request.getRequestDispatcher("admin/saleoff.jsp").forward(request, response);
                }

            } else {
                response.sendRedirect("user?action=login");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("404.jsp");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Kiểm tra quyền admin từ session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        SaleOffDAO dao = new SaleOffDAO();
        if (user != null && user.getIsAdmin().equalsIgnoreCase("true")) {
            if (action.equalsIgnoreCase("add")) {
                String saleCode = request.getParameter("saleCode");
                if (dao.isSaleCodeExists(saleCode)) {
                    List<String> errors = new ArrayList<>();
                    errors.add("Mã giảm giá đã tồn tại. Vui lòng chọn mã khác.");

                    // Gán lại dữ liệu nhập để giữ input
                    session.setAttribute("errors", errors);
                    session.setAttribute("addFail", true);
                    session.setAttribute("inputSaleCode", saleCode);
                    session.setAttribute("inputDiscountType", request.getParameter("discountType"));
                    session.setAttribute("inputDiscountValue", request.getParameter("discountValue"));
                    session.setAttribute("inputMaxDiscount", request.getParameter("maxDiscount"));
                    session.setAttribute("inputStartDate", request.getParameter("startDate"));
                    session.setAttribute("inputEndDate", request.getParameter("endDate"));
                    session.setAttribute("inputQuantity", request.getParameter("quantity"));

                    response.sendRedirect("saleoff");
                    return;
                }

                // Nếu không trùng thì thêm
                addSaleOff(request, response);

            } else if (action.equalsIgnoreCase("update")) {
                updateSaleOff(request, response);
            } else if (action.equalsIgnoreCase("delete")) {
                deleteSaleOff(request, response);
            }
        } else {
            response.sendRedirect("user?action=login");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// 

    private void addSaleOff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String saleCode = request.getParameter("saleCode");
            String discountType = request.getParameter("discountType");
            String discountValueStr = request.getParameter("discountValue").replace(",", ".");
            String maxDiscountStr = request.getParameter("maxDiscount").replace(",", ".");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String quantityStr = request.getParameter("quantity");

            List<String> errors = new ArrayList<>();

            if (saleCode == null || saleCode.trim().isEmpty()) {
                errors.add("Mã giảm giá không được để trống");
            }
            if (saleCode != null && saleCode.length() > 10) {
                errors.add("Mã giảm giá không được vượt quá 10 ký tự.");
            }

            if (!"Percentage".equalsIgnoreCase(discountType) && !"Fixed".equalsIgnoreCase(discountType)) {
                errors.add("Loại giảm giá không hợp lệ.");
            }
            

            double discountValue = 0;
            try {
                discountValue = Double.parseDouble(discountValueStr);
                if (discountValue <= 0) {
                    errors.add("Giá trị giảm phải lớn hơn 0.");
                }
                if ("Percentage".equalsIgnoreCase(discountType) && discountValue > 100) {
                    errors.add("Phần trăm giảm giá không được vượt quá 100%.");
                }
            } catch (NumberFormatException e) {
                errors.add("Giá trị giảm giá không hợp lệ.");
            }

            double maxDiscount = 0;
            try {
                maxDiscount = Double.parseDouble(maxDiscountStr);
                if (maxDiscount <= 0) {
                    errors.add("Giảm tối đa phải lớn hơn 0.");
                }
            } catch (NumberFormatException e) {
                errors.add("Giảm tối đa không hợp lệ.");
            }

            int quantity = 0;
            try {
                quantity = Integer.parseInt(quantityStr);
                if (quantity <= 0) {
                    errors.add("Số lượng phải lớn hơn 0.");
                }
            } catch (NumberFormatException e) {
                errors.add("Số lượng không hợp lệ.");
            }

            Date startDate = null, endDate = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setTimeZone(java.util.TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
            try {
                
                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = sdf.parse(startDateStr);
                }
                if (endDateStr != null && !endDateStr.isEmpty()) {
                    endDate = sdf.parse(endDateStr);
                }
                if (startDate != null && endDate != null && startDate.after(endDate)) {
                    errors.add("Ngày bắt đầu phải trước hoặc bằng ngày kết thúc.");
                }
            } catch (ParseException e) {
                errors.add("Định dạng ngày không hợp lệ.");
            }

            // Kiểm tra ngày bắt đầu không ở quá khứ
            Date today = new Date();
            SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyyMMdd");
            String todayStr = sdfDateOnly.format(today);
            String startDateStrOnly = sdfDateOnly.format(startDate);

            if (startDate != null && Integer.parseInt(startDateStrOnly) < Integer.parseInt(todayStr)) {
                errors.add("Ngày bắt đầu không được trước ngày hiện tại.");
            }

            // Kiểm tra mối quan hệ discountValue và maxDiscount theo loại
            // Nếu có lỗi -> lưu lỗi vào session, redirect về saleoff
            if (!errors.isEmpty()) {
                HttpSession session = request.getSession();
                session.setAttribute("errors", errors);
                session.setAttribute("addFail", true);

                // Gửi lại các giá trị người dùng vừa nhập
                session.setAttribute("inputSaleCode", saleCode);
                session.setAttribute("inputDiscountType", discountType);
                session.setAttribute("inputDiscountValue", discountValueStr);
                session.setAttribute("inputMaxDiscount", maxDiscountStr);
                session.setAttribute("inputStartDate", startDateStr);
                session.setAttribute("inputEndDate", endDateStr);
                session.setAttribute("inputQuantity", quantityStr);
                response.sendRedirect("saleoff");
                return;
            }

            // Nếu hợp lệ -> thêm vào DB
            SaleOff newSale = new SaleOff(saleCode, discountType, discountValue, maxDiscount, startDate, endDate, quantity);
            SaleOffDAO dao = new SaleOffDAO();
            boolean success = dao.addSaleOff(newSale);

            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("successMessage", "Thêm mã giảm giá thành công!");
            } else {
                session.setAttribute("errors", List.of("Thêm thất bại. Vui lòng thử lại."));
                session.setAttribute("addFail", true);
            }
            response.sendRedirect("saleoff");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.sendRedirect("404.jsp");
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    private void updateSaleOff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String saleIdStr = request.getParameter("saleId");
            String saleCode = request.getParameter("saleCode");
            String discountType = request.getParameter("discountType");
            String discountValueStr = request.getParameter("discountValue").replace(",", ".");
            String maxDiscountStr = request.getParameter("maxDiscount").replace(",", ".");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String quantityStr = request.getParameter("quantity");
            Date today = new Date();
            List<String> errors = new ArrayList<>();
            int saleId = 0;
            try {
                saleId = Integer.parseInt(saleIdStr);
            } catch (NumberFormatException e) {
                errors.add("Mã giảm giá không hợp lệ (phải là số).");
            }

            if (saleCode == null || saleCode.trim().isEmpty()) {
                errors.add("Mã giảm giá không được để trống");
            }
            if (saleCode != null && saleCode.length() > 10) {
                errors.add("Mã giảm giá không được vượt quá 10 ký tự.");
            }
            // ❗️Check mã có bị trùng không (ngoại trừ chính nó)
            SaleOffDAO dao = new SaleOffDAO();
            if (dao.isSaleCodeExistsForOther(saleId, saleCode)) {
                errors.add("Mã giảm giá đã tồn tại, vui lòng nhập tên mã giảm giá khác");
            }
            if (!"Percentage".equalsIgnoreCase(discountType) && !"Fixed".equalsIgnoreCase(discountType)) {
                errors.add("Loại giảm giá không hợp lệ.");
            }

            double discountValue = 0;
            try {
                discountValue = Double.parseDouble(discountValueStr);
                if (discountValue <= 0) {
                    errors.add("Giá trị giảm phải lớn hơn 0.");
                }
                if ("Percentage".equalsIgnoreCase(discountType) && discountValue > 100) {
                    errors.add("Phần trăm giảm giá không được vượt quá 100%.");
                }
            } catch (NumberFormatException e) {
                errors.add("Giá trị giảm giá không hợp lệ.");
            }

            double maxDiscount = 0;
            try {
                maxDiscount = Double.parseDouble(maxDiscountStr);
                if (maxDiscount <= 0) {
                    errors.add("Giảm tối đa phải lớn hơn 0.");
                }
            } catch (NumberFormatException e) {
                errors.add("Giảm tối đa không hợp lệ.");
            }

            int quantity = 0;
            try {
                quantity = Integer.parseInt(quantityStr);
                if (quantity <= 0) {
                    errors.add("Số lượng phải lớn hơn 0.");
                }
            } catch (NumberFormatException e) {
                errors.add("Số lượng không hợp lệ.");
            }

            Date startDate = null, endDate = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setTimeZone(java.util.TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
            try {
                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = sdf.parse(startDateStr);
                }
                if (endDateStr != null && !endDateStr.isEmpty()) {
                    endDate = sdf.parse(endDateStr);
                }
                if (startDate != null && endDate != null && startDate.after(endDate)) {
                    errors.add("Ngày bắt đầu phải trước hoặc bằng ngày kết thúc.");
                }
            } catch (ParseException e) {
                errors.add("Định dạng ngày không hợp lệ.");
            }

            // Kiểm tra ngày bắt đầu không ở quá khứ
            SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyyMMdd");
            String todayStr = sdfDateOnly.format(today);
            String startDateStrOnly = sdfDateOnly.format(startDate);

            if (startDate != null && Integer.parseInt(startDateStrOnly) < Integer.parseInt(todayStr)) {
                errors.add("Ngày bắt đầu không được trước ngày hiện tại.");
            }

            // Kiểm tra mối quan hệ discountValue và maxDiscount theo loại
            try {
                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = sdf.parse(startDateStr);
                }
                if (endDateStr != null && !endDateStr.isEmpty()) {
                    endDate = sdf.parse(endDateStr);
                }
                if (startDate != null && endDate != null && startDate.after(endDate)) {
                    errors.add("Ngày bắt đầu phải trước hoặc bằng ngày kết thúc.");
                }
            } catch (ParseException e) {
                errors.add("Định dạng ngày không hợp lệ.");
            }

            // Nếu có lỗi -> lưu lỗi vào session, redirect về servlet chính
            if (!errors.isEmpty()) {
                HttpSession session = request.getSession();
                session.setAttribute("errors", errors);
                session.setAttribute("editId", saleId);
                response.sendRedirect("saleoff");
                return;
            }

            // Nếu hợp lệ, cập nhật dữ liệu
            SaleOff updatedSale = new SaleOff(saleId, saleCode, discountType, discountValue, maxDiscount, startDate, endDate, quantity);

            boolean success = dao.updateSaleOff(updatedSale);

            if (success) {
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Cập nhật thành công!");
                response.sendRedirect("saleoff");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("errors", List.of("Cập nhật thất bại. Vui lòng thử lại."));
                session.setAttribute("editId", saleId);
                response.sendRedirect("saleoff");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("404.jsp");
        }
    }

    private void deleteSaleOff(HttpServletRequest request, HttpServletResponse response) {
        try {
            int saleId = Integer.parseInt(request.getParameter("saleId"));
            SaleOffDAO dao = new SaleOffDAO();
            dao.deleteSaleOff(saleId);

            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Xóa thành công!");
            response.sendRedirect("saleoff");
        } catch (Exception e) {
            e.printStackTrace();
            try {
                HttpSession session = request.getSession();
                session.setAttribute("errors", List.of("Xóa thất bại. Vui lòng thử lại."));
                response.sendRedirect("saleoff");
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

}
