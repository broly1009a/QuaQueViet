<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Đăng nhập | You&Me</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="assets/img/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/css/plugins.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <style>


.customer_login, 
.customer_login .container,
.customer_login .row,
.customer_login .col-lg-6,
.customer_login .account_form {
    
    padding: 0 !important;
}
</style>
</head>

<body>
    <div class="off_canvars_overlay"></div>
    <jsp:include page="layout/menu.jsp"/>

    <!-- breadcrumb -->
    <div class="breadcrumbs_area other_bread">
        <div class="container">
            <div class="row"><div class="col-12">
                <div class="breadcrumb_content">
                    <ul>
                        <li><a href="home">home</a></li>
                        <li>/</li>
                        <li>Đăng nhập</li>
                    </ul>
                </div>
            </div></div>
        </div>
    </div>

    <!-- login -->
    <div class="customer_login">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 mx-auto">
                    <div class="account_form">
                        <h2>Đăng nhập</h2>

                        <c:set var="cookie" value="${pageContext.request.cookies}"/>
                        <form action="user?action=checkLogin" method="POST">
                            <p style="color:red;text-align:center;">${requestScope.error}</p>

                            <p>
                                <label>Email</label>
                                <input type="text" name="user_email"
                                       value="${cookie.email.value}">
                            </p>

                            <p>
                                <label>Mật khẩu</label>
                                <input type="password" name="user_pass"
                                       value="${cookie.pass.value}">
                            </p>

                            <div class="login_submit">
                                <a href="forgotpass.jsp">Quên mật khẩu</a>
                                <label>
                                    <input ${cookie.rem.value eq 'ON' ? 'checked' : ''}
                                           type="checkbox"
                                           id="remember" name="remember" value="ON">
                                    Nhớ tài khoản
                                </label>
                                <button type="submit">Đăng nhập</button>
                            </div>
                        </form>

                        <!-- Link sang trang đăng ký -->
                        <p style="margin-top:20px;">Chưa có tài khoản?
<a href="register.jsp">Đăng ký ngay</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="layout/footer.jsp"/>

    <!-- JS -->
    <script src="assets/js/plugins.js"></script>
    <script src="assets/js/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        function showNotification(msg, ok){
            Swal.fire({
                title: ok?'Thành công!':'Lỗi!',
                text: msg,
                icon: ok?'success':'error',
                toast:true,position:'top-end',timer:5000,showConfirmButton:false
            });
        }

        document.addEventListener('DOMContentLoaded', () => {
            const err = "${sessionScope.error_ban}";
            if(err){ showNotification(err,false); <% session.removeAttribute("error_ban"); %> }
        });
    </script>
</body>
</html>