<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Danh sách bình luận | Quản trị Admin</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="admin/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <style>
            /* Đảm bảo form trả lời ban đầu bị ẩn */
            .reply-form {
                display: none;
            }
        </style>
    </head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


    <body class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <ul class="app-nav">
                <li><a class="app-nav__item" href="dashboard"><i class='bx bx-log-out bx-rotate-180'></i> </a></li>
            </ul>
        </header>

        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user">
                <img class="app-sidebar__user-avatar" src="admin/images/user.png" width="50px" alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>${sessionScope.user.user_name}</b></p>
                    <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item" href="dashboard"><i class='app-menu__icon bx bx-tachometer'></i><span class="app-menu__label">Bảng thống kê</span></a></li>
                <li><a class="app-menu__item" href="categorymanager"><i class='app-menu__icon bx bxs-category'></i><span class="app-menu__label">Quản lý danh mục</span></a></li>
                <li><a class="app-menu__item" href="productmanager"><i class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a></li>
                <li><a class="app-menu__item" href="ordermanager"><i class='app-menu__icon bx bx-task'></i><span class="app-menu__label">Quản lý đơn hàng</span></a></li>
                            <c:if test="${sessionScope.user.isAdmin}">
                    <li><a class="app-menu__item" href="customermanager"><i class='app-menu__icon bx bx-user-voice'></i><span class="app-menu__label">Quản lý khách hàng</span></a></li>
                    <li><a class="app-menu__item" href="reportmanager"><i class='app-menu__icon bx bx-receipt'></i><span class="app-menu__label">Quản lý phản hồi</span></a></li>
                    <li><a class="app-menu__item" href="aboutmanager"><i class='app-menu__icon bx bx-receipt'></i><span class="app-menu__label">Quản lý trang giới thiệu</span></a></li>
                    <li><a class="app-menu__item" href="commentmanager"><i class='app-menu__icon bx bx-receipt'></i><span class="app-menu__label">Quản lý bình luận</span></a></li>
                    <li><a class="app-menu__item" href="saleoff"><i class='app-menu__icon bx bx-receipt'></i><span class="app-menu__label">Quản lý sale</span></a></li>
                            </c:if>
            </ul>
        </aside>

        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách bình luận</b></a></li>
                </ul>
            </div>
            <c:if test="${not empty sessionScope.replySuccess}">
                <div class="alert alert-success">
                    ${sessionScope.replySuccess}
                </div>
                <c:remove var="replySuccess"/>
            </c:if>


            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <form method="get" action="commentmanager">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="ratingFilter">Lọc theo đánh giá</label>
                                        <select name="ratingFilter" id="ratingFilter" class="form-control" onchange="this.form.submit()">
                                            <option value="">Tất cả</option>
                                            <option value="5">5 sao</option>
                                            <option value="4">4 sao</option>
                                            <option value="3">3 sao</option>
                                            <option value="2">2 sao</option>
                                            <option value="1">1 sao</option>
                                            <option value="0">0 sao</option>
                                        </select>
                                    </div>
                                </div>
                            </form>

                            <table class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th>Số thứ tự</th> <!-- Added the serial number column -->

                                        <th>Product_ID</th>
                                        <th>User Name</th>
                                        <th>Đánh giá</th>
                                        <th>Nội dung bình luận</th>
                                        <th>Nội dung trả lời bình luận</th>
                                        <th>Ngày</th>
                                        <th width="150">Tính năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${comment}" var="c" varStatus="status">
                                        <tr>
                                            <!-- Display serial number -->
                                            <td>${status.index + 1}</td> <!-- Serial number column -->

                                            <td>${c.productId}</td>
                                            <td>${c.user_name}</td>
                                            <td>${c.rating}</td>
                                            <td>${c.comment}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${empty c.admin_reply}">
                                                        <span style="color: red; font-weight: bold;">Chưa có phản hồi</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: green; font-weight: bold;">${c.admin_reply}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td><fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy"/></td>
                                            <td>
                                                <!-- Xóa bình luận -->
                                                <button class="btn btn-danger btn-sm" type="button" value="${c.id}" onclick="deleteComment(${c.id})">
                                                    <i class="fas fa-trash-alt"></i> Xóa
                                                </button>
                                                <!-- Trả lời bình luận -->
                                                <button class="btn btn-success btn-sm reply-btn" type="button" title="Trả lời" data-id="${c.id}">
                                                    Trả Lời
                                                </button>

                                                <!-- Form trả lời admin -->
                                                <div class="reply-form" id="reply-form-${c.id}" style="display:none; margin-top:10px;">
                                                    <form action="commentmanager" method="post">
                                                        <input type="hidden" name="action" value="reply" />
                                                        <input type="hidden" name="comment_id" value="${c.id}" />
                                                        <textarea name="admin_reply" class="form-control" rows="2" placeholder="Nhập nội dung phản hồi..."></textarea>
                                                        <button type="submit" class="btn btn-info btn-sm mt-2">Gửi phản hồi</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${not empty requestScope.msgc}">
                                    <div style="margin-top: 10px; color: green; font-weight: bold;">
                                        ${requestScope.msgc}
                                    </div>
                                </c:if>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script>
            // Hiển thị/Ẩn form trả lời khi nhấn nút "Trả Lời"
            function showReplyForm(commentId) {
                var replyForm = document.getElementById(`reply-form-${commentId}`);
                if (replyForm) {
                    // Kiểm tra nếu form trả lời đang ẩn thì hiển thị
                    if (replyForm.style.display === 'none' || replyForm.style.display === '') {
                        replyForm.style.display = 'block'; // Hiển thị form trả lời
                    } else {
                        replyForm.style.display = 'none'; // Ẩn form trả lời
                    }
                }
            }

            // Xóa bình luận
            function deleteComment(commentId) {
                swal({
                    title: "Cảnh báo",
                    text: "Bạn có chắc chắn muốn xóa bình luận này?",
                    buttons: ["Hủy bỏ", "Đồng ý"],
                }).then((willDelete) => {
                    if (willDelete) {
                        window.location = "commentmanager?action=delete&comment_id=" + commentId;
                        swal("Đã xóa thành công!", {icon: "success"});
                    }
                });
            }

        </script>
        <script>
            $(document).ready(function () {
                $(".reply-btn").click(function () {
                    var id = $(this).data("id");
                    var replyForm = $("#reply-form-" + id);
                    replyForm.toggle(); // Toggles visibility
                });
            });

        </script>
    </body>

</html>
