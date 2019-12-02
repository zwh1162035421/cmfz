<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/echarts/js/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/echarts/js/china.js"></script>
<script src="${pageContext.request.contextPath}/echarts/js/goeasy-1.0.3.js" type="text/javascript"></script>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="china" style="width: 600px;height: 600px;margin-top: 30px;margin-left: 30px">

</div>

<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('china'));
    var option = {
        title: {
            text: '用户地区分布图',
            subtext: '最新数据',
            left: 'center'
        },
        tooltip: {},
        // 说明
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['男', '女']
        },
        visualMap: {
            min: 0,
            max: 100,
            left: 'left',
            top: 'bottom',
            text: ['高', '低'],           // 文本，默认为数值文本
            calculable: true
        },
        // 工具箱
        toolbox: {
            show: true,
            orient: 'vertical',
            left: 'right',
            top: 'center',
            feature: {
                dataView: {readOnly: false},
                restore: {},
                saveAsImage: {}
            }
        },
        series: [
            {
                name: '男',
                type: 'map',
                mapType: 'china',
                roam: false,
                label: {
                    normal: {
                        show: true
                    },
                    emphasis: {
                        show: true
                    }
                }

            },
            {
                name: '女',
                type: 'map',
                mapType: 'china',
                label: {
                    normal: {
                        show: true
                    },
                    emphasis: {
                        show: true
                    }
                }

            }
        ]
    };
    myChart.setOption(option);

    //初始化goeasy对象
    var goEasy = new GoEasy({
        host: 'hangzhou.goeasy.io', //应用所在的区域地址: 【hangzhou.goeasy.io |singapore.goeasy.io】
        appkey: "BC-85ba961dd6824fb4867d8dda1a70e027", //替换为您的应用appkey
    });


    //接收消息
    goEasy.subscribe({
        channel: "asd", //替换为您自己的channel
        onMessage: function (result) {
            $.ajax({
                url: '${pageContext.request.contextPath}/user/queryBypro',
                type: 'post',
                datatype: 'json',
                success: function (data) {
                    myChart.setOption({
                        series: [{
                            data: [
                                {name: "安徽", value: data[0].安徽},
                                {name: "吉林", value: data[0].吉林},
                                {name: "辽宁", value: data[0].辽宁},
                                {name: "西藏", value: data[0].西藏},
                                {name: "湖南", value: data[0].湖南},
                                {name: "新疆", value: data[0].新疆},
                                {name: "青海", value: data[0].青海},
                                {name: "甘肃", value: data[0].甘肃},
                                {name: "宁夏", value: data[0].宁夏},
                                {name: "陕西", value: data[0].陕西},
                                {name: "重庆", value: data[0].重庆},
                                {name: "四川", value: data[0].四川},
                                {name: "云南", value: data[0].云南},
                                {name: "广西", value: data[0].广西},
                                {name: "海南", value: data[0].海南},
                                {name: "贵州", value: data[0].贵州},
                                {name: "上海", value: data[0].上海},
                                {name: "重庆", value: data[0].重庆},
                                {name: "湖北", value: data[0].湖北},
                                {name: "江西", value: data[0].江西},
                                {name: "台湾", value: data[0].台湾},
                                {name: "江西", value: data[0].江西},
                                {name: "福建", value: data[0].福建},
                                {name: "江苏", value: data[0].江苏},
                                {name: "浙江", value: data[0].浙江},
                                {name: "河南", value: data[0].河南},
                                {name: "陕西", value: data[0].陕西},
                                {name: "河北", value: data[0].河北},
                                {name: "山东", value: data[0].山东},
                                {name: "山西", value: data[0].山西},
                                {name: "天津", value: data[0].天津},
                                {name: "北京", value: data[0].北京},
                                {name: "广东", value: data[0].广东},
                                {name: "内蒙古", value: data[0].内蒙古},
                                {name: "黑龙江", value: data[0].黑龙江},
                                {name: "南海诸岛", value: data[0].南海诸岛}
                            ]
                        }, {
                            data: [
                                {name: "安徽", value: data[1].安徽},
                                {name: "吉林", value: data[1].吉林},
                                {name: "辽宁", value: data[1].辽宁},
                                {name: "西藏", value: data[1].西藏},
                                {name: "湖南", value: data[1].湖南},
                                {name: "新疆", value: data[1].新疆},
                                {name: "青海", value: data[1].青海},
                                {name: "甘肃", value: data[1].甘肃},
                                {name: "宁夏", value: data[1].宁夏},
                                {name: "陕西", value: data[1].陕西},
                                {name: "重庆", value: data[1].重庆},
                                {name: "四川", value: data[1].四川},
                                {name: "云南", value: data[1].云南},
                                {name: "广西", value: data[1].广西},
                                {name: "海南", value: data[1].海南},
                                {name: "贵州", value: data[1].贵州},
                                {name: "上海", value: data[1].上海},
                                {name: "重庆", value: data[1].重庆},
                                {name: "湖北", value: data[1].湖北},
                                {name: "江西", value: data[1].江西},
                                {name: "台湾", value: data[1].台湾},
                                {name: "江西", value: data[1].江西},
                                {name: "福建", value: data[1].福建},
                                {name: "江苏", value: data[1].江苏},
                                {name: "浙江", value: data[1].浙江},
                                {name: "河南", value: data[1].河南},
                                {name: "陕西", value: data[1].陕西},
                                {name: "河北", value: data[1].河北},
                                {name: "山东", value: data[1].山东},
                                {name: "山西", value: data[1].山西},
                                {name: "天津", value: data[1].天津},
                                {name: "北京", value: data[1].北京},
                                {name: "广东", value: data[1].广东},
                                {name: "内蒙古", value: data[1].内蒙古},
                                {name: "黑龙江", value: data[1].黑龙江},
                                {name: "南海诸岛", value: data[1].南海诸岛}
                            ]
                        }], title: {
                            text: result.content,
                        }
                    });
                }
            })
        }
    });


    //懒加载
    $(function () {
        $.ajax({
            url: "${pageContext.request.contextPath}/user/queryBypro",
            type: 'post',
            datatype: 'json',
            success: function (data) {
                myChart.setOption({
                    series: [{
                        data: [
                            {name: "安徽", value: data[0].安徽},
                            {name: "吉林", value: data[0].吉林},
                            {name: "辽宁", value: data[0].辽宁},
                            {name: "西藏", value: data[0].西藏},
                            {name: "湖南", value: data[0].湖南},
                            {name: "新疆", value: data[0].新疆},
                            {name: "青海", value: data[0].青海},
                            {name: "甘肃", value: data[0].甘肃},
                            {name: "宁夏", value: data[0].宁夏},
                            {name: "陕西", value: data[0].陕西},
                            {name: "重庆", value: data[0].重庆},
                            {name: "四川", value: data[0].四川},
                            {name: "云南", value: data[0].云南},
                            {name: "广西", value: data[0].广西},
                            {name: "海南", value: data[0].海南},
                            {name: "贵州", value: data[0].贵州},
                            {name: "上海", value: data[0].上海},
                            {name: "重庆", value: data[0].重庆},
                            {name: "湖北", value: data[0].湖北},
                            {name: "江西", value: data[0].江西},
                            {name: "台湾", value: data[0].台湾},
                            {name: "江西", value: data[0].江西},
                            {name: "福建", value: data[0].福建},
                            {name: "江苏", value: data[0].江苏},
                            {name: "浙江", value: data[0].浙江},
                            {name: "河南", value: data[0].河南},
                            {name: "陕西", value: data[0].陕西},
                            {name: "河北", value: data[0].河北},
                            {name: "山东", value: data[0].山东},
                            {name: "山西", value: data[0].山西},
                            {name: "天津", value: data[0].天津},
                            {name: "北京", value: data[0].北京},
                            {name: "广东", value: data[0].广东},
                            {name: "内蒙古", value: data[0].内蒙古},
                            {name: "黑龙江", value: data[0].黑龙江},
                            {name: "南海诸岛", value: data[0].南海诸岛}
                        ]
                    }, {
                        data: [
                            {name: "安徽", value: data[1].安徽},
                            {name: "吉林", value: data[1].吉林},
                            {name: "辽宁", value: data[1].辽宁},
                            {name: "西藏", value: data[1].西藏},
                            {name: "湖南", value: data[1].湖南},
                            {name: "新疆", value: data[1].新疆},
                            {name: "青海", value: data[1].青海},
                            {name: "甘肃", value: data[1].甘肃},
                            {name: "宁夏", value: data[1].宁夏},
                            {name: "陕西", value: data[1].陕西},
                            {name: "重庆", value: data[1].重庆},
                            {name: "四川", value: data[1].四川},
                            {name: "云南", value: data[1].云南},
                            {name: "广西", value: data[1].广西},
                            {name: "海南", value: data[1].海南},
                            {name: "贵州", value: data[1].贵州},
                            {name: "上海", value: data[1].上海},
                            {name: "重庆", value: data[1].重庆},
                            {name: "湖北", value: data[1].湖北},
                            {name: "江西", value: data[1].江西},
                            {name: "台湾", value: data[1].台湾},
                            {name: "江西", value: data[1].江西},
                            {name: "福建", value: data[1].福建},
                            {name: "江苏", value: data[1].江苏},
                            {name: "浙江", value: data[1].浙江},
                            {name: "河南", value: data[1].河南},
                            {name: "陕西", value: data[1].陕西},
                            {name: "河北", value: data[1].河北},
                            {name: "山东", value: data[1].山东},
                            {name: "山西", value: data[1].山西},
                            {name: "天津", value: data[1].天津},
                            {name: "北京", value: data[1].北京},
                            {name: "广东", value: data[1].广东},
                            {name: "内蒙古", value: data[1].内蒙古},
                            {name: "黑龙江", value: data[1].黑龙江},
                            {name: "南海诸岛", value: data[1].南海诸岛}
                        ]
                    }]
                });
            }

        })
    })

</script>












