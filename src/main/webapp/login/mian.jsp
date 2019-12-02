<%@page contentType="text/html;charset=utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="app"></c:set>
<html>
<head>
    <title>title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <%--引入bootstrap的核心css--%>
    <link rel="stylesheet" href="${app}/boot/css/bootstrap.css">
    <link rel="stylesheet" href="${app}/jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
    <%--引入jquery的js--%>
    <script src="${app}/boot/js/jquery-2.2.1.min.js"></script>
    <%--引入bootstrap的js--%>
    <script src="${app}/boot/js/bootstrap.js"></script>
    <%--jqgird的国际化js--%>
    <script src="${app}/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <%--jqgird的js--%>
    <script src="${app}/jqgrid/js/trirand/jquery.jqGrid.min.js"></script>
    <script src="${app}/boot/js/ajaxfileupload.js"></script>

    <script src="${app}/kindeditor/kindeditor-all-min.js"></script>
    <script src="${app}/kindeditor/lang/zh-CN.js"></script>
</head>

<style>
    #panel-body {
        height: 480px;

    }

    .ui-jqgrid tr.jqgrow td {
        white-space: normal !important;
        height: auto;
        vertical-align: text-top;
        text-align: center;
    }

</style>

<body>

<!--导航栏-->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">
                持明法州管理系统
            </a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

            <ul class="nav navbar-nav navbar-right">
                <li><a href="${app}/admin/loginOut">退出登录 <span class="glyphicon glyphicon-log-out"></span></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a>欢迎：<span style="color: #FFA500">${sessionScope.admin.userName}</span></a></li>
            </ul>
        </div>


    </div>
</nav>
<hr/>
<hr/>


<div class="container-fluid">
    <div class="row">
        <!--左侧-->
        <div class="col-md-2">
            <!--	<div class="list-group">-->

            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="heading">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne"
                               aria-expanded="true" aria-controls="collapseOne">
                                用户管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse " role="tabpanel" aria-labelledby="heading">
                        <div class="panel-body">
                            <a href="javascript:$('#table').load('${app}/echarts/jsp/bargraph.jsp')">近期注册用户</a>
                        </div>
                        <div class="panel-body">
                            <a href="javascript:$('#table').load('${app}/echarts/jsp/china.jsp')">用户地区分布</a>
                        </div>
                    </div>
                </div>

                <!--客户拜访-->


                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headings">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"
                               aria-expanded="true" aria-controls="collapseTwo">
                                上师管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headings">
                        <div class="panel-body">
                            <a href="">上师管理</a>
                        </div>
                    </div>
                </div>

                <!--系统管理-->

                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingOne">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree"
                               aria-expanded="true">
                                文章管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse " role="tabpanel"
                         aria-labelledby="headingOne">
                        <div class="panel-body">
                            <a href="javascript:$('#table').load('article.jsp')">文章列表</a>
                        </div>
                    </div>
                </div>


                <!--专辑管理-->
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="zhuanji">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour"
                               aria-expanded="true" aria-controls="collapseFour">
                                专辑管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseFour" class="panel-collapse collapse " role="tabpanel" aria-labelledby="zhuanji">
                        <div class="panel-body">
                            <a href="javascript:$('#table').load('album.jsp')">专辑列表</a>
                        </div>
                    </div>
                </div>


                <!--轮播图管理-->


                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="banner">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFive"
                               aria-expanded="true" aria-controls="collapseFive">
                                轮播图管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseFive" class="panel-collapse collapse " role="tabpanel" aria-labelledby="banner">
                        <div class="panel-body">
                            <a href="javascript:$('#table').load('banner.jsp')">轮播图管理</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!--右侧-->
        <div class="col-md-10" id="table">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h1> 欢迎来到持明法州后台管理系统</h1>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-body" id="panel-body" style="padding: 0px;">
                    <img style="width: 100%;height: 100%" src="../img/shouye.jpg"/>
                </div>
            </div>

        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-footer" style="text-align: center;">@百知教育</div>
    </div>

</div>
</body>
</html>
