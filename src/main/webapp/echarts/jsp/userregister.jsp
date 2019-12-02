<%@page contentType="text/html;charset=utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="app"></c:set>
<html>
<head>
    <title>title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="${app}/boot/js/jquery-2.2.1.min.js"></script>
    <script>
        $(function () {
            var fanhuicode;

            $("#btn").click(function () {
                var name = $("#name").val()
                var password = $("#password").val()
                var province = $("#province").val()
                var sex = $("#sex").val()
                var code = $("#vcode").val();
                if (code == fanhuicode) {
                    alert(true)
                } else {
                    alert(false)
                }
                $.ajax({
                    url: "${app}/user/register",
                    data: {"name": name, "password": password, "province": province, "sex": sex},
                    type: 'post',
                    datatype: 'json',
                    success: function (data) {

                    }
                })
            })


            //点击获取验证码
            $("#yzm").click(function () {

                var val = $("#yzm");
                var countdown = 5;

                //5s后重新发送
                function settime() {
                    if (countdown == 0) {
                        val.removeAttr("disabled");
                        val.val("获取验证码");
                        countdown = 5;
                        clearInterval(set);//去除倒计时
                    } else {
                        val.attr("disabled", "disabled");
                        val.val("重新发送(" + countdown + ")");
                        countdown--;
                    }
                }

                //倒计时
                var set = setInterval(function () {
                    settime();
                }, 1000)

                var phone = $("#phone").val();
                $.ajax({
                    url: "${pageContext.request.contextPath}/account/vCode",
                    data: {"phone": phone},
                    type: 'post',
                    datatype: 'json',
                    success: function (data) {
                        fanhuicode = data;
                    }
                })
            })

        })
    </script>
</head>

<body>
<form id="form">
    <div>姓名：<input type="text" value="" name="name" id="name"/></div>
    <div>密码：<input type="text" value="" name="password" id="password"></div>
    <div>省份：<input type="text" value="" name="province" id="province"></div>
    <div> 性别：<input type="text" value="" name="sex" id="sex"></div>
    <div>手机：<input type="text" value="" name="phone" id="phone"></div>
    <div><input type="text" value="" name="vcode" id="vcode"><input type="button" value="点击获取验证码" name="yzm" id="yzm">
    </div>
    <div><input type="button" id="btn" value="注册"></div>
</form>
</body>
</html>
