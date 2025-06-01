<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Thông Tin Sản Phẩm  |  Quà Quê Việt</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

        <!-- CSS -->
        <!-- Plugins CSS -->
        <link rel="stylesheet" href="assets/css/plugins.css">
        <!-- Main Style CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>
    </head>
    <style>.product-buttons {
            display: flex;
            gap: 10px;
        }

        .button {
            display: inline-block;
            padding: 10px 20px;  /* Adjust padding as needed */
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            white-space: nowrap;  /* Prevent text wrapping */
        }

        .button:hover {
            background-color: #0056b3;
        }

        .button:active {
            background-color: #003d82;
        }

        .button-secondary {
            background-color: #28a745;
        }

        .button-secondary:hover {
            background-color: #218838;
        }

        .button-secondary:active {
            background-color: #1e7e34;
        }
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            color: #333;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }



        /* Product Name */
        h1 {
            font-size: 3em;
            margin-bottom: 20px;
            color: #2c3e50;
            font-weight: bold;
            text-align: center;
        }

        /* Product Price */
        .product_price {
            font-size: 1.5em;
            margin-bottom: 20px;
            color: #e74c3c;
            text-align: center;
            font-weight: bold;
        }
        .product_price label {
            font-weight: bold;
            color: #555;
        }
        .product_price .current_price {
            font-size: 2em;
            color: #e74c3c;
            font-weight: bold;
        }

        /* Product Description */
        .product_desc {
            margin-top: 20px;
            padding: 20px;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .product_desc label {
            display: block;
            font-size: 1.5em;
            font-weight: bold;
            color: #555;
            margin-bottom: 10px;
        }
        .product_desc p {
            margin: 0;
            font-size: 1.2em;
            color: #34495e;
            font-weight: bold;
        }

        .product_reviews {
            margin-top: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 5px;
        }
        .rating, .comment {
            margin-bottom: 15px;
            padding: 10px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
        }
        .rating p, .comment p {
            margin: 5px 0;
        }
    </style>
    <style>
        /* Form container style */
        .form-container {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        /* Form heading style */
        .form-container h3 {
            font-size: 1.5em;
            margin-bottom: 10px;
            color: #333;
        }

        /* Select input style for rating */
        .form-container select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            font-size: 1em;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }

        /* Textarea input style for comment */
        .form-container textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            font-size: 1em;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }

        /* Submit button style */
        .form-container button {
            padding: 10px 20px;
            font-size: 1em;
            font-weight: bold;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-container button:hover {
            background-color: #0056b3;
        }

        .form-container button:active {
            background-color: #003d82;
        }
        body {
            font-family: Arial, sans-serif;
        }

        .features-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-wrap: wrap;
        }

        .features-list li {
            flex: 1 1 calc(33.333% - 20px);
            box-sizing: border-box;
            padding: 20px;
            margin: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
        }

        .features-list .icon img {
            width: 50px;
            height: auto;
            margin-bottom: 10px;
        }

        .features-list .text {
            font-size: 14px;
        }

        .features-list .text strong {
            display: block;
            font-size: 16px;
            margin-bottom: 5px;
        }
        .size-selection-container {
            display: flex;
            align-items: center;
            gap:250px;
        }

        #size {
            margin-right: 200px; /* Add a right margin of 200px to the select element */
        }

        #size-guide-link {
            text-decoration: underline; /* Underline the text */
            color: black;
            font-weight: bold;
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
        }

        #size-guide-link i {
            margin-right: 5px; /* Add some space between the icon and the text */
        }

        #size-guide-link:hover {
            color: orange;
        }
        #size-guide-popup {
            display: none;
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border: 1px solid black;
            z-index: 1000;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Add shadow for depth */
            width: 80%; /* Adjust width as needed */
            max-width: 600px; /* Set maximum width to avoid stretching on larger screens */
            text-align: center; /* Center align content */
        }

        #size-guide-popup h3 {
            font-size: 1.5em;
            margin-bottom: 10px;
            color: #333;
        }

        #size-guide-popup table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 10px;
        }

        #size-guide-popup table, #size-guide-popup th, #size-guide-popup td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        #size-guide-popup th {
            background-color: #f2f2f2;
        }

        #size-guide-popup p {
            margin-bottom: 10px;
            font-style: italic;
            color: #666;
        }

        #size-guide-popup button {
            padding: 10px 20px;
            font-size: 1em;
            font-weight: bold;
            color: white;
            background-color: black;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        #size-guide-popup button:hover {
            background-color: orange;
        }
        .star {
            color: gold; /* Màu vàng */
        }
        .product_thumb {
            position: relative;
            overflow: hidden;
            aspect-ratio: 1 / 1; /* Tạo khung hình vuông */
        }

        .product_thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Đảm bảo ảnh lấp đầy khung mà không bị méo */
            object-position: center; /* Căn giữa ảnh trong khung */
        }

        .single_product {
            margin-bottom: 20px; /* Tạo khoảng cách giữa các sản phẩm */
        }
        a, a:hover, a:focus {
            text-decoration: none;
        }

        .product_content h3 a,
        .banner_content a,
        .slider_content a {
            text-decoration: none;
        }
        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.7);
        }

        .modal-content {
            position: relative;
            margin: 5% auto;
            padding: 20px;
            width: 80%;
            max-width: 700px;
            background: white;
            border-radius: 5px;
        }

        .modal-content img {
            width: 100%;
            height: auto;
            display: block;
        }

        .close {
            position: absolute;
            right: 15px;
            top: 5px;
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: black;
        }
        /* Base Styles */
        .product-detail-card {
            background: #fff;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .product-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .product-title {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin: 0;
            flex: 1;
        }

        .price-badge {
            background: #f8f8f8;
            padding: 5px 15px;
            border-radius: 20px;
            margin-left: 15px;
        }

        .price {
            font-size: 18px;
            font-weight: 700;
            color: #d82e2e;
        }

        .product-rating {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .stars {
            background: #fff4e5;
            color: #ff9500;
            padding: 3px 10px;
            border-radius: 20px;
            font-weight: 600;
            margin-right: 10px;
        }

        .stars i {
            color: #ff9500;
            font-size: 14px;
        }

        .rating-text {
            color: #666;
            font-size: 14px;
        }

        .product-description {
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .product-description h3 {
            font-size: 16px;
            color: #444;
            margin-bottom: 10px;
        }

        .product-description p {
            color: #666;
            line-height: 1.6;
            margin: 0;
        }

        /* Options */
        .product-options {
            margin-bottom: 25px;
        }

        .option-group {
            margin-bottom: 20px;
        }

        .option-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: #444;
        }

        .select-wrapper {
            position: relative;
            width: 100%;
            max-width: 300px;
        }

        .select-wrapper select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            appearance: none;
            background: #fff;
            font-size: 14px;
            cursor: pointer;
        }

        .select-wrapper i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
            color: #777;
        }

        .size-selector {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .size-guide-btn {
            background: none;
            border: none;
            color: #0066cc;
            font-size: 13px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .size-guide-btn:hover {
            text-decoration: underline;
        }

        .quantity-picker {
            display: flex;
            align-items: center;
            width: fit-content;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
        }

        .quantity-picker input {
            width: 50px;
            text-align: center;
            border: none;
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            padding: 10px 5px;
            font-size: 14px;
        }

        .qty-btn {
            background: #f8f8f8;
            border: none;
            width: 35px;
            height: 40px;
            font-size: 16px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .qty-btn:hover {
            background: #eee;
        }

        /* Buttons */
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .btn {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .add-to-cart {
            background: #333;
            color: white;
        }

        .add-to-cart:hover {
            background: #222;
        }

        .buy-now {
            background: #d82e2e;
            color: white;
        }

        .buy-now:hover {
            background: #c22525;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.7);
            animation: fadeIn 0.3s;
        }

        .modal-content {
            position: relative;
            background: white;
            margin: 5% auto;
            padding: 20px;
            width: 90%;
            max-width: 600px;
            border-radius: 10px;
            animation: slideUp 0.3s;
        }

        .modal-content img {
            width: 100%;
            border-radius: 5px;
        }

        .close {
            position: absolute;
            right: 20px;
            top: 15px;
            font-size: 28px;
            font-weight: bold;
            color: #aaa;
            cursor: pointer;
        }

        .close:hover {
            color: #333;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes slideUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        /* Ẩn spinner cho Chrome, Safari, Edge */
        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

    </style>

    <body>


        <!-- Main Wrapper Start -->
        <div class="off_canvars_overlay"></div>
        <jsp:include page="layout/menu.jsp"/>

        <!--breadcrumbs area start-->
        <div class="breadcrumbs_area product_bread">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="home">Trang chủ</a></li>
                                <li>/</li>
                                <li>Chi tiết sản phẩm</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--breadcrumbs area end-->

        <!--product details start-->
        <div class="product_details">
            <div class="container">
                <div class="row">
                    <div class="col-lg-5 col-md-5">
                        <div class="product-details-tab">
                            <div id="img-1" class="zoomWrapper single-zoom">
                                <a href="#">
                                    <img id="zoom1" src="${ProductData.img}" data-zoom-image="${ProductData.img}" alt="product">
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-7 col-md-7">
                        <div class="product-detail-card">
                            <form id="productForm" action="cart" method="POST">
                                <input type="hidden" name="action" value="addtocart">
                                <input type="hidden" name="product_id" value="${ProductData.product_id}">

                                <!-- Product Header -->
                                <div class="product-header">
                                    <h1 class="product-title">${ProductData.product_name}</h1>
                                    <div class="price-badge">
                                        <span class="price">${ProductData.product_price} VNĐ</span>
                                    </div>
                                </div>

                                <!-- Rating -->
                                <div class="product-rating">
                                    <span class="stars">
                                        <fmt:formatNumber value="${averageRating}" maxFractionDigits="1"/>
                                        <i class="fas fa-star"></i>
                                    </span>
                                    <span class="rating-text">Đánh giá trung bình</span>
                                </div>

                                <!-- Description -->
                                <div class="product-description">
                                    <h3>Mô tả sản phẩm</h3>
                                    <p>${ProductData.product_describe}</p>
                                </div>

<!--                                 Options 
                                <div class="product-options">
                                     Color Picker 
                                    <div class="option-group">
                                        <label>Màu sắc</label>
                                        <div class="select-wrapper">
                                            <select name="color" id="color">
                                                <c:forEach items="${ColorData}" var="c">
                                                    <option value="${c.color}">${c.color}</option>
                                                </c:forEach>
                                            </select>
                                            <i class="fas fa-chevron-down"></i>
                                        </div>
                                    </div>

                                     Size Picker 
                                    <div class="option-group">
                                        <label>Kích thước</label>
                                        <div class="size-selector">
                                            <div class="select-wrapper">
                                                <select name="size" id="size">
                                                    <c:forEach items="${SizeData}" var="s">
                                                        <option value="${s.size}">${s.size}</option>
                                                    </c:forEach>
                                                </select>
                                                <i class="fas fa-chevron-down"></i>
                                            </div>
                                            <button type="button" class="size-guide-btn" id="size-guide-link">
                                                <i class="fas fa-ruler"></i> Hướng dẫn size
                                            </button>
                                        </div>
                                    </div>-->

                                    <!-- Quantity -->
                                    <div class="option-group">
                                        <label>Số lượng</label>
                                        <div class="quantity-picker">
                                            <button type="button" class="qty-btn minus">-</button>
                                            <input type="number" name="quantity" value="1" min="1" max="${ProductData.quantity}">
                                            <button type="button" class="qty-btn plus">+</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="action-buttons">
                                    <button type="submit" class="btn add-to-cart">
                                        <i class="fas fa-shopping-cart" color="#76352"></i> Thêm vào giỏ
                                    </button>
                                    <button type="button" class="btn buy-now" onclick="setActionAndSubmit('buynow')">
                                        <i class="fas fa-bolt"></i> Mua ngay
                                    </button>
                                </div>
                            </form>
                        </div>


                    </div>
                    <ul class="features-list">
                        <li>
                            <div class="icon"><img src="images/freeship.jpg" alt="Freeship toàn quốc từ 399k"></div>
                            <div class="text">
                                <strong>Miễn phí vận chuyển</strong>

                            </div>
                        </li>
                        <li>
                            <div class="icon"><img src="images/box.png" alt="Theo dõi đơn hàng dễ dàng"></div>
                            <div class="text">
                                <strong>Theo dõi đơn hàng <br>một cách dễ dàng</strong>
                            </div>
                        </li>
                        <li>
                            <div class="icon"><img src="images/returngoods.jpg" alt="Đổi trả tận nơi"></div>
                            <div class="text">
                                <strong>Đổi trả linh hoạt</strong>
                                <p>Với sản phẩm không áp dụng khuyến mãi</p>
                            </div>
                        </li>
                        <li>
                            <div class="icon"><img src="images/pay.jpg" alt="Thanh toán dễ dàng"></div>
                            <div class="text">
                                <strong>Thanh toán dễ dàng <br>nhiều hình thức</strong>
                            </div>
                        </li>
                        <li>
                            <div class="icon"><img src="images/sp.jpg" alt="Hotline hỗ trợ Routine"></div>
                            <div class="text"><strong>Hotline hỗ trợ</strong>
                                <h3>0393314726</h3>
                        </li>
                    </ul>
                </div>
            </div>   
        </div>
        <!--product details end-->
        <!-- Form for adding rating -->

        <div class="form-container">
            <form action="comment" method="POST">
                <input type="hidden" name="action" value="addComment">
                <input type="hidden" name="product_id" value="${ProductData.product_id}">
                <input type="hidden" name="user_id" value="${user.user_id}">                
                <input type="hidden" name="user_name" value="${user.user_name}">  
                <h3>Đánh giá sản phẩm</h3>
                <select name="rating" id="star-rating">
                    <option value="1">1&#9733;</option>
                    <option value="2">2&#9733;&#9733;</option>
                    <option value="3">3&#9733;&#9733;&#9733;</option>
                    <option value="4">4&#9733;&#9733;&#9733;&#9733;</option>
                    <option value="5">5&#9733;&#9733;&#9733;&#9733;&#9733;</option>
                </select>
                <textarea name="comment" rows="4" cols="50" placeholder="Nhập bình luận của bạn"></textarea>
                <button type="submit">Gửi bình luận</button>
            </form>

            <!-- Hiển thị thông báo nếu có -->
            <c:if test="${not empty requestScope.message}">
                <div class="alert alert-success">${requestScope.message}</div>
            </c:if>
        </div>

        <c:if test="${not empty comments}">
            <div class="product_reviews">
                <h3>Đánh giá và Bình luận</h3>
                <c:forEach items="${comments}" var="c">
                    <div class="comment">
                        <p><strong>Người dùng:</strong> ${c.user_name}</p>
                        <p><strong>Đánh giá:</strong> 
                            <c:forEach begin="1" end="${c.rating}">
                                <i class="fas fa-star star"></i>
                            </c:forEach>
                        </p>
                        <p><strong>Thời gian:</strong> <fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/></p>

                        <p><strong>Bình luận:</strong> ${c.comment}</p>

                        <c:if test="${not empty c.admin_reply}">
                            <div style="margin-top: 10px; padding: 10px; background-color: #f1f1f1; border-left: 3px solid #007bff;">
                                <p><strong>Phản hồi từ Admin:</strong> ${c.admin_reply}</p>
                            </div>
                        </c:if>
                        <hr style="margin:20px 0;">
                    </div>
                </c:forEach>
            </div>
        </c:if>


        <!--product section area start-->
        <section class="product_section related_product">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="section_title">
                            <h2>Sản phẩm tương tự</h2>
                        </div>
                    </div>
                </div>
                <div class="product_area">
                    <div class="row">
                        <div class="product_carousel product_three_column4 owl-carousel">
                            <c:forEach items="${ProductByCategory}" var="pc">
                                <div class="col-lg-3">
                                    <div class="single_product">
                                        <div class="product_thumb">
                                            <a class="primary_img" href="product?action=productdetail&product_id=${pc.product_id}"><img src="${pc.img}" alt=""></a>
                                        </div>
                                        <div class="product_content">
                                            <h3><a href="product?action=productdetail&product_id=${pc.product_id}">${pc.product_name}</a></h3>
                                            <span class="current_price">${pc.product_price} VNĐ</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!--product section area end-->

        <!--footer area start-->
        <jsp:include page="layout/footer.jsp"/>
        <!--footer area end-->

        <!-- Plugins JS -->
        <script src="assets/js/plugins.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <!-- Main JS -->
        <script src="assets/js/main.js"></script>
        <script>
                                        function setActionAndSubmit(action) {
                                            document.querySelector('input[name="action"]').value = action;
                                            document.getElementById('productForm').submit();
                                        }

        </script>
        <div id="sizeGuideModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <img src="images/size.jpg" alt="Hướng dẫn chọn size">
            </div>
        </div>
        <script>
            // Lấy các phần tử DOM cần thiết
            const sizeGuideLink = document.getElementById('size-guide-link');
            const modal = document.getElementById('sizeGuideModal');
            const closeBtn = document.querySelector('.close');

            // Khi click vào link hướng dẫn size
            sizeGuideLink.addEventListener('click', function (e) {
                e.preventDefault();
                modal.style.display = 'block';
            });

            // Khi click vào nút đóng
            closeBtn.addEventListener('click', function () {
                modal.style.display = 'none';
            });

            // Khi click bất kỳ đâu ngoài modal, đóng modal
            window.addEventListener('click', function (event) {
                if (event.target == modal) {
                    modal.style.display = 'none';
                }
            });
        </script>
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
                var successMessage = "${sessionScope.successMessageAdd}";
                var errorMessage = "${sessionScope.errorMessage}";

                if (successMessage) {
                    showNotification(successMessage, true);
                    // Xóa thông báo khỏi session
            <% session.removeAttribute("successMessageAdd"); %>
                } else if (errorMessage) {
                    showNotification(errorMessage, false);
                    // Xóa thông báo khỏi session
            <% session.removeAttribute("errorMessage"); %>
                }
            });
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const minusBtn = document.querySelector(".qty-btn.minus");
                const plusBtn = document.querySelector(".qty-btn.plus");
                const quantityInput = document.querySelector('input[name="quantity"]');

                minusBtn.addEventListener("click", function () {
                    let current = parseInt(quantityInput.value);
                    if (current > 1) {
                        quantityInput.value = current - 1;
                    }
                });

                plusBtn.addEventListener("click", function () {
                    let current = parseInt(quantityInput.value);
                    let max = parseInt(quantityInput.max) || 99;
                    if (current < max) {
                        quantityInput.value = current + 1;
                    }
                });
            });
        </script>
    </body>
</html>