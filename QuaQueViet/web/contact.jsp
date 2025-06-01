<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Liên hệ  |  Quà Quê Việt</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

        <!-- CSS -->
        <link rel="stylesheet" href="assets/css/plugins.css">
        <link rel="stylesheet" href="assets/css/style.css">

        <style>
            .popup-message {
                background-color: #f8d7da;
                color: #721c24;
                padding: 15px;
                margin: 20px 0;
                border: 1px solid #f5c6cb;
                border-radius: 5px;
                text-align: center;
                display: none;
            }

            .success-message {
                background-color: #d4edda;
                color: #155724;
                padding: 15px;
                margin: 20px 0;
                border: 1px solid #c3e6cb;
                border-radius: 5px;
                text-align: center;
                display: none;
            }
        </style>
    </head>

    <body>

        <div class="off_canvars_overlay"></div>
        <jsp:include page="layout/menu.jsp" />

        <div class="breadcrumbs_area other_bread">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="home">Trang chủ</a></li>
                                <li>/</li>
                                <li>Liên hệ</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="contact_area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <div class="contact_message content">
                            <h3>Liên hệ</h3>
                            <ul>
                                <li><i class="fa fa-fax"></i> Đại học FPT</li>
                                <li><i class="fa fa-envelope-o"> </i> <a href="mailto:anhmdhe163618@fpt.edu.vn">anhmdhe163618@fpt.edu.vn</a></li>
                                <li><i class="fa fa-phone"></i> 0967339681</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12">
                        <div class="contact_message form">
                            <h3>Gửi thông tin phản hồi</h3>
<!-- Thông báo thành công hoặc lỗi -->
                            <c:if test="${not empty contact_msg}">
                                <div class="alert ${contact_msg_success ? 'alert-success' : 'alert-danger'}">
                                    ${contact_msg}
                                </div>
                            </c:if>
                            <c:if test="${not empty contact_msgg}">
                                <div class="alert ${contact_msg_success ? 'alert-success' : 'alert-danger'}" style="color: green">
                                    ${contact_msgg}
                                </div>
                            </c:if>


                            <form id="contact-form" method="POST" action="contact">
                                <p>
                                    <label>Địa chỉ email</label>
                                    <input style="font-weight: bolder" name="user_email" readonly type="text" value="${user.user_email}">
                                </p>

                                <p>
                                    <label>Tiêu đề</label>
                                    <input name="subject_report" placeholder="Nhập tiêu đề ..." required type="text" value="${param.subject_report != null ? param.subject_report : ''}">
                                </p>

                                <div class="contact_textarea">
                                    <label>Nội dung</label>
                                    <textarea placeholder="Nhập nội dung của phản hồi ..." name="content_report" required>${param.content_report != null ? param.content_report : ''}</textarea>
                                </div>

                                <input hidden name="user_id" type="text" value="${user.user_id}">
                                <br>

                                <!-- Single Submit Button -->
                                <button type="submit">Gửi</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </body>

</html>