<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Đăng ký | You&Me</title>
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
                        <li>Đăng ký</li>
                    </ul>
                </div>
            </div></div>
        </div>
    </div>

    <!-- register -->
    <div class="customer_login">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 mx-auto">
                    <div class="account_form register">
                        <h2>Đăng ký</h2>

                        <form action="user?action=signup" method="POST">
                            <p><label>Email</label>
                               <input type="email" name="user_email"
                                      placeholder="Nhập email của bạn" required></p>

                            <p><label>Mật khẩu</label>
                               <input type="password" name="user_pass"
                                      placeholder="a‑zA‑Z0‑9..." required></p>

                            <p><label>Nhập lại mật khẩu</label>
                               <input type="password" name="re_pass"
                                      placeholder="Nhập lại mật khẩu" required></p>

                            <input type="hidden" name="g-recaptcha-response"
                                   id="g-recaptcha-response">

                            <div class="login_submit">
                                <div class="g-recaptcha"
                                     data-sitekey="6LefS_ApAAAAAG7d6P0zRbGoed8oK2dwNnez6agN"></div>
                                <button type="submit" onclick="onSubmit()">Đăng Ký</button>
                            </div>
                        </form>

                        <!-- Link sang trang đăng nhập -->
                        <p style="margin-top:20px;">Đã có tài khoản?
                            <a href="login.jsp">Đăng nhập</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
<jsp:include page="layout/footer.jsp"/>

    <!-- JS -->
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script>
        function onSubmit(){
            const response = grecaptcha.getResponse();
            document.getElementById('g-recaptcha-response').value = response;
        }
    </script>

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
            const err   = "${sessionScope.error_exist}";
            const okMsg = "${sessionScope.signupMessage}";
            if(err){ showNotification(err,false); <% session.removeAttribute("error_exist"); %>}
            if(okMsg){ showNotification(okMsg,true); <% session.removeAttribute("signupMessage"); %>}
        });
        document.addEventListener('DOMContentLoaded', function () {
            var error_match = "${sessionScope.error_match}";
            var Recaptcha = "${sessionScope.Recaptcha}";
            var error_rePass = "${sessionScope.error_rePass}";
            var msg = "${sessionScope.msg}";
            var signupMessage = "${sessionScope.signupMessage}";
            var error_exist = "${sessionScope.error_exist}";
            var error_ban = "${sessionScope.error_ban}";

            if (error_match) {
                showNotification(error_match, false);
        <% session.removeAttribute("error_match"); %>
            }  if (Recaptcha) {
           
                showNotification(Recaptcha, false);
        <% session.removeAttribute("Recaptcha"); %>
            } else if (error_rePass) {
                showNotification(error_rePass, false);
        <% session.removeAttribute("error_rePass"); %>
            }
             else if (msg) {
                showNotification(msg, false);
        <% session.removeAttribute("msg"); %>
            }
             else if (error_exist) {
                showNotification(error_exist, false);
        <% session.removeAttribute("error_exist"); %>
            }
             else if (error_ban) {
                showNotification(error_ban, false);
        <% session.removeAttribute("error_ban"); %>
            }
             else if (signupMessage) {
                showNotification(signupMessage, true);
        <% session.removeAttribute("signupMessage"); %>
            }
        });
    </script>
</body>
</html>