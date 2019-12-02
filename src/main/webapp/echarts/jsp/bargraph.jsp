<%@page contentType="text/html;charset=utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="app"></c:set>
<html>
<head>
    <title>title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="${app}/boot/js/jquery-2.2.1.min.js"></script>
    <script src="${app}/echarts/js/echarts.js"></script>
    <script src="${app}/echarts/js/goeasy-1.0.3.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function () {
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('main'));
            // 指定图表的配置项和数据
            var option = {
                title: {
                    text: '持明法州近期用户注册'
                },
                tooltip: {},
                legend: {
                    data: ['男', '女']
                },
                xAxis: {
                    data: ["近一周", "近两周", "近三周"]
                },
                yAxis: {},
                series: [{
                    name: '男',
                    type: 'bar'
                    //data: [5, 20, 36]
                }, {
                    name: '女',
                    type: 'bar'
                    //data: [10, 22, 34]
                }],

            };

            $.ajax({
                url: "${app}/user/queryByDate",
                type: 'post',
                datatype: 'json',
                success: function (data) {
                    myChart.setOption({
                        series: [{
                            data: data.datan
                        }, {
                            data: data.dataw
                        }]
                    });
                }
            })
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);


            //初始化goeasy对象
            var goEasy = new GoEasy({
                host: 'hangzhou.goeasy.io', //应用所在的区域地址: 【hangzhou.goeasy.io |singapore.goeasy.io】
                appkey: "BC-85ba961dd6824fb4867d8dda1a70e027", //替换为您的应用appkey
            });

            //接收消息
            goEasy.subscribe({
                channel: "asd", //替换为您自己的channel
                onMessage: function (data) {
                    $.ajax({
                        url: '${app}/user/queryByDate',
                        type: 'post',
                        datatype: 'json',
                        success: function (result) {
                            myChart.setOption({
                                series: [{
                                    data: result.datan
                                }, {
                                    data: result.dataw
                                }], title: {
                                    text: data.content,
                                }
                            });
                        }
                    })
                }
            });
        })


    </script>
</head>

<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 600px;height:400px;">ss</div>
</body>
</html>
