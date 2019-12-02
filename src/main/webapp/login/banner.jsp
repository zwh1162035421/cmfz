<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; utf-8" %>
<html>
<head>

    <script>
        $(function () {
            $("#bannerList").jqGrid({
                url: "${pageContext.request.contextPath}/banner/findAllByPage",
                editurl: "${pageContext.request.contextPath}/banner/edit",
                datatype: "json",
                colNames: ["id", "标题", "状态", "描述", "创建时间", "图片"],
                colModel: [
                    {name: "id"},//<input id="id">
                    {name: "title", editable: true},
                    {
                        name: "status", editable: true, edittype: "select",
                        editoptions: {value: "y:展示;n:不展示"},
                        formatter: function (a, b, c) {
                            if (a == 'y') {
                                return "展示";
                            } else if (a == 'n') {
                                return "不展示"
                            } else {
                                return a;
                            }
                        }
                    },
                    {name: "des", editable: true},
                    {name: "creatTime"},
                    {
                        name: "imgPath", editable: true, edittype: "file",
                        formatter: function (cellvalue, options, rowObject) {
                            return "<img style='width:100px;height:70px' src='${pageContext.request.contextPath}/img/" + cellvalue + "'/>"
                        }
                    }
                ],
                styleUI: "Bootstrap",
                autowidth: true,
                caption: "轮播图列表",
                toolbar: [true, "top"],
                pager: "#bannerPager",
                rowNum: 3,
                page: 1,
                rowList: [3, 4, 5, 6],
                multiselect: true,
                viewrecords: true,
                height: "50%",
            }).jqGrid("navGrid", "#bannerPager",
                { //处理前台页面按钮组的样式以及展示后者不展示。
                    search: false
                },
                {//控制编辑按钮，在编辑之前或者之后要进行的额外操作
                    closeAfterEdit: true,
                    beforeShowForm: function (obj) {
                        obj.find("#imgPath").attr("disabled", true)
                        //obj.find("#creatTime").attr("disabled",true)
                    }
                },
                {//控制添加按钮，在添加之前或者之后要进行的额外操作
                    closeAfterAdd: true,
                    afterSubmit: function (response) {
                        var bannerId = response.responseText;
                        $.ajaxFileUpload({
                            url: "${pageContext.request.contextPath}/banner/upload",
                            fileElementId: "imgPath",
                            data: {bId: bannerId},
                            success: function (data) {
                                $("#bannerList").trigger("reloadGrid");
                            }
                        });
                        return "sdfds"
                    }
                },
                {//控制删除按钮，在删除之前或者之后要进行的额外操作
                    afterSubmit: function () {
                        //$("#bannerList").trigger("reloadGrid");
                    }
                }
            )

            $("#t_bannerList").append("<a href=\"javascript:exportpoi()\" class=\"btn btn-default btn-info\"> 导出表格</a>\n")
        })

        function exportpoi() {

            $.ajax({
                url: "${pageContext.request.contextPath}/banner/downpoi",
                datatype: "json",
                type: "post",
                success: function (data) {
                    location.href = "${pageContext.request.contextPath}/banner/down";
                }
            })

        }

    </script>
    <style>
        #bannerPager {
            height: 60px;
        }
    </style>
</head>
<body>
<table id="bannerList"></table>
<div id="bannerPager"></div>
</body>
</html>