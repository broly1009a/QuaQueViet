<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>checkout page  |  Quà Quê Việt</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

        <!-- CSS -->
        <link rel="stylesheet" href="assets/css/plugins.css">
        <link rel="stylesheet" href="assets/css/style.css">

    </head>

    <body>

        <!-- Main Wrapper Start -->
        <!--Offcanvas menu area start-->
        <div class="off_canvars_overlay"></div>
        <jsp:include page="layout/menu.jsp"/>
        <!--breadcrumbs area start-->
        <div class="breadcrumbs_area other_bread">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="home">Trang chủ</a></li>
                                <li>/</li>
                                <li>checkout</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--breadcrumbs area end-->

        <!--Checkout page section-->
        <div class="Checkout_section" id="accordion">
            <div class="container">
                <div class="checkout_form">

                    <form action="checkout" method="POST">
                        <div class="row">
                            <div class="col-lg-5 col-md-5">
                                <h3>Chi tiết đơn hàng</h3>
                                <div class="row">
                                    <div class="col-lg-12 mb-20">
                                        <label>Tên khách hàng<span>*</span></label>
                                        <input readonly="" value="${sessionScope.user.user_name}" type="text">
                                    </div>
                                    <div class="col-lg-12 mb-20">
                                        <label>Email <span>*</span></label>
                                        <input readonly="" value="${sessionScope.user.user_email}" type="text">
                                    </div>
                                    <div class="col-lg-12 mb-20">
                                        <label><b>Địa chỉ<span>*</span></b></label>
                                        <input type="text" name="address" value="${param.address}" placeholder="Nhập địa chỉ (Xã,Huyện,Tỉnh)">
                                        <c:if test="${not empty sessionScope.error_address}">   
                                            <div class="text-danger" style="margin-top:5px;">
                                                ${sessionScope.error_address}
                                            </div>
                                            <c:remove var="error_address" scope="session"/>
                                        </c:if>
                                    </div>
                                    <div class="col-lg-12 mb-20">
                                        <label><b>Số điện thoại</b></label>
                                        <input type="text" name="phone" value="${param.phone}" placeholder="Nhập số điện thoại (10 số)">
                                        <c:if test="${not empty sessionScope.error_phone}">
                                            <div class="text-danger" style="margin-top:5px;">
                                                ${sessionScope.error_phone}
                                            </div>
                                            <c:remove var="error_phone" scope="session"/>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-7 col-md-7">
                                <h3>Sản phẩm</h3>
                                <div class="order_table table-responsive">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Product</th>
<!--                                                <th>Size</th>
                                                <th>Color</th>-->
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="o" value="${sessionScope.cart}"/>
                                            <c:forEach items="${o.items}" var="i">
                                                <tr>
                                                    <td> ${i.product.product_name} <strong> × ${i.quantity}</strong></td>
<!--                                                    <td> ${i.size}</td>
                                                    <td> ${i.color}</td>-->
                                                    <td>
                                                        <fmt:formatNumber value="${i.product.product_price * i.quantity}" 
                                                                          type="number" 
                                                                          groupingUsed="true" 
                                                                          minFractionDigits="0" 
                                                                          maxFractionDigits="0" />                                                       
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <c:if test="${sessionScope.cart!=null}">
                                            <tfoot>
                                                <tr>
                                                    <th>Tổng giá</th>
                                                    <td>
                                                        <fmt:formatNumber value="${sessionScope.total}"  
                                                                          type="number" groupingUsed="true" 
                                                                          minFractionDigits="0" 
                                                                          maxFractionDigits="0" />

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>Phí ship</th>
                                                    <td><strong>0</strong></td>
                                                </tr>
                                                 <tr>
                                                    <th>Mã Giảm</th>
                                                    <td><strong>${discountCode}</strong></td>
                                                </tr>
                                                <tr class="order_total">
                                                    <th>Tổng đơn</th>
                                                    <td><strong><fmt:formatNumber value="${sessionScope.finalTotal + 0}" 
                                                                      type="number" 
                                                                      groupingUsed="true" 
                                                                      minFractionDigits="0"
                                                                      maxFractionDigits="0" />
                                                        </strong></td>
                                                </tr>
                                            </tfoot>
                                        </c:if>
                                    </table>
                                </div>
                                <div class="panel-default">
                                    <input id="payment_defult" value="vnpay" name="payment_method" type="radio"/>
                                    <label for="payment_defult">VN Pay <img src="assets/img/icon/vnpay.jpg" alt="" style="margin-left: 50px"></label>
                                </div>
                                <div class="panel-default">
                                    <input id="payment_defult" value="cod" name="payment_method" type="radio"/>
                                    <label for="payment_defult">COD(Thanh toán khi nhận hàng) <img src="assets/img/icon/COD.jpg" alt="" style="margin-left: 50px"></label>
                                        <c:if test="${not empty sessionScope.error_payment}">
                                        <div class="text-danger" style="margin-top:5px;">
                                            ${sessionScope.error_payment}
                                        </div>
                                        <c:remove var="error_payment" scope="session"/>
                                    </c:if>
                                </div>
                                <div class="order_button">
                                    <button type="submit">Đặt hàng</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!--Checkout page section end-->

        <!-- Footer -->
        <jsp:include page="layout/footer.jsp"/>
        <!--footer area end-->

        <!-- JS -->
        <script src="assets/js/plugins.js"></script>

        <script src="assets/js/main.js"></script>
    </body>

</html>
