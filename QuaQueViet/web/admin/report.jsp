<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách danh mục sản phẩm | Quản trị Admin</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="admin/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">

        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
    </head>
    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">
                <!-- User Menu-->
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
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách phản hồi</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <!-- Hiển thị thông báo thành công -->
                        <!-- Hiển thị thông báo thành công -->
                        <c:if test="${not empty message}">
                            <script>
                                swal({
                                    title: "Thông báo",
                                    text: "${message}",
                                    icon: "success",
                                    button: "Đóng"
                                });
                            </script>
                        </c:if>


                        <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0" id="sampleTable">
                            <thead>
                                <tr>
                                    <th>Số thứ tự</th> <!-- Cột số thứ tự -->
                                    
                                    <th>Email khách hàng</th>
                                    <th>Tiêu đề phản hồi</th>
                                    <th>Nội dung phản hồi</th>
                                    <th>Nội dung đã phản hồi</th>
                                    <th>Chức năng</th>
                                </tr>
                            </thead>

                            <!-- Bảng danh sách phản hồi -->
                            <tbody>
                                <c:forEach items="${sessionScope.Reports}" var="u" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td> <!-- Cột số thứ tự -->
                                       
                                        <td>${u.user_email}</td>
                                        <td>${u.subject_report}</td>
                                        <td>${u.content_report}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${empty u.admin_reply}">
                                                    <span style="color: red; font-weight: bold;">Chưa có phản hồi</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: green; font-weight: bold;">${u.admin_reply}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <button class="btn btn-primary btn-sm trash" type="button" title="Xóa" value="${u.id_report}">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                            <button class="btn btn-success btn-sm reply-btn" type="button" title="Trả lời" data-id="${u.id_report}">
                                                Trả Lời
                                            </button>
                                            <!-- Form trả lời admin -->
                                            <div class="reply-form" id="reply-form-${u.id_report}" style="display:none; margin-top:10px;">
                                                <form action="reportmanager" method="post">
                                                    <input type="hidden" name="action" value="reply" />
                                                    <input type="hidden" name="id_report" value="${u.id_report}" />
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

    <!-- Essential javascripts for application to work-->
    <script src="admin/js/jquery-3.2.1.min.js"></script>
    <script src="admin/js/popper.min.js"></script>
    <script src="admin/js/bootstrap.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="admin/js/main.js"></script>
    <!-- The javascript plugin to display page loading on top-->
    <script src="admin/js/plugins/pace.min.js"></script>
    <!-- Page specific javascripts-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
    <!-- Data table plugin-->
    <script type="text/javascript" src="admin/js/plugins/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="admin/js/plugins/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript">$('#sampleTable').DataTable();</script>
    <script>
        jQuery(document).ready(function () {
            // Event delegation for delete buttons
            jQuery(document).on('click', '.trash', function () {
                var reportId = $(this).attr("value");
                swal({
                    title: "Cảnh báo",
                    text: "Bạn có chắc chắn là muốn xóa phản hồi này?",
                    buttons: ["Hủy bỏ", "Đồng ý"],
                }).then((willDelete) => {
                    if (willDelete) {
                        window.location = "reportmanager?action=delete&id_report=" + reportId;
                        swal("Đã xóa thành công!", {
                            icon: "success",
                        });
                    }
                });
            });
        });

        //Thời Gian
        function time() {
            var today = new Date();
            var weekday = new Array(7);
            weekday[0] = "Chủ Nhật";
            weekday[1] = "Thứ Hai";
            weekday[2] = "Thứ Ba";
            weekday[3] = "Thứ Tư";
            weekday[4] = "Thứ Năm";
            weekday[5] = "Thứ Sáu";
            weekday[6] = "Thứ Bảy";
            var day = weekday[today.getDay()];
            var dd = today.getDate();
            var mm = today.getMonth() + 1;
            var yyyy = today.getFullYear();
            var h = today.getHours();
            var m = today.getMinutes();
            var s = today.getSeconds();
            m = checkTime(m);
            s = checkTime(s);
            nowTime = h + " giờ " + m + " phút " + s + " giây";
            if (dd < 10) {
                dd = '0' + dd
            }
            if (mm < 10) {
                mm = '0' + mm
            }
            today = day + ', ' + dd + '/' + mm + '/' + yyyy;
            tmp = '<span class="date"> ' + today + ' - ' + nowTime +
                    '</span>';
            document.getElementById("clock").innerHTML = tmp;
            clocktime = setTimeout("time()", "1000", "Javascript");

            function checkTime(i) {
                if (i < 10) {
                    i = "0" + i;
                }
                return i;
            }
        }

    </script>
    <script>
        $(document).ready(function () {
            $(".reply-btn").click(function () {
                var id = $(this).data("id");
                $("#reply-form-" + id).toggle();
            });
        });
    </script>

</body>
</html>
