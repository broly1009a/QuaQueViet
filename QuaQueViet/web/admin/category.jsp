<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

        <style>
            /* Thu nhỏ và căn giữa cột TT */
            #sampleTable th:first-child,
            #sampleTable td:first-child {
                width: 40px;
                text-align: center;
                padding: 8px 4px;
                vertical-align: middle;
            }
        </style>
    </head>
    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <ul class="app-nav">
                <li>
                    <a class="app-nav__item" href="dashboard">
                        <i class='bx bx-log-out bx-rotate-180'></i>
                    </a>
                </li>
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
                <li><a class="app-menu__item" href="dashboard">
                        <i class='app-menu__icon bx bx-tachometer'></i>
                        <span class="app-menu__label">Bảng thống kê</span>
                    </a></li>
                <li><a class="app-menu__item" href="categorymanager">
                        <i class='app-menu__icon bx bxs-category'></i>
                        <span class="app-menu__label">Quản lý danh mục</span>
                    </a></li>
                <li><a class="app-menu__item" href="productmanager">
                        <i class='app-menu__icon bx bx-purchase-tag-alt'></i>
                        <span class="app-menu__label">Quản lý sản phẩm</span>
                    </a></li>
                <li><a class="app-menu__item" href="ordermanager">
                        <i class='app-menu__icon bx bx-task'></i>
                        <span class="app-menu__label">Quản lý đơn hàng</span>
                    </a></li>
                    <c:if test="${sessionScope.user.isAdmin}">
                    <li><a class="app-menu__item" href="customermanager">
                            <i class='app-menu__icon bx bx-user-voice'></i>
                            <span class="app-menu__label">Quản lý khách hàng</span>
                        </a></li>
                    <li><a class="app-menu__item" href="reportmanager">
                            <i class='app-menu__icon bx bx-receipt'></i>
                            <span class="app-menu__label">Quản lý phản hồi</span>
                        </a></li>
                    <li><a class="app-menu__item" href="aboutmanager">
                            <i class='app-menu__icon bx bx-receipt'></i>
                            <span class="app-menu__label">Quản lý trang giới thiệu</span>
                        </a></li>
                    <li><a class="app-menu__item" href="commentmanager">
                            <i class='app-menu__icon bx bx-receipt'></i>
                            <span class="app-menu__label">Quản lý bình luận</span>
                        </a></li>
                    <li><a class="app-menu__item" href="saleoff">
                            <i class='app-menu__icon bx bx-receipt'></i>
                            <span class="app-menu__label">Quản lý sale</span>
                        </a></li>
                    </c:if>
            </ul>
        </aside>

        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách danh mục</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm print-file" type="button" title="In"
                                       onclick="myApp.printTable()">
                                        <i class="fas fa-print"></i> In dữ liệu
                                    </a>
                                </div>
                                <div>
                                    <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#adddanhmuc">
                                        <i class="fas fa-folder-plus"></i> Thêm danh mục
                                    </a>
                                </div>
                            </div>

                            <table id="sampleTable" class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th>TT</th>
                                        <th>ID danh mục</th>
                                        <th>Tên danh mục</th>
                                        <th>Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${category}" var="c">
                                        <tr>
                                            <td></td>
                                            <td>${c.category_id}</td>
                                            <td>${c.category_name}</td>
                                            <td>
                                                <button class="btn btn-primary btn-sm edit" type="button"
                                                        data-toggle="modal"
                                                        data-target="#ModalEditCategory${c.category_id}"
                                                        title="Sửa">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-primary btn-sm trash" type="button"
                                                        title="Xóa"
                                                        value="${c.category_id}">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    <div class="modal fade" id="ModalEditCategory${c.category_id}" tabindex="-1"
                                         role="dialog" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <form action="categorymanager" method="POST" class="update-category-form">
                                                        <input type="hidden" name="action" value="updatecategory">
                                                        <div class="form-group">
                                                            <h5>Chỉnh sửa danh mục</h5>
                                                        </div>
                                                        <c:if test="${not empty requestScope.error && requestScope.openEditModalId == c.category_id}">
                                                            <p style="color: red; font-weight: bold;">${requestScope.error}</p>
                                                        </c:if>
                                                        <div class="form-group">
                                                            <label>ID</label>
                                                            <input class="form-control" type="text" readonly
                                                                   name="category_id"
                                                                   value="${c.category_id}">
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Tên danh mục</label>
                                                            <!-- ✅ Cách đúng để giữ lại giá trị nhập nếu lỗi -->
                                                            <c:choose>
                                                                <c:when test="${requestScope.openEditModalId == c.category_id && not empty requestScope.inputCategoryName}">
                                                                    <input class="form-control" type="text"
                                                                           name="category_name"
                                                                           value="${requestScope.inputCategoryName}">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <input class="form-control" type="text"
                                                                           name="category_name"
                                                                           value="${c.category_name}">
                                                                </c:otherwise>
                                                            </c:choose>

                                                        </div>
                                                </div>
                                                <button class="btn btn-save" type="submit">Lưu lại</button>s
                                                <a class="btn btn-cancel" data-dismiss="modal" href="#">
                                                    Hủy bỏ
                                                </a>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                            </div>

                        </c:forEach>

                        </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>

    </main>

    <!-- Modal thêm danh mục -->
    <div class="modal fade" id="adddanhmuc" tabindex="-1" role="dialog"
         data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="form-group">
                        <h5>Thêm mới danh mục</h5>
                    </div>
                    <c:if test="${not empty error}">
                        <h2 style="color:red;">${error}</h2>
                    </c:if>
                    <form action="categorymanager?action=insertcategory" method="post">
                        <input class="form-control" type="text" name="name" required>
                        <br>
                        <button class="btn btn-save" type="submit">Lưu lại</button>
                        <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                    </form>
                    <div class="form-group">
                        <label>Danh mục sản phẩm hiện đang có</label>
                        <ul style="padding-left:20px;">
                            <c:forEach items="${CategoryData1}" var="cat">
                                <li>${cat.category_name}</li>
                                </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JS libs -->
    <script src="admin/js/jquery-3.2.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script src="admin/js/popper.min.js"></script>
    <script src="admin/js/bootstrap.min.js"></script>
    <script src="admin/js/main.js"></script>
    <script src="admin/js/plugins/pace.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
    <!-- DataTables plugin -->
    <script src="admin/js/plugins/jquery.dataTables.min.js"></script>
    <script src="admin/js/plugins/dataTables.bootstrap.min.js"></script>

    <script>
                                           jQuery(document).ready(function () {
                                               // Khởi tạo DataTable với TT tự động
                                               if (!jQuery.fn.DataTable.isDataTable('#sampleTable')) {
                                                   jQuery('#sampleTable').DataTable({
                                                       columnDefs: [
                                                           {
                                                               targets: 0,
                                                               orderable: false,
                                                               searchable: false,
                                                               render: function (data, type, row, meta) {
                                                                   return meta.row + meta.settings._iDisplayStart + 1;
                                                               }
                                                           }
                                                       ],
                                                       order: [[1, 'asc']]
                                                   });
                                               }
                                               // Xóa
                                               jQuery(document).on('click', '.trash', function () {
                                                   var categoryId = jQuery(this).attr("value");
                                                   swal({
                                                       title: "Cảnh báo",
                                                       text: "Bạn có chắc chắn là muốn xóa danh mục này?",
                                                       buttons: ["Hủy bỏ", "Đồng ý"],
                                                   }).then((willDelete) => {
                                                       if (willDelete) {
                                                           window.location = "categorymanager?action=delete&category_id=" + categoryId;
                                                           swal("Đã xóa thành công!", {icon: "success"});
                                                       }
                                                   });
                                               });
                                           });
                                           // Thời gian
                                           function time() {
                                               var today = new Date();
                                               var weekday = ["Chủ Nhật", "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy"];
                                               var day = weekday[today.getDay()];
                                               var dd = today.getDate(), mm = today.getMonth() + 1, yyyy = today.getFullYear();
                                               var h = today.getHours(), m = today.getMinutes(), s = today.getSeconds();
                                               m = (m < 10 ? "0" + m : m);
                                               s = (s < 10 ? "0" + s : s);
                                               if (dd < 10)
                                                   dd = '0' + dd;
                                               if (mm < 10)
                                                   mm = '0' + mm;
                                               var nowTime = h + " giờ " + m + " phút " + s + " giây";
                                               var dateStr = day + ', ' + dd + '/' + mm + '/' + yyyy;
                                               document.getElementById("clock").innerHTML = '<span class="date"> ' + dateStr + ' - ' + nowTime + '</span>';
                                               setTimeout(time, 1000);
                                           }
                                           // In dữ liệu
                                           var myApp = new function () {
                                               this.printTable = function () {
                                                   var tab = document.getElementById('sampleTable');
                                                   var win = window.open('', '', 'height=700,width=700');
                                                   win.document.write(tab.outerHTML);
                                                   win.document.close();
                                                   win.print();
                                               }
                                           }
    </script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Validate thêm mới
            const insertForm = document.querySelector("#adddanhmuc form");
            if (insertForm) {
                insertForm.addEventListener("submit", function (e) {
                    const nameInput = insertForm.querySelector('input[name="name"]');
                    if (!nameInput.value.trim()) {
                        e.preventDefault();
                        swal("Lỗi", "Vui lòng nhập tên danh mục hợp lệ (không để trống hoặc chỉ khoảng trắng)!", "error");
                    }
                });
            }

            // Validate cập nhật danh mục
            const updateForms = document.querySelectorAll('.update-category-form');
            updateForms.forEach(form => {
                form.addEventListener("submit", function (e) {
                    const input = form.querySelector('input[name="category_name"]');
                    if (!input.value.trim()) {
                        e.preventDefault();
                        swal("Lỗi", "Tên danh mục không được để trống hoặc chỉ chứa khoảng trắng!", "error");
                    }
                });
            });
        });
    </script>
    <c:if test="${not empty requestScope.openEditModalId}">
        <script>
            $(document).ready(function () {
                const modalId = "#ModalEditCategory${requestScope.openEditModalId}";
                console.log("Mở lại modal:", modalId);
                $(modalId).modal('show');
            });
        </script>
    </c:if>
    <c:if test="${showAddModal == true}">
        <script>
            $(document).ready(function () {
                $('#adddanhmuc').modal('show');
            });
        </script>
    </c:if>

</body>
</html>
