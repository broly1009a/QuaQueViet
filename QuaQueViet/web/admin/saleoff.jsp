<%-- 
    Document   : customer
    Created on : 16 thg 4, 2025, 15:34:18
    Author     : truon
--%>







<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setTimeZone value="Asia/Ho_Chi_Minh"/>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách nhân viên | Quản trị Admin</title>
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
    <style>
        .custom-modal{
            max-width: 1000px;
            width: 100%;
        }
    </style>

    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->nload="time()" class="app sidebar-mini rtl"
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">


                <!-- User Menu-->
                <li><a class="app-nav__item" href="home"><i class='bx bx-log-out bx-rotate-180'></i> </a>

                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="admin/images/user.png" width="50px"
                                                alt="User Image">
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

                <!-- Conditionally Display Menu Items -->
                <c:if test="${sessionScope.user.isAdmin}">
                    <li><a class="app-menu__item" href="customermanager"><i class='app-menu__icon bx bx-user-voice'></i><span class="app-menu__label">Quản lý khách hàng</span></a></li>
                    <li><a class="app-menu__item" href="reportmanager"><i class='app-menu__icon bx bx-receipt'></i><span class="app-menu__label">Quản lý phản hồi</span></a></li>
                    <li><a class="app-menu__item" href="aboutmanager"><i class='app-menu__icon bx bx-receipt'></i><span class="app-menu__label">Quản lý trang giới thiệu</span></a></li>
                    <li><a class="app-menu__item" href="commentmanager"><i class='app-menu__icon bx bx-receipt'></i><span class="app-menu__label">Quản lý bình luận</span></a></li>
                    <li><a class="app-menu__item" href="saleoff"><i class='app-menu__icon bx bx-receipt'></i><span class="app-menu__label">Quản lý sale</span></a></li>
                            </c:if>
            </ul>
        </aside>                 
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>

        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Quản Lý mã giảm giá</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <!-- Button to Add Sale Off -->
                            <div class="row mb-3">
                                <div class="col-md-12 text-right">
                                    <!-- Nút "Thêm Mới" để mở modal -->
                                    <!-- Nút "Thêm Mới" để mở Modal -->
                                    <button class="btn btn-success" data-toggle="modal" data-target="#addSaleModal">
                                        <i class="fa fa-plus"></i> Thêm Mới
                                    </button>

                                </div>
                            </div>

                            <!-- tìm kiếm -->
                            <form action="saleoff" method="get">
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label class="control-label">Mã sale</label>
                                        <input class="form-control" type="text" name="saleCode" value="${param.saleCode}">
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label class="control-label">Loại giảm giá</label>
                                        <select class="form-control" name="discountType">
                                            <option value="">Chọn Loại Giảm Giá</option>
                                            <option value="Percentage" ${param.discountType == 'Percentage' ? 'selected' : ''}>Phần Trăm(%)</option>
                                            <option value="Fixed" ${param.discountType == 'Fixed' ? 'selected' : ''}>Giá Tiền Cố Định(vnd) </option>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label class="control-label">sắp xếp giá trị giảm giá</label>
                                        <select class="form-control" name="sortDiscountValue">
                                            <option value="">Sắp Xếp Giá Trị Giảm Giá Theo Thứ Tự</option>
                                            <option value="desc" ${param.sortDiscountValue == 'desc' ? 'selected' : ''}>Cao đến thấp</option>
                                            <option value="asc" ${param.sortDiscountValue == 'asc' ? 'selected' : ''}>Thấp Đến Cao</option>
                                        </select>
                                    </div>
                                </div>
                                <button class="btn btn-primary" type="submit">Tìm kiếm</button>
                                <div>Note:</div>

                                <div>Percentage: giảm giá theo phần trăm(%)</div>

                                <div>Fixed: Giảm giá theo giá tiền cố định(vnd)</div>
                            </form>
                            <!-- tìm kiếm -->
                            <nav aria-label="Page navigation" style="margin-top: 20px; text-align: center;">
                                <ul class="pagination" style="display: inline-flex; padding-left: 0; list-style: none; border-radius: 5px;">
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li style="margin: 0 5px;" class="page-item ${i == pageIndex ? 'active' : ''}">
                                            <a class="page-link" href="saleoff?page=${i}&saleCode=${saleCode}&discountType=${discountType}&sortDiscountValue=${sortDiscountValue}" 
                                               style="padding: 8px 12px; border: 1px solid #dee2e6; border-radius: 5px; color: #007bff; text-decoration: none; background-color: ${i == pageIndex ? '#007bff' : '#fff'}; color: ${i == pageIndex ? '#fff' : '#007bff'};">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </nav>

                            <!-- Sale Off Table -->

                            <table border="1">
                                <tr>
                                    <th>Số thứ tự </th>
                                    <th>Sale ID</th>
                                    <th>Mã Giảm Giá</th>
                                    <th>loại Mã Giảm Giá  </th>
                                    <th>Số Tiền Giảm Giá </th>
                                    <th>Số Tiền Giảm Giá Tối Đa</th>
                                    <th>bắt đầu </th>
                                    <th>Kết Thúc</th>
                                    <th>Số Lượng</th>
                                    <th>Hành Động</th>
                                </tr>
                                <c:forEach var="saleOff" items="${saleOffs}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${saleOff.saleId}</td>
                                        <td>${saleOff.saleCode}</td>
                                        <td>${saleOff.discountType}</td>
                                        <td>
                                            ${saleOff.discountValue}
                                            <c:choose>
                                                <c:when test="${saleOff.discountType == 'Percentage' || saleOff.discountType == 'percentage'}">%</c:when>
                                                <c:otherwise> VND</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            ${saleOff.maxDiscount}
                                            <c:choose>
                                                <c:when test="${saleOff.discountType == 'Percentage' || saleOff.discountType == 'percentage'}">%</c:when>
                                                <c:otherwise> VND</c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>${saleOff.start_date}</td>
                                        <td>${saleOff.end_date}</td>
                                        <td>${saleOff.quantity}</td>
                                        <td>
                                            <!-- Nút sửa -->
                                            <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" 
                                                    id="show-emp" data-toggle="modal" 
                                                    data-target="#ModalUP${saleOff.saleId}">
                                                <i class="fas fa-edit"></i>
                                            </button>

                                            <!-- Nút xoá-->
                                            <button type="button"
                                                    class="btn btn-danger btn-sm delete-btn"
                                                    data-id="${saleOff.saleId}"
                                                    data-code="${saleOff.saleCode}">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </td>
                                    </tr>                                  
                                </c:forEach>
                            </table>
                            <!-- MODAL giảm giá -->
                            <c:forEach var="saleOff" items="${saleOffs}" varStatus="status">
                                <div class="modal fade" id="ModalUP${saleOff.saleId}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                     data-keyboard="false">
                                    <div class="modal-dialog custom-modal modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-body">
                                                <form action="saleoff" method="post">
                                                    <c:if test="${editId eq saleOff.saleId}">
                                                        <c:if test="${not empty errors}">
                                                            <div class="alert alert-danger mt-2">
                                                                <ul>
                                                                    <c:forEach var="error" items="${errors}">
                                                                        <li style="color: red">${error}</li>
                                                                        </c:forEach>
                                                                </ul>
                                                            </div>
                                                        </c:if>
                                                    </c:if>
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="saleId" value="${saleOff.saleId}">
                                                    <div class="row">
                                                        <div class="form-group  col-md-12">
                                                            <span class="thong-tin-thanh-toan">
                                                                <h5>Chỉnh sửa thông tin giảm giá</h5>
                                                            </span>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Sale id</label>
                                                            <input class="form-control" type="text" readonly name="saleId" value="${saleOff.saleId}">
                                                        </div>
                                                        <div class="form-group col-md-6">   
                                                            <label class="control-label">Mã Giảm Giá</label>
                                                            <input class="form-control" type="text"  name="saleCode" value="${saleOff.saleCode}">
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Loại Giảm Giá</label>
                                                            <select class="form-control" name="discountType">
                                                                <option value="Percentage" ${saleOff.discountType == 'Percentage' ? 'selected' : ''}>Theo Phần Trăm(%)  </option>
                                                                <option value="Fixed" ${saleOff.discountType == 'Fixed' ? 'selected' : ''}>Giảm Theo Số Tiền Cố Định(vnd)</option>
                                                            </select>
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Số Tiền Giảm Giá</label>
                                                            <input class="form-control" type="number"  name="discountValue" value="${saleOff.discountValue}">
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Số Tiền Giảm Giá Tối Đa</label>
                                                            <input class="form-control" type="number"  name="maxDiscount" value="${saleOff.maxDiscount}">
                                                        </div>
                                                        <fmt:formatDate value="${saleOff.start_date}" pattern="yyyy-MM-dd" var="formattedStartDate" />
                                                        <fmt:formatDate value="${saleOff.end_date}" pattern="yyyy-MM-dd" var="formattedEndDate" />

                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Bắt Đầu</label>
                                                            <input class="form-control" type="date" name="startDate" value="${formattedStartDate}">
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Kết Thúc</label>
                                                            <input class="form-control" type="date" name="endDate" value="${formattedEndDate}">
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Số lượng</label>
                                                            <input class="form-control" type="text" min="1" name="quantity" value="${saleOff.quantity}">
                                                        </div>
                                                    </div>
                                                    <BR>
                                                    <button class="btn btn-save" type="submit">Lưu lại</button>
                                                    <a class="btn btn-cancel" data-dismiss="modal" href="saleoff">Hủy bỏ</a>
                                                    <BR>
                                                </form> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <c:forEach var="saleOff" items="${saleOffs}" varStatus="status">
                                <!--
                               MODAL add
                                -->
                                <div class="modal fade" id="addSaleModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                     data-keyboard="false" aria-labelledby="addSaleModalLabel">
                                    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">

                                        <div class="modal-content p-4" style="border-radius: 20px;" >
                                            <div class="modal-body">
                                                <form action="saleoff" method="post">
                                                    <c:if test="${addFail}">
                                                        <c:if test="${not empty errors}">
                                                            <div class="alert alert-danger mt-2">
                                                                <ul style="color: red">
                                                                    <c:forEach var="error" items="${errors}">
                                                                        <li>${error}</li>
                                                                        </c:forEach>
                                                                </ul>
                                                            </div>
                                                        </c:if>
                                                    </c:if>
                                                    <input type="hidden" name="action" value="add">                                                  
                                                    <div>
                                                        <div class="form-group  col-md-12">
                                                            <span class="thong-tin-thanh-toan">
                                                                <h5>Thêm giảm giá</h5>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="row" >
                                                        <!-- Mã giảm giá -->
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Mã Giảm Giá</label>
                                                            <input class="form-control" type="text" name="saleCode"
                                                                   value="${sessionScope.inputSaleCode != null ? sessionScope.inputSaleCode : ''}">
                                                        </div>

                                                        <!-- Loại giảm giá -->
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Loại Giảm Giá</label>
                                                            <select class="form-control" name="discountType">
                                                                <option value="Percentage"
                                                                        ${sessionScope.inputDiscountType == 'Percentage' ? 'selected' : ''}>
                                                                    Giảm Theo Phần Trăm(%)
                                                                </option>
                                                                <option value="Fixed"
                                                                        ${sessionScope.inputDiscountType == 'Fixed' ? 'selected' : ''}>
                                                                    Giảm Theo Số Tiền Cố Định(vnd)
                                                                </option>
                                                            </select>
                                                        </div>

                                                        <!-- Số tiền giảm -->
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Số Tiền Giảm Giá</label>
                                                            <input class="form-control" type="text" name="discountValue"
                                                                   value="${sessionScope.inputDiscountValue != null ? sessionScope.inputDiscountValue : ''}">
                                                        </div>

                                                        <!-- Giảm tối đa -->
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Số Tiền Giảm Giá Tối Đa</label>
                                                            <input class="form-control" type="text" name="maxDiscount"
                                                                   value="${sessionScope.inputMaxDiscount != null ? sessionScope.inputMaxDiscount : ''}">
                                                        </div>

                                                        <!-- Ngày bắt đầu -->
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Bắt Đầu</label>
                                                            <input class="form-control" type="date" name="startDate"
                                                                   value="${sessionScope.inputStartDate != null ? sessionScope.inputStartDate : ''}" required="">
                                                        </div>

                                                        <!-- Ngày kết thúc -->
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Kết Thúc</label>
                                                            <input class="form-control" type="date" name="endDate"
                                                                   value="${sessionScope.inputEndDate != null ? sessionScope.inputEndDate : ''}" required="">
                                                        </div>

                                                        <!-- Số lượng -->
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Số lượng</label>
                                                            <input class="form-control" type="text" min="1" name="quantity"
                                                                   value="${sessionScope.inputQuantity != null ? sessionScope.inputQuantity : ''}">
                                                        </div>
                                                    </div>
                                                    <BR>
                                                    <button class="btn btn-save" type="submit">Lưu lại</button>
                                                    <a class="btn btn-cancel" data-dismiss="modal" href="saleoff">Hủy bỏ</a>
                                                    <BR>
                                                </form> 
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!--
                              MODAL
                                -->
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

        </main>
        <!-- Modal sửa -->

        <!-- Essential javascripts for application to work-->
        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <script src="admin/js/popper.min.js"></script>
        <script src="admin/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="admin/js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="admin/js/plugins/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="admin/js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="admin/js/plugins/dataTables.bootstrap.min.js"></script>
        <!-- ✅ jQuery phải trước -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- ✅ Bootstrap JS sau jQuery -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!-- ✅ (các script riêng của bạn để sau cùng) -->
        <script src="admin/js/main.js"></script>
        <script type="text/javascript">
        $('#sampleTable').DataTable();
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

            $(document).ready(jQuery(function () {
                jQuery(document).on('click', '.trash', function () {
                    swal({
                        title: "Cảnh báo",
                        text: "Bạn có chắc chắn là muốn xóa sản phẩm này?",
                        buttons: ["Hủy bỏ", "Đồng ý"],
                    })
                            .then((willDelete) => {
                                if (willDelete) {
                                    window.location = "productmanager?action=deleteproduct&product_id=" + $(this).attr("value");
                                    swal("Đã xóa thành công.!", {
                                        icon: "success",
                                    });
                                }
                            });
                });
            }));
        </script>

        <script>
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

        <c:if test="${not empty editId}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const modalId = '#ModalUP${editId}';
                    console.log("Auto open modal:", modalId);
                    $(modalId).modal('show');
                });
            </script>
        </c:if>


        <!-- Script thông báo cập nhật thành công -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <c:if test="${not empty successMessage}">
            <script>
                Swal.fire({
                    icon: 'success',
                    title: '${successMessage}',
                    showConfirmButton: false,
                    timer: 2000
                });
            </script>
        </c:if>

        <!-- Script thông báo thêm lỗi -->
        <c:if test="${addFail}">
            <script>
                $(document).ready(function () {
                    $('#addSaleModal').modal('show');
                });
            </script>
        </c:if>

        <!-- Script confirm   xoá -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                $(document).on('click', '.delete-btn', function () {
                    const saleId = $(this).data('id');
                    const saleCode = $(this).data('code');
                    Swal.fire({
                        title: `Bạn có chắc chắn muốn xóa mã ?`,
                        text: "Hành động này không thể hoàn tác!",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#d33',
                        cancelButtonColor: '#3085d6',
                        confirmButtonText: 'Xóa',
                        cancelButtonText: 'Hủy'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            const form = $('<form>', {
                                method: 'POST',
                                action: 'saleoff'
                            }).append(
                                    $('<input>', {type: 'hidden', name: 'action', value: 'delete'}),
                                    $('<input>', {type: 'hidden', name: 'saleId', value: saleId})
                                    );
                            $('body').append(form);
                            form.submit();
                        }
                    });
                });
        </script>

    </body>
</html>



