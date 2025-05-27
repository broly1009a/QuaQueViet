<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Giỏ hàng  | You&Me</title>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>
    </head>
    <style>
        .empty-cart {
            text-align: center;
            padding: 50px 0;
        }

        .empty-cart img {
            width: 150px;
            margin-bottom: 20px;
        }

        .empty-cart p {
            font-size: 20px;
            color: #333;
        }
        .quantity-picker {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            width: 120px;
            height: 40px;
            margin: auto;
        }

        .quantity-picker input[type="number"] {
            width: 40px;
            height: 100%;
            border: none;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            background: white;
            -moz-appearance: textfield;
        }

        .quantity-picker button.qty-btn {
            width: 40px;
            height: 100%;
            font-size: 20px;
            font-weight: bold;
            background-color: #f9f9f9;
            border: none;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .quantity-picker button.qty-btn:hover {
            background-color: #e0e0e0;
        }

        /* Xóa mũi tên spinner mặc định trên input number */
        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        .coupon_code {
            border: none !important;
            padding-left: 0 !important;
            padding-right: 0 !important;
            margin-left: 0 !important;
        }

        .coupon_inner {
            padding: 0 !important;
            margin: 0 !important;
        }

        /* Đảm bảo input và button hiển thị cùng dòng */
        .coupon_inner form {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        /* Tùy chỉnh input đẹp hơn (nếu cần) */
        .coupon_inner input[type="text"] {
            max-width: 250px;
            padding: 6px 10px;
        }
        .discount-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            margin-top: 8px;
        }

        .discount-form {
            display: flex;
            gap: 10px;
            flex-grow: 1;
        }

        .discount-form input[type="text"] {
            max-width: 200px;
            padding: 6px 10px;
        }

        .discount-amount {
            white-space: nowrap;
            color: #4caf50;
            font-weight: bold;
            font-size: 14px;
        }
        .discount-wrapper {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .discount-form {
            display: flex;
            gap: 10px;
            flex-grow: 1;
        }

        .discount-form input[type="text"] {
            max-width: 220px;
            padding: 6px 10px;
        }

        .discount-amount {
            color: #4caf50;
            font-weight: bold;
            white-space: nowrap;
            font-size: 14px;
        }

        .remove-discount-btn {
            background-color: #f44336;
            color: white;
            padding: 6px 12px;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }

    </style>
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
                                <li>Giỏ hàng</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>         
        </div>
        <!--breadcrumbs area end-->
        <!-- shopping cart area start -->
        <div class="shopping_cart_area">
            <div class="container">  
                <c:choose>
                    <c:when test="${empty sessionScope.cart.items}">
                        <div class="empty-cart">
                            <img src="assets/img/logo/no-products-found.jpg" alt="Không có sản phẩm trong giỏ hàng">
                            <p>Không có sản phẩm nào trong giỏ hàng</p>
                            <a href="product" class="button">MUA NGAY</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <div class="col-12">
                                <div class="table_desc">
                                    <div class="cart_page table-responsive">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th class="product_remove">Xóa</th>
                                                    <th class="product_thumb">Ảnh</th>
                                                    <th class="product_name">Sản phẩm</th>
                                                    <th class="product-price">Giá</th>
<!--                                                    <th class="product_quantity">Kích thước</th>
                                                    <th class="product-price">Màu</th>-->
                                                    <th class="product_quantity">Số lượng</th>
                                                    <th class="product_total">Tổng tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:set var="o" value="${sessionScope.cart}" />
                                                <c:forEach items="${o.items}" var="i">
                                                    <tr>
                                                        <td class="product_remove"><a href="cart?action=deletecart&product_id=${i.product.product_id}"><i class="fa fa-trash-o"></i></a></td>
                                                        <td class="product_thumb"><a href="product?action=productdetail&product_id=${i.product.product_id}"><img src="${i.product.img}" alt=""></a></td>
                                                        <td class="product_name"><a href="product?action=productdetail&product_id=${i.product.product_id}">${i.product.product_name}</a></td>
                                                        <td class="product-price"><fmt:formatNumber pattern="##########" value="${i.product.product_price}" /></td>
<!--                                                        <td class="product-price">${i.size}</td>
                                                        <td class="product-price">${i.color}</td>-->
                                                        <td class="product_quantity">
                                                            <div class="quantity-picker">
                                                                <button type="button" class="qty-btn minus" onclick="changeQty(this, '${i.product.product_id}', -1, ${i.product.product_price})">-</button>
                                                                <input name="quantity" type="number" min="1" max="100" value="${i.quantity}"
                                                                       onchange="updateQuantity('${i.product.product_id}', this.value, ${i.product.product_price})">
                                                                <button type="button" class="qty-btn plus" onclick="changeQty(this, '${i.product.product_id}', 1, ${i.product.product_price})">+</button>
                                                            </div>
                                                        </td>

                                                        <td class="product_total" id="total_${i.product.product_id}">
                                                            <fmt:formatNumber pattern="##########" value="${i.product.product_price * i.quantity}" /> VNĐ
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>

                                        <!-- <div class="cart_submit">
                                            <button type="submit">update cart</button>
                                        </div> -->
                                    </div>
                                </div>
                            </div>
                            <!-- Coupon code area start -->
                            <c:if test="${sessionScope.cart != null}">
                                <div class="coupon_area">
                                    <div class="row">
                                        <div class="col-lg-12 col-md-12">
                                            <div class="coupon_code right">
                                                <div class="col-lg-6 col-md-6">
                                                    <div class="coupon_code left">
                                                        <h3>Mã giảm giá</h3>
                                                        <div class="coupon_inner">
                                                            <form action="cart" method="post">
                                                                <input type="hidden" name="action" value="applydiscount"/>
                                                                <input type="text" name="discountCode" placeholder="Nhập mã giảm giá..." value="${sessionScope.discountCode}" />
                                                                <button type="submit">Áp dụng</button>
                                                            </form>

                                                            <c:if test="${not empty sessionScope.discountCode}">
                                                                <form action="cart" method="post" style="margin-top: 10px;">
                                                                    <input type="hidden" name="action" value="removediscount"/>
                                                                    <button type="submit" style="background-color: #f44336;">Hủy mã giảm giá</button>
                                                                </form>
                                                            </c:if>


                                                            <c:if test="${not empty sessionScope.error}">
                                                                <p style="color: red;">${sessionScope.error}</p>
                                                                <% session.removeAttribute("error"); %>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                                <h3>Hóa đơn</h3>
                                                <div class="coupon_inner">

                                                    <div class="cart_subtotal">
                                                        <p>Tổng đơn hàng</p>
                                                        <p class="cart_amount" id="subtotal"><fmt:formatNumber pattern="##########" value="${sessionScope.total}" /> VNĐ</p>
                                                    </div>
                                                    <div class="cart_subtotal ">
                                                        <p>Phí vận chuyển </p>
                                                        <p class="cart_amount" id="shipping">0 VNĐ</p>
                                                    </div>
                                                    <c:if test="${not empty sessionScope.discountAmount}">
                                                        <div class="cart_subtotal">
                                                            <p>Giảm giá 
                                                                <c:if test="${not empty sessionScope.discountPercent}">
                                                                    (<fmt:formatNumber value="${sessionScope.discountPercent}" />%)
                                                                </c:if>
                                                            </p>
                                                            <p class="cart_amount text-success">
                                                                -<fmt:formatNumber value="${sessionScope.discountAmount}" pattern="###,###" /> VNĐ
                                                            </p>
                                                        </div>
                                                    </c:if>                    
                                                    <div class="cart_subtotal">
                                                        <p>Tổng tiền</p>
                                                        <p class="cart_amount">
                                                            <span id="total">
                                                                <fmt:formatNumber pattern="###,###"
                                                                                  value="${sessionScope.finalTotal != null ? sessionScope.finalTotal : sessionScope.total}" />
                                                            </span>VNĐ
                                                        </p>
                                                    </div>
                                                    <div class="checkout_btn">
                                                        <a href="checkout">Thanh toán</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <!-- Coupon code area end -->
                        </c:otherwise>
                    </c:choose>
                    <!--coupon code area end-->
                    </form> 
                </div>     
            </div>
            <!-- shopping cart area end -->

            <!--footer area start-->
            <jsp:include page="layout/footer.jsp"/>
            <!--footer area end-->
            <!-- JS
            ============================================ -->
            <!--map js code here-->
            <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdWLY_Y6FL7QGW5vcO3zajUEsrKfQPNzI"></script>
            <script  src="https://www.google.com/jsapi"></script>
            <script src="assets/js/map.js"></script>
            <!-- Plugins JS -->
            <script src="assets/js/plugins.js"></script>
            <!-- Main JS -->
            <script src="assets/js/main.js"></script>
            <script>
                                                                    function showNotification(message, isSuccess) {
                                                                        Swal.fire({
                                                                            title: isSuccess ? 'Thành công!' : 'Lỗi!',
                                                                            text: message,
                                                                            icon: isSuccess ? 'success' : 'error',
                                                                            toast: true,
                                                                            position: 'top-end',
                                                                            showConfirmButton: false,
                                                                            timer: 6000,
                                                                            timerProgressBar: true,
                                                                            didOpen: (toast) => {
                                                                                toast.addEventListener('mouseenter', Swal.stopTimer)
                                                                                toast.addEventListener('mouseleave', Swal.resumeTimer)
                                                                            }
                                                                        });
                                                                    }

                                                                    // Kiểm tra và hiển thị thông báo khi trang được tải
                                                                    document.addEventListener('DOMContentLoaded', function () {
                                                                        var successMessage = "${sessionScope.successMessageDelete}";
                                                                        var errorMessage = "${sessionScope.errorMessage}";

                                                                        if (successMessage) {
                                                                            showNotification(successMessage, true);
                                                                            // Xóa thông báo khỏi session
                <% session.removeAttribute("successMessageDelete"); %>
                                                                        } else if (errorMessage) {
                                                                            showNotification(errorMessage, false);
                                                                            // Xóa thông báo khỏi session
                <% session.removeAttribute("errorMessage"); %>
                                                                        }
                                                                    });
            </script>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>

            </script><script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                                                                    let cartTotal = ${sessionScope.total}; // Lưu tổng tiền ban đầu

                                                                    function updateQuantity(productId, newQuantity, price) {
                                                                        // Cập nhật tổng tiền cho sản phẩm
                                                                        var newTotal = newQuantity * price;
                                                                        $('#total_' + productId).text(newTotal.toLocaleString() + ' VNĐ');

                                                                        // Gửi yêu cầu AJAX để cập nhật server
                                                                        $.ajax({
                                                                            url: 'cart',
                                                                            type: 'POST',
                                                                            data: {
                                                                                action: 'update',
                                                                                product_id: productId,
                                                                                quantity: newQuantity
                                                                            },
                                                                            success: function (response) {
                                                                                // Cập nhật tổng tiền giỏ hàng
                                                                                console.log("Final Total Received:", response.finalTotal);
                                                                                cartTotal = response.finalTotal || response.total;
                                                                                updateInvoice();
                                                                            },
                                                                            error: function () {
                                                                                alert('Có lỗi xảy ra khi cập nhật giỏ hàng');
                                                                            }
                                                                        });
                                                                    }

                                                                    function updateInvoice() {
                                                                        // Cập nhật tổng đơn hàng
                                                                        $('#subtotal').text(cartTotal.toLocaleString() + ' VNĐ');

                                                                        // Cập nhật tổng tiền cuối (sau giảm giá)
                                                                        $('#total').text(cartTotal.toLocaleString() + ' VNĐ');

                                                                        // Nếu có ô tổng tiền ở header hoặc nơi khác, cập nhật luôn
                                                                        $('#total_amount').text(cartTotal.toLocaleString() + ' VNĐ');
                                                                    }
            </script>
            <script>
                function changeQty(button, productId, delta, price) {
                    const input = button.parentElement.querySelector('input[name="quantity"]');
                    let current = parseInt(input.value);
                    const min = parseInt(input.min) || 1;
                    const max = parseInt(input.max) || 100;

                    let newValue = current + delta;
                    if (newValue < min)
                        newValue = min;
                    if (newValue > max)
                        newValue = max;

                    input.value = newValue;
                    updateQuantity(productId, newValue, price);
                }
            </script>

    </body>
</html>