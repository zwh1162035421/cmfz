<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="app"></c:set>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap Login Form Template</title>
    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="${app}/login/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${app}/login/assets/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${app}/login/assets/css/form-elements.css">
    <link rel="stylesheet" href="${app}/login/assets/css/style.css">
    <link rel="shortcut icon" href="${app}/login/assets/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144"
          href="${app}/login/assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114"
          href="${app}/login/assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72"
          href="${app}/login/assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="${app}/login/assets/ico/apple-touch-icon-57-precomposed.png">

    <link rel="stylesheet" href="${app}/login/css/jigsaw.css">
    <script src="${app}/login/js/jigsaw.js"></script>

    <script src="${app}/boot/js/jquery-2.2.1.min.js"></script>
    <script src="${app}/login/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="${app}/login/assets/js/jquery.backstretch.min.js"></script>
    <script src="${app}/login/assets/js/scripts.js"></script>
    <script src="${app}/boot/js/jquery.validate.min.js"></script>

    <style>

        #msg {
            width: 100%;
            line-height: 40px;
            font-size: 14px;
            text-align: center;
        }

        a:link, a:visited, a:hover, a:active {
            margin-left: 100px;
            color: #0366D6;
        }

    </style>

    <script>
        $(function () {

            var status;

            //滑块验证码验证
            jigsaw.init(document.getElementById('captcha'),
                function () {
                    status = true;
                    $("#hkmes").hide();
                    //表单验证
                    $("#loginForm").validate({
                        rules: {
                            username: {
                                required: true,//必填
                                maxlength: 8,//最长为8
                            },
                            password: {
                                required: true,//必填
                                maxlength: 8,//最长为8
                            },

                        },
                        messages: {
                            username: {
                                required: "*必填",
                                maxlength: "最多8个字符"
                            },
                            password: {
                                required: "*必填",//必填
                                maxlength: "最多8个字符"//最长为8
                            }

                        },
                        submitHandler: function () {
                            var userName = $("#form-username").val();
                            var password = $("#form-password").val();
                            var code = $("#form-code").val();

                            var data = "username=" + userName + "&password=" + password + "&code=" + code;
                            $.ajax({
                                url: "${app}/admin/findByUserAndPassword",
                                data: data,
                                type: "Get",
                                dataType: "json",//返回数据类型
                                success: function (data) {
                                    console.log(data)
                                    if (data.msg == 'ok') {
                                        location.href = "${app}/login/mian.jsp";
                                    } else {
                                        $("#msgDiv").text(data.msg)
                                    }
                                }
                            });
                        }

                    })
                },
                function () {
                    return false;
                }
            )

            //点击登录先验证滑块是否通过
            $("#loginButtonId").click(function () {
                if (status != true) {
                    $("#hkmes").text("*请先将滑块滑到正确位置")
                }
            })

            $("#kaptchaImage").click(function () {
                $(this).attr('src', '../getVerifyCode?' + Math.floor(Math.random() * 100));
            })


            $("#loginButtonId").click(function () {
                $("#loginButtonId").submit();
            })


        })


    </script>
</head>

<body>

<!-- Top content -->
<div class="top-content">

    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text">
                    <h1><strong>CMFZ</strong> Login Form</h1>
                    <div class="description">
                        <p>
                            <a href="#"><strong>CMFZ</strong></a>
                        </p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top" style="width: 450px">
                        <div class="form-top-left">
                            <h3>Login to showall</h3>
                            <p>Enter your username and password to log on:</p>
                        </div>
                        <div class="form-top-right">
                            <i class="fa fa-key"></i>
                        </div>
                    </div>
                    <div class="form-bottom" style="width: 450px">
                        <form role="form" action="" method="post" class="login-form" id="loginForm">
                            <span style="color: red" id="msgDiv"></span>
                            <div class="form-group">
                                <label class="sr-only" for="form-username">Username</label>
                                <input type="text" name="username" placeholder="请输入用户名..."
                                       class="form-username form-control" id="form-username">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-password">Password</label>
                                <input type="password" name="password" placeholder="请输入密码..."
                                       class="form-password form-control" id="form-password">
                            </div>
                            <div class="form-group">
                                <img id="kaptchaImage" style="height: 48px" src="../getVerifyCode"/>
                                <input style="width: 180px;height: 50px;border:3px solid #ddd;border-radius: 4px;"
                                       type="test" name="enCode" id="form-code">
                            </div>

                            <div class="form-group">
                                <div class="container">
                                    <div id="captcha" style="position: relative"></div>
                                    <div id="msg"></div>
                                    <div><span style="color: #003300;font-weight: bold" id="hkmes"></span></div>
                                </div>
                            </div>

                            <input type="button" style="width: 400px;border:1px solid #9d9d9d;border-radius: 4px;"
                                   id="loginButtonId" value="登录">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>


</body>

<script>

</script>
</html>