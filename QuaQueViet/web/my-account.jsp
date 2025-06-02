<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                    <!doctype html>
                    <html class="no-js" lang="en">

                    <head>
                        <meta charset="utf-8">
                        <meta http-equiv="x-ua-compatible" content="ie=edge">
                        <title>Tài Khoản Của Tôi | shopMF</title>
                        <meta name="description" content="">
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <!-- Favicon -->
                        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

                        <!-- CSS 
        ========================= -->

                        <!-- Plugins CSS -->
                        <link rel="stylesheet" href="assets/css/plugins.css">

                        <!-- Main Style CSS -->
                        <link rel="stylesheet" href="assets/css/style.css">
                        <style>
                            body {
                                background-color: #f4f7f6;
                                color: #333;
                                font-family: 'Roboto', sans-serif;
                            }

                            .account_dashboard {
                                background-color: #ffffff;
                                border-radius: 15px;
                                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                                padding: 30px;
                                margin-top: 50px;
                            }

                            .dashboard_tab_button ul {
                                background-color: #f8f9fa;
                                border-radius: 10px;
                                overflow: hidden;
                            }

                            .dashboard_tab_button ul li {
                                margin-bottom: 10px;
                            }

                            .dashboard_tab_button ul li a {
                                color: #ffffff;
                                padding: 15px 20px;
                                transition: all 0.3s ease;
                                border-radius: 8px;
                                display: block;
                                background-color: black;
                            }

                            .dashboard_tab_button ul li a:hover,
                            .dashboard_tab_button ul li a.active {
                                background-color: #ff6a28;
                                color: #ffffff;
                                transform: translateX(5px);
                            }

                            .tab-content {
                                background-color: #ffffff;
                                border-radius: 15px;
                                padding: 30px;
                                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                            }

                            .table {
                                border-collapse: separate;
                                border-spacing: 0 15px;
                            }

                            .table thead th {
                                background-color: #007bff;
                                color: #ffffff;
                                border: none;
                                padding: 15px;
                                font-weight: 500;
                            }

                            .table tbody tr {
                                background-color: #ffffff;
                                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                                transition: all 0.3s ease;
                            }

                            .table tbody tr:hover {
                                transform: translateY(-5px);
                                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                            }

                            .table td {
                                border: none;
                                padding: 20px 15px;
                                vertical-align: middle;
                            }

                            .view {
                                color: #007bff;
                                text-decoration: none;
                                font-weight: 500;
                                transition: all 0.3s ease;
                            }

                            .view:hover {
                                color: #0056b3;
                                text-decoration: underline;
                            }

                            .account_login_form input {
                                border: 2px solid #e9ecef;
                                border-radius: 8px;
                                padding: 15px;
                                margin-bottom: 20px;
                                transition: all 0.3s ease;
                            }

                            .account_login_form input:focus {
                                border-color: orange;
                                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
                            }

                            .account_login_form button {
                                background-color: black;
                                color: #ffffff;
                                border: none;
                                padding: 15px 30px;
                                border-radius: 8px;
                                font-weight: 500;
                                transition: all 0.3s ease;
                            }

                            .account_login_form button:hover {
                                background-color: #ff6a28;
                                transform: translateY(-3px);
                                box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
                            }

                            h3 {
                                color: #007bff;
                                margin-bottom: 30px;
                                font-weight: 700;
                            }

                            .success {
                                color: #28a745;
                                font-weight: 500;
                            }

                            /* Phân trang */
                            .pagination {
                                margin-top: 20px;
                                justify-content: center;
                                display: flex;
                                /* Để hiển thị hàng ngang */
                            }

                            .page-item {
                                list-style: none;
                                margin: 0 5px;
                            }

                            .page-link {
                                color: #007bff;
                                text-decoration: none;
                                padding: 8px 12px;
                                border: 1px solid #dee2e6;
                                border-radius: 4px;
                            }

                            .page-item.active .page-link {
                                background-color: #007bff;
                                color: #fff;
                                border-color: #007bff;
                            }
                        </style>
                    </head>

                    <body>

                        <!-- Main Wrapper Start -->
                        <!--Offcanvas menu area start-->
                        <div class="off_canvars_overlay"></div>
                        <jsp:include page="layout/menu.jsp" />
                        <!--breadcrumbs area start-->
                        <div class="breadcrumbs_area other_bread">
                            <div class="container">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="breadcrumb_content">
                                            <ul>
                                                <li><a href="home">home</a></li>
                                                <li>/</li>
                                                <li>my account</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--breadcrumbs area end-->

                        <!-- my account start  -->
                        <section class="main_content_area">
                            <div class="container">
                                <div class="account_dashboard">
                                    <div class="row">
                                        <div class="col-sm-12 col-md-2 col-lg-2">
                                            <!-- Nav tabs -->
                                            <div class="dashboard_tab_button">
                                                <ul role="tablist" class="nav flex-column dashboard-list">
                                                    <li><a href="#account-details" data-toggle="tab"
                                                            class="nav-link">Tài khoản của tôi</a></li>
                                                    <li><a href="#change-password" data-toggle="tab"
                                                            class="nav-link">Đổi Mật Khẩu</a></li>
                                                    <li><a href="#orders" data-toggle="tab" class="nav-link">Đơn
                                                            hàng</a></li>
                                                    <li>
                                                        <a href="user?action=myaccount&tab=discounts"
                                                            class="nav-link ${param.tab == 'discounts' ? 'active' : ''}">Mã
                                                            Giảm Giá</a>
                                                    </li>


                                                    <!-- <li><a href="user?action=logout" class="nav-link">Đăng xuất</a></li> -->
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-sm-12 col-md-10 col-lg-10">
                                            <!-- Tab panes -->
                                            <div class="tab-content dashboard_content">
                                                <!-- Tab ĐỔI MẬT KHẨU -->
                                                <div class="tab-pane fade" id="change-password">
                                                    <h3>Đổi Mật Khẩu</h3>
                                                    <div class="login">
                                                        <div class="login_form_container">
                                                            <div class="account_login_form">
                                                                <form action="users?action=changePassword"
                                                                    method="POST">
                                                                    <label><b>Mật khẩu cũ</b></label>
                                                                    <input type="password" name="old_password"
                                                                        placeholder="Nhập mật khẩu cũ" required>

                                                                    <label><b>Mật khẩu mới</b></label>
                                                                    <input type="password" name="new_password"
                                                                        placeholder="Nhập mật khẩu mới" required>

                                                                    <label><b>Xác nhận mật khẩu mới</b></label>
                                                                    <input type="password" name="confirm_new_password"
                                                                        placeholder="Xác nhận mật khẩu mới" required>

                                                                    <div class="cart_submit">
                                                                        <button type="submit">Lưu</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Tab ĐƠN HÀNG -->
                                                <div class="tab-pane fade ${param.tab == 'orders' ? 'show active' : ''}"
                                                    id="orders">
                                                    <h3>Đơn hàng</h3>

                                                    <!-- Bộ lọc -->
                                                    <form method="get" action="user" style="margin-bottom: 20px;">
                                                        <input type="hidden" name="action" value="myaccount" />
                                                        <input type="hidden" name="tab" value="orders" />
                                                        <div class="row g-2">
                                                            <div class="col-md-3">
                                                                <select class="form-select" name="paymentFilter"
                                                                    onchange="this.form.submit()">
                                                                    <option value="">-- Tất cả --</option>
                                                                    <option value="COD" ${param.paymentFilter=='COD'
                                                                        ? 'selected' : '' }>COD</option>
                                                                    <option value="VNPay" ${param.paymentFilter=='VNPay'
                                                                        ? 'selected' : '' }>VNPay</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <select class="form-select" name="sortBy"
                                                                    onchange="this.form.submit()">
                                                                    <option value="">-- Sắp xếp --</option>
                                                                    <option value="date_asc" ${param.sortBy=='date_asc'
                                                                        ? 'selected' : '' }>Ngày tăng dần</option>
                                                                    <option value="date_desc"
                                                                        ${param.sortBy=='date_desc' ? 'selected' : '' }>
                                                                        Ngày giảm dần</option>
                                                                    <option value="total_asc"
                                                                        ${param.sortBy=='total_asc' ? 'selected' : '' }>
                                                                        Tổng đơn tăng dần</option>
                                                                    <option value="total_desc"
                                                                        ${param.sortBy=='total_desc' ? 'selected' : ''
                                                                        }>Tổng đơn giảm dần</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </form>

                                                    <div class="table-responsive">
                                                        <table class="table orders-table">
                                                            <thead>
                                                                <tr>
                                                                    <th class="tt">TT</th>
                                                                    <th>Mã đơn</th>
                                                                    <th>Ngày</th>
                                                                    <th>Hình thức GD</th>
                                                                    <th>Địa chỉ</th>
                                                                    <th>Tổng</th>
                                                                    <th>Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:set var="stt"
                                                                    value="${(currentPage-1)*itemsPerPage}" />
                                                                <c:forEach items="${bill}" var="b" varStatus="loop">
                                                                    <tr>
                                                                        <td class="tt">${stt + loop.index + 1}</td>
                                                                        <td>${b.bill_id}</td>
                                                                        <td>${b.date}</td>
                                                                        <td><span class="success">${b.payment}</span>
                                                                        </td>
                                                                        <td>${b.address}</td>
                                                                        <td>
                                                                            <fmt:formatNumber value="${b.total}"
                                                                                type="number" groupingUsed="true"
                                                                                minFractionDigits="0"
                                                                                maxFractionDigits="0" /> VND
                                                                        </td>
                                                                        <td>
                                                                            <a href="report?action=viewReport&bill_id=${b.bill_id}"
                                                                                class="view">Xem</a>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <!-- Phân trang với Prev/Next -->
                                                    <nav aria-label="Page navigation">
                                                        <ul class="pagination justify-content-center">
                                                            <!-- Prev -->
                                                            <li class="page-item ${currentPage<=1?'disabled':''}">
                                                                <a class="page-link"
                                                                    href="user?action=myaccount&tab=orders&page=${currentPage-1}&paymentFilter=${param.paymentFilter}&sortBy=${param.sortBy}">«
                                                                    Prev</a>
                                                            </li>
                                                            <!-- Số trang -->
                                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                                <li class="page-item ${i==currentPage?'active':''}">
                                                                    <a class="page-link"
                                                                        href="user?action=myaccount&tab=orders&page=${i}&paymentFilter=${param.paymentFilter}&sortBy=${param.sortBy}">${i}</a>
                                                                </li>
                                                            </c:forEach>
                                                            <!-- Next -->
                                                            <li
                                                                class="page-item ${currentPage>=totalPages?'disabled':''}">
                                                                <a class="page-link"
                                                                    href="user?action=myaccount&tab=orders&page=${currentPage+1}&paymentFilter=${param.paymentFilter}&sortBy=${param.sortBy}">Next
                                                                    »</a>
                                                            </li>
                                                        </ul>
                                                    </nav>
                                                </div>
                                                <!-- Tab TÀI KHOẢN CỦA TÔI -->
                                                <div class="tab-pane fade ${param.tab == null || (param.tab != 'orders' && param.tab != 'discounts') ? 'show active' : ''}"
                                                    id="account-details">

                                                    <h3>Tài khoản của tôi </h3>
                                                    <div class="login">
                                                        <div class="login_form_container">
                                                            <div class="account_login_form">
                                                                <form action="user?action=updateinfo" method="POST">
                                                                    <label><b>Tên người dùng</b></label>
                                                                    <input type="text" name="user_name"
                                                                        value="${sessionScope.user.user_name}"
                                                                        placeholder="Nhập tên người dùng">

                                                                    <label><b>Email</b></label>
                                                                    <input type="text" readonly name="user_email"
                                                                        value="${sessionScope.user.user_email}">

                                                                    <label><b>Ngày sinh</b></label>
                                                                    <input type="date" name="dateOfBirth"
                                                                        value="${sessionScope.user.dateOfBirth}"
                                                                        placeholder="Nhập ngày sinh(ngày/tháng/năm)">

                                                                    <label><b>Địa chỉ</b></label>
                                                                    <input type="text" name="address"
                                                                        value="${sessionScope.user.address}"
                                                                        placeholder="Nhập địa chỉ (Xã,Huyện,Tỉnh)">

                                                                    <label><b>Số điện thoại</b></label>
                                                                    <input type="text" name="phoneNumber"
                                                                        value="${sessionScope.user.phoneNumber}"
                                                                        placeholder="Nhập số điện thoại (10 số)">

                                                                    <div class="cart_submit">
                                                                        <button type="submit">Lưu</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="tab-pane fade ${param.tab == 'discounts' ? 'show active' : ''}"
                                                    id="discounts">
                                                    <h3>Danh sách mã giảm giá</h3>
                                                    <c:if test="${empty availableCodes}">
                                                        <p>Không có mã giảm giá nào hiện tại.</p>
                                                    </c:if>
                                                    <c:forEach items="${availableCodes}" var="d">
                                                        <div
                                                            style="border: 1px solid #ccc; padding: 15px; margin-bottom: 15px; border-radius: 10px;">
                                                            <p><strong>Mã:</strong> ${d.saleCode}</p>
                                                            <p><strong>Loại:</strong> ${d.discountType}</p>
                                                            <p><strong>Giá trị:</strong>
                                                                <c:choose>
                                                                    <c:when test="${d.discountType == 'Percentage'}">
                                                                        <fmt:formatNumber value="${d.discountValue}"
                                                                            type="number" groupingUsed="true"
                                                                            minFractionDigits="0"
                                                                            maxFractionDigits="0" />%
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <fmt:formatNumber value="${d.discountValue}"
                                                                            type="number" groupingUsed="true"
                                                                            minFractionDigits="0"
                                                                            maxFractionDigits="0" /> VND
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                            <p><strong>Giảm tối đa:</strong>
                                                                <fmt:formatNumber value="${d.maxDiscount}" type="number"
                                                                    groupingUsed="true" minFractionDigits="0"
                                                                    maxFractionDigits="0" /> VND
                                                            </p>
                                                            <p><strong>HSD:</strong> ${d.start_date} → ${d.end_date}</p>
                                                            <p><strong>Số lượng còn:</strong> ${d.quantity}</p>
                                                        </div>
                                                    </c:forEach>
                                                </div>

                                                <!-- end tab account-details -->


                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </section>
                        <!-- my account end   -->
                        <!--footer area start-->
                        <jsp:include page="layout/footer.jsp" />
                        <!--footer area end-->

                        <!-- JS
        ============================================ -->

                        <!-- Plugins JS -->
                        <script src="assets/js/plugins.js"></script>

                        <!-- Main JS -->
                        <script src="assets/js/main.js"></script>
                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                        <script>
                            function z`showNotification(message, isSuccess) {
                                                        Swal.fire({
                                                            title: isSuccess ? 'Thành công!' : 'Lỗi!',
                                                            text: message,
                                                            icon: isSuccess ? 'success' : 'error',
                                                            toast: true,
                                                            position: 'top-end',
                                                            showConfirmButton: false,
                                                            timer: 3000,
                                                            timerProgressBar: true,
                                                            didOpen: (toast) => {
                                                                toast.addEventListener('mouseenter', Swal.stopTimer)
                                                                toast.addEventListener('mouseleave', Swal.resumeTimer)
                                                            }
                                                        });
                                                    }

                                                    // Kiểm tra và hiển thị thông báo khi trang được tải
                                                    document.addEventListener('DOMContentLoaded', function () {
                                                        var error_dob = "${sessionScope.error_dob}";
                                                        var error_pass = "${sessionScope.error_pass}";
                                                        var updateMessage = "${sessionScope.updateMessage}";
                                                        if (error_dob) {
                                                            showNotification(error_dob, false);
            <% session.removeAttribute("error_dob"); %>
                                                        }
                                                        if (updateMessage) {
                                                            showNotification(updateMessage, true);
            <% session.removeAttribute("updateMessage"); %>
                                                        } else if (error_pass) {
                                                            showNotification(error_pass, false);
            <% session.removeAttribute("error_pass"); %>
                                                        }
                                                    });
                        </script>
                    </body>

                    </html>