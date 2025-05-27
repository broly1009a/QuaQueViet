<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="VnPayCommon.Config"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.text.ParseException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="model.*" %>
<%@ page import="dal.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Kết quả thanh toán</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #e0f7fa 0%, #fff8e1 100%);
                font-family: 'Arial', sans-serif;
                min-height: 100vh;
            }
            .card {
                border-radius: 15px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }
            .status-success {
                color: green;
                font-weight: bold;
                font-size: 22px;
            }
            .status-fail {
                color: red;
                font-weight: bold;
                font-size: 22px;
            }
            .btn-home {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <%
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if (fieldValue != null && fieldValue.length() > 0) {
                    fields.put(fieldName, fieldValue);
                }
            }
            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            fields.remove("vnp_SecureHashType");
            fields.remove("vnp_SecureHash");
            String signValue = Config.hashAllFields(fields);
        %>
        <%
            String vnpAmountRaw = request.getParameter("vnp_Amount");
            long vnpAmount = 0;
            if (vnpAmountRaw != null && !vnpAmountRaw.isEmpty()) {
                try {
                    vnpAmount = Long.parseLong(vnpAmountRaw) / 100; // Chia 100 đúng đơn vị VND
                } catch (NumberFormatException e) {
                    vnpAmount = 0;
                }
            }
            java.text.DecimalFormat formatter = new java.text.DecimalFormat("#,###");
        %>
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card p-4">
                        <h2 class="text-center mb-4">Kết quả thanh toán</h2>
                        <dl class="row">
                            <dt class="col-sm-5">Mã giao dịch:</dt>
                            <dd class="col-sm-7"><%=request.getParameter("vnp_TxnRef").split("R")[0]%></dd>

                            <dt class="col-sm-5">Số tiền:</dt>
                            <dd class="col-sm-7"><%=formatter.format(vnpAmount)%> VND</dd>


                            <dt class="col-sm-5">Thanh toán đơn hàng: </dt>
                            <dd class="col-sm-7"><%=request.getParameter("vnp_OrderInfo")%></dd>

                            <!--                    <dt class="col-sm-5">Mã lỗi thanh toán:</dt>
                                                <dd class="col-sm-7"><%=request.getParameter("vnp_ResponseCode")%></dd>-->

                            <dt class="col-sm-5">Mã giao dịch VNPAY:</dt>
                            <dd class="col-sm-7"><%=request.getParameter("vnp_TransactionNo")%></dd>

                            <dt class="col-sm-5">Mã ngân hàng:</dt>
                            <dd class="col-sm-7"><%=request.getParameter("vnp_BankCode")%></dd>

                            <dt class="col-sm-5">Thời gian thanh toán:</dt>
                            <dd class="col-sm-7">
                                <% 
                                    String originalTimestamp = request.getParameter("vnp_PayDate");
                                    String formattedTimestamp = "";
                                    SimpleDateFormat originalFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                                    SimpleDateFormat newFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                    Date date = originalFormat.parse(originalTimestamp);
                                    formattedTimestamp = newFormat.format(date);
                                    out.print(formattedTimestamp);
                                %>
                            </dd>

                            <dt class="col-sm-5">Tình trạng giao dịch:</dt>
                            <dd class="col-sm-7">
                                <% if (signValue.equals(vnp_SecureHash)) { %>
                                <% if ("00".equals(request.getParameter("vnp_TransactionStatus"))) { %>
                                <span class="status-success">Thanh toán thành công!</span>
                                <% 
                                    try {
                                        BillRubish bill = (BillRubish) request.getSession().getAttribute("pendingBill");
                                        billDAO dao = new billDAO();
                                        if (bill != null) {
                                        Double finalTotal = (Double) session.getAttribute("finalTotal");
                                        double totalPrice = (finalTotal != null) ? finalTotal : bill.getCart().getTotalMoney();
                                            dao.addOrder(bill.getUser(), bill.getCart(), bill.getPayment(), bill.getAddress(), Integer.parseInt(bill.getPhone()), totalPrice);
                                            request.getSession().removeAttribute("cart");
                                            request.getSession().removeAttribute("pendingBill");
                                            request.getSession().removeAttribute("finalTotal");
                                            request.getSession().removeAttribute("discountCode");
                                            request.getSession().removeAttribute("discountAmount");
                                            request.getSession().setAttribute("size", 0);
                                        }
                                    } catch (Exception e) {
                                        out.print("<div class='text-danger'>Xử lý đơn hàng thất bại!</div>");
                                    }
                                %>
                                <% } else { %>
                                <span class="status-fail">Thanh toán không thành công!</span>
                                <% } %>
                                <% } else { %>
                                <span class="status-fail">Chữ ký không hợp lệ!</span>
                                <% } %>
                            </dd>
                        </dl>
                        <div class="text-center">
                            <a href="https://quaqueviet.onrender.com/SWP391_Spring2025_M1_BL5_Group5/home" class="btn btn-primary btn-home">Quay về trang chủ</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>