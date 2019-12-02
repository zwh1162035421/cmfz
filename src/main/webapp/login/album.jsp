<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; utf-8" %>

<style>
    #albumPager {
        height: 60px;
    }
</style>

<script>
    $(function () {
        $("#albumList").jqGrid({
            url: "${pageContext.request.contextPath}/album/findAllByPage",
            editurl: "${pageContext.request.contextPath}/album/edit",
            datatype: "json",
            colNames: ["id", "标题", "分数", "作者", "播音员", "章节数", "专辑简介", "状态", "发行时间", "上传时间", "插图"],
            colModel: [
                {name: "id"},//<input id="id">
                {name: "title", editable: true},
                {name: "score"},
                {name: "author", editable: true},
                {name: "teller", editable: true},
                {name: "chapterNum", editable: true},
                {name: "albumAbout", editable: true},
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
                {name: "issuedate", editable: true},
                {name: "creattime"},
                {
                    name: "imgPath", editable: true, edittype: "file",
                    formatter: function (cellvalue, options, rowObject) {
                        return "<img style='width:100px;height:70px' src='${pageContext.request.contextPath}/img/" + cellvalue + "'/>"
                    }
                }
            ],
            styleUI: "Bootstrap",
            autowidth: true,
            caption: "专辑列表",
            pager: "#albumPager",
            rowNum: 2,
            page: 1,
            rowList: [2, 4, 8],
            multiselect: true,
            viewrecords: true,
            height: "60%",
            subGrid: true,
            subGridRowExpanded: function (subGridId, albumId) {
                //subGridId子表格id     albumId父表格id和postdata属性名对应即可
                //alert(albumId)
                var tableId = subGridId + "table";
                var pagerId = subGridId + "pager";
                $("#" + subGridId).html(
                    "<table id=" + tableId + "></table>\n" +
                    "<div id=" + pagerId + "></div>"
                );
                $("#" + tableId).jqGrid({
                    url: "${pageContext.request.contextPath}/chapter/findAllByPage",
                    editurl: "${pageContext.request.contextPath}/chapter/edit",
                    datatype: "json",
                    postData: {"aid": albumId},
                    colNames: ["id", "标题", "大小", "时常", "上传时间", "音频", "操作"],
                    colModel: [
                        {name: "id"},//<input id="id">
                        {name: "title", editable: true},
                        {name: "size"},
                        {name: "timeSize"},
                        {name: "createtime"},
                        {
                            name: "audio", editable: true, edittype: "file",
                            formatter: function (cellvalue, options, rowObject) {
                                return "<audio controls='controls' style='width:200px;height:70px' src='${pageContext.request.contextPath}/audio/" + cellvalue + "' />"
                            }
                        },
                        {
                            name: "xxxx",
                            formatter: function (cellvalue, options, rowObject) {
                                return "<a  href=\"javascript:edit('" + rowObject.id + "')\"><span class=\"glyphicon glyphicon-play-circle\"></span> </a> " +
                                    "<a href=\"javascript:del('" + rowObject.id + "')\"><span class=\"glyphicon glyphicon-download\"></span></a>";
                            }
                        }
                    ],
                    styleUI: "Bootstrap",
                    autowidth: true,
                    pager: "#" + pagerId,
                    rowNum: 2,
                    page: 1,
                    rowList: [2, 4, 8],
                    multiselect: true,
                    viewrecords: true,
                    height: "60%"
                }).jqGrid("navGrid", "#" + pagerId,
                    {},
                    {
                        closeAfterEdit: true,
                        beforeShowForm: function (obj) {
                            obj.find("#audio").attr("disabled", true)
                            //obj.find("#creatTime").attr("disabled",true)
                        }
                    },
                    {//控制添加按钮，在添加之前或者之后要进行的额外操作
                        closeAfterAdd: true,
                        afterSubmit: function (response) {
                            var chapterId = response.responseText;
                            $.ajaxFileUpload({
                                url: "${pageContext.request.contextPath}/chapter/upload",
                                fileElementId: "audio",
                                data: {aId: chapterId, pid: albumId},
                                success: function (data) {
                                    $("#" + pagerId).trigger("reloadGrid");
                                }
                            });
                            return response
                        }
                    }
                )

            }
        }).jqGrid("navGrid", "#albumPager",
            {},
            {//编辑触发
                closeAfterEdit: true,
                beforeShowForm: function (obj) {
                    obj.find("#imgPath").attr("disabled", true)
                    obj.find("#issuedate").attr("disabled", true)
                    //obj.find("#creatTime").attr("disabled",true)
                }

            },
            {//添加触发
                closeAfterAdd: true,
                afterSubmit: function (response) {
                    var chapterId = response.responseText;
                    alert(chapterId)
                    $.ajaxFileUpload({
                        url: "${pageContext.request.contextPath}/album/upload",
                        fileElementId: "imgPath",
                        data: {aId: chapterId},
                        success: function (data) {
                            $("#albumList").trigger("reloadGrid");
                        }
                    });
                    return response
                }
            }
        )
    })

</script>


<table id="albumList"></table>
<div id="albumPager"></div>
