<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; utf-8" %>
<style>
    #articlePage {
        height: 60px;
    }
</style>


<script>
    $(function () {
        //$.extend($.jgrid.del, {jqModal: false});
        $("#articleList").jqGrid({
            url: "${pageContext.request.contextPath}/article/findAllByPage",
            editurl: "${pageContext.request.contextPath}/article/edit",
            datatype: "json",
            colNames: ["id", "标题", "内容", "状态", "作者", "创建时间", "操作"],
            colModel: [
                {name: "id", hidden: true},//<input id="id">
                {name: "title", editable: true},
                {name: "content", hidden: true},
                {
                    name: "status", editable: true, edittype: "select",
                    editoptions: {value: "y:展示;n:不展示"},
                    formatter: function (a, b, c) {
                        if (a == 'y') {
                            return "展示";
                        } else {
                            return "不展示"
                        }
                    }
                },
                {name: "author"},
                {name: "creatTime", formatter: "date"},
                {
                    name: "",
                    formatter: function (a, b, c) {
                        return "<a href='#' onclick=\"lookModel('" + c.id + "')\">查看详情</a>"

                    }
                }
            ],
            styleUI: "Bootstrap",
            autowidth: true,
            pager: "#articlePage",
            rownumbers: true,
            rowNum: 4,
            page: 1,
            rowList: [4, 6, 8],
            multiselect: true,
            viewrecords: true,
            height: "60%"
        }).jqGrid("navGrid", "#articlePage",
            {search: false, add: false, edit: false},
            {},
            {},
            {//在删除之前/之后进行的操作
                afterSubmit: function (response) {
                    var id11 = response.responseText;
                    $("#articleList").trigger("reloadGrid");
                    $(".ui-jqdialog-titlebar-close").trigger("click")
                }
            }
        )
    });

    function showModel() {
        $("#myModal").modal("show");
        $("#modal_footer").html(
            "<button type=\"button\" onclick='addArticle()' class=\"btn btn-primary\">添加</button>\n" +
            "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">取消</button>"
        );

        //editor
        KindEditor.create('#editor', {
            uploadJson: "${pageContext.request.contextPath}/kindEditor/upload",
            filePostName: "img",
            fileManagerJson: "${pageContext.request.contextPath}/kindEditor/getAllImg",
            allowFileManager: true,
            afterBlur: function () {
                this.sync();
            }
        });
        $("#addArticleFrom")[0].reset();
        KindEditor.html("#editor", "");
    }

    function addArticle() {
        $.ajax({
            url: "${pageContext.request.contextPath}/article/add",
            datatype: "json",
            type: "post",
            data: $("#addArticleFrom").serialize(),
            success: function (data) {
                $("#myModal").modal("toggle");
                $("#articleList").trigger("reloadGrid");
            }
        })
    }


    function lookModel(id) {
        $("#addArticleFrom")[0].reset();
        $("#myModal").modal("show");
        var value = $("#articleList").getRowData(id);
        $("#title").val(value.title);
        $("#author").val(value.author);
        if (value.status == "展示") {
            $("#status").val('y');
        } else {
            $("#status").val('n');
        }
        KindEditor.create('#editor', {
            uploadJson: "${pageContext.request.contextPath}/kindeditor/upload",
            filePostName: "img",
            fileManagerJson: "${pageContext.request.contextPath}/kindeditor/getAllImg",
            allowFileManager: true,
            afterBlur: function () {
                this.sync();
            }
        });
        KindEditor.html("#editor", "");
        KindEditor.appendHtml("#editor", value.content);


        $("#modal_footer").html(
            "<button type=\"button\" onclick=\"updateArticle('" + id + "')\" class=\"btn btn-primary\">修改</button>\n" +
            "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">取消</button>"
        );

    }

    function updateArticle(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/article/update?id=" + id,
            datatype: "json",
            type: "post",
            data: $("#addArticleFrom").serialize(),
            success: function (data) {
                $("#myModal").modal("toggle");
                $("#articleList").trigger("reloadGrid");
            }
        })
    }


</script>


<div>

    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab"
                                                  data-toggle="tab">文章列表</a></li>
        <li role="presentation"><a href="#profile" onclick="showModel()" aria-controls="profile" role="tab"
                                   data-toggle="tab">添加文章</a></li>

    </ul>

</div>


<table id="articleList"></table>
<div id="articlePage"></div>


<div class="modal fade" id="myModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="width:750px">
            <!--模态框标题-->
            <div class="modal-header">
                <!--
                    用来关闭模态框的属性:data-dismiss="modal"
                -->
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title">编辑文章</h4>
            </div>

            <!--模态框内容体-->
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/article/editArticle" class="form-horizontal"
                      id="addArticleFrom">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">标题</label>
                        <div class="col-sm-5">
                            <input type="text" name="title" id="title" placeholder="请输入标题" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">作者</label>
                        <div class="col-sm-5">
                            <input type="text" name="author" id="author" placeholder="请输入作者" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">状态</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="status" id="status">
                                <option value="y">展示</option>
                                <option value="n">不展示</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea id="editor" name="content" style="width:700px;height:300px;"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <!--模态页脚-->
            <div class="modal-footer" id="modal_footer">
                <%--<button type="button" class="btn btn-primary">保存</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>--%>
            </div>
        </div>
    </div>
</div>