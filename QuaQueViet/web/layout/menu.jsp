<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <style>
                a {
                    text-decoration: none !important;
                }

                .canvas_open a,
                .canvas_close a,
                .dropdown_links a,
                .top_links a,
                .cart_link a,
                .offcanvas_footer a,
                .header_top a,
                .header_middel a,
                .main_menu a {
                    text-decoration: none !important;
                }

                /* Make specific menu items and links larger */
                .header_top .top_links a,
                .main_menu a,
                .cart_link a {
                    font-size: 18px !important;
                    /* Increase the font size */
                    font-weight: 600;
                    /* Make the text bolder */
                }

                .main_menu a {
                    font-size: 22px;
                    /* For the main menu items like "Trang chủ", "Sản phẩm", etc. */
                    font-weight: bold;
                }

                .cart_link a,
                .header_top .top_links a {
                    font-size: 20px;
                    /* Make cart and login links larger */
                }

                /* Larger font for "Trang chủ", "Sản phẩm", etc. */
                .header_bottom .main_menu_inner ul li a {
                    font-size: 24px !important;
                    font-weight: bold;
                    text-transform: uppercase;
                }

                /* Adjust the size of links on hover */
                .header_bottom .main_menu_inner ul li a:hover {
                    font-size: 26px;
                    /* Slightly increase the font size when hovering */
                    color: #e74c3c;
                    /* Optional: Change color on hover */
                }

                /* Increase the font size for the off-canvas menu items */
                .offcanvas_menu .offcanvas_main_menu li a {
                    font-size: 22px;
                    font-weight: bold;
                }

                /* Specific styles for header text */
                .header_top .welcome_text ul li {
                    font-size: 16px;
                }

                /* Cart and Login button */
                .cart_area .cart_link a {
                    font-size: 22px !important;
                    font-weight: bold;
                }

                /* Ensure "Đăng nhập" matches "Giỏ hàng" font size */
                .header_top .top_links a:contains('Đăng nhập') {
                    font-size: 22px;
                    /* Same size as the cart link */
                    font-weight: bold;
                }
            </style>

            <div class="offcanvas_menu">
                <div class="canvas_open">
                    <a href="javascript:void(0)"><i class="ion-navicon"></i></a>
                </div>
                <div class="offcanvas_menu_wrapper">
                    <div class="canvas_close">
                        <a href="javascript:void(0)"><i class="ion-android-close"></i></a>
                    </div>
                    <div class="welcome_text">
                    </div>
                    <div class="top_right">
                        <ul>
                            <li class="top_links"><a href="#">Tài Khoản của tôi <i class="ion-chevron-down"></i></a>
                                <ul class="dropdown_links">
                                    <c:if test="${sessionScope.user.user_name!=null}">
                                        <li><a href="my-account.html">${sessionScope.user.user_name}</a></li>
                                    </c:if>

                                    <c:if test="${sessionScope.user.user_name == null}">
                                        <li><a href="user?action=myaccount">Tài khoản của tôi</a></li>
                                    </c:if>

                                    <c:if test="${sessionScope.user == null}">
                                        <li><a href="user?action=login">Đăng nhập</a></li>
                                    </c:if>

                                    <c:if test="${sessionScope.user != null}">
                                        <li><a href="user?action=login">Đăng xuất</a></li>
                                    </c:if>

                                    <c:if
                                        test="${fn:toUpperCase(sessionScope.user.isAdmin) == 'TRUE' || fn:toUpperCase(sessionScope.user.isStoreStaff) == 'TRUE'}">
                                        <li><a href="dashboard">Quản lý</a></li>
                                    </c:if>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="search_bar">
                        <form action="search?action=search" method="POST">
                            <input name="text" placeholder="Tìm kiếm..." type="text">
                            <button type="submit"><i class="ion-ios-search-strong"></i></button>
                        </form>
                    </div>
                    <div class="cart_area">
                        <div class="cart_link">
                            <c:if test="${!user.isAdmin == 'True' && !user.isStoreStaff=='True'}">
                                <a href="cart?action=showcart"><i
                                        class="fa fa-shopping-basket">${sessionScope.size}</i>Giỏ Hàng</a>
                            </c:if>
                        </div>
                    </div>
                    <div id="menu" class="text-left ">
                        <ul class="offcanvas_main_menu">
                            <li class="active">
                                <a href="home" style="text-decoration: none">Trang chủ</a>
                            </li>
                            <li class="active">
                                <a href="product">Sản phẩm</a>

                            </li>
                            <li class="menu-item-has-children">
                                <a href="about">Chúng tôi</a>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="contact">Liên hệ</a>
                            </li>
                        </ul>
                    </div>
                    <div class="offcanvas_footer">
                        <span>
                            <a href="mailto:Quaqueviet@gmail.com">
                                <i class="fa fa-envelope-o"></i>Quaqueviet@gmail.com
                            </a>
                        </span>
                        <span style="display:block; margin-top:8px;">
                            <a href="tel:0962525995">
                                <i class="fa fa-phone"></i> 0962525995
                            </a>
                        </span>
                        <ul>
                            <li class="facebook">
                                <a href="https://www.facebook.com/share/16rvP7Ge2w/?mibextid=wwXIfr" target="_blank">
                                    <i class="fab fa-facebook"></i>
                                </a>
                            </li>
                            <!-- Có thể giữ lại các mạng xã hội khác nếu muốn -->
                            <li class="twitter"><a href="#"><i class="fab fa-twitter"></i></a></li>
                            <li class="pinterest"><a href="#"><i class="fab fa-pinterest-p"></i></a></li>
                            <li class="google-plus"><a href="#"><i class="fab fa-google-plus"></i></a></li>
                            <li class="linkedin"><a href="#"><i class="fab fa-linkedin"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--Offcanvas menu area end-->

            <!--header area start-->
            <header class="header_area header_three">
                <!--header top start-->
                <div class="header_top">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col-lg-7 col-md-12">
                            </div>
                            <div class="col-lg-5 col-md-12">
                                <div class="top_right text-right">
                                    <ul>

                                        <c:if test="${sessionScope.user != null}">
                                            <li class="top_links"><a href="#">Xin chào ${sessionScope.user.user_name}<i
                                                        class="ion-chevron-down"></i></a>
                                        </c:if>
                                        <c:if test="${sessionScope.user == null}">
                                            <li><a href="user?action=login">Đăng nhập<i></i></a>
                                        </c:if>
                                        <c:if test="${sessionScope.user == null}">
                                            <li><a href="register.jsp">Đăng kí<i></i></a>
                                        </c:if>
                                        <ul class="dropdown_links">
                                            <c:if test="${sessionScope.user != null}">
                                                <li><a href="user?action=myaccount">Tài khoản của tôi</a></li>
                                            </c:if>

                                            <c:if
                                                test="${fn:toUpperCase(sessionScope.user.isAdmin) == 'TRUE' || fn:toUpperCase(sessionScope.user.isStoreStaff) == 'TRUE'}">
                                                <li><a href="dashboard">Quản lý</a></li>
                                            </c:if>



                                            <c:if test="${sessionScope.user != null}">
                                                <li><a href="user?action=logout">Đăng xuất</a></li>
                                            </c:if>


                                        </ul>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--header top start-->

                <!--header middel start-->
                <div class="header_middel">
                    <div class="container-fluid">
                        <div class="middel_inner">
                            <div class="row align-items-center">
                                <div class="col-lg-4">
                                    <div class="search_bar">
                                        <form action="search?action=search" method="POST">
                                            <input name="text" placeholder="Tìm kiếm..." type="text">
                                            <button type="submit"><i class="ion-ios-search-strong"></i></button>
                                        </form>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="logo">
                                        <a "><img src=" assets/img/logo/shopofLinh.jpg" alt="" width="200px"></a>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="cart_area">
                                        <div class="cart_link">
                                            <c:if
                                                test="${sessionScope.user != null &&!user.isAdmin == 'True' && !user.isStoreStaff=='True'}">
                                                <a href="cart?action=showcart"><i
                                                        class="fa fa-shopping-basket"></i>${sessionScope.size} Giỏ
                                                    hàng</a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="horizontal_menu">
                            <div class="left_menu">
                                <div class="main_menu">
                                    <nav>
                                        <ul>
                                            <li><a href="home">Trang chủ<i class="fa"></i></a>
                                            </li>
                                            <li class="mega_items"><a href="product">Sản phẩm</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <div class="right_menu">
                                <div class="main_menu">
                                    <nav>
                                        <ul>
                                            <li><a href="about">Chúng tôi</a></li>
                                            <li><a href="contact">Liên hệ</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--header middel end-->

                <!--header bottom satrt-->
                <div class="header_bottom sticky-header">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-12">
                                <div class="main_menu_inner">
                                    <div class="main_menu">
                                        <nav>
                                            <ul>
                                                <li class="active"><a href="home">Trang chủ</a></li>
                                                <li><a href="product">Sản phẩm</a></li>
                                                <li><a href="about">Chúng tôi</a></li>
                                                <li><a href="contact">Liên hệ</a></li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--header bottom end-->
            </header>