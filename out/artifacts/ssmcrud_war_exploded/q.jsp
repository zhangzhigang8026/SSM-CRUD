<%--
  Created by IntelliJ IDEA.
  User: Zhang
  Date: 2018/3/8
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>人员管理</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%--web路径--%>
    <%--不以 / 开始的相对路径，找资源，以当前资源路径为基准，经常容易出现问题--%>
    <%--以 / 开始的相对路径，找资源，以服务器路径为标准（http://localhost:3306）,需要加上项目名--%>
    <%--http://localhost:8080/curd--%>

    <%---->--%>

    <!--引入jquery-->
    <script type="text/javascript"src="static/js/jquery-1.12.4.min.js"></script>
    <!-- Bootstrap -->
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--搭建显示页面--%>
<div class="container ">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12" >
            <h1>SSM-CURD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn bg-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn bg-danger">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
               <thead>
                   <tr>
                       <td>#</td>
                       <td>empName</td>
                       <td>gender</td>
                       <td>email</td>
                       <td>deptName</td>
                       <td>操作</td>
                   </tr>
               </thead>
                <tbody>

                </tbody>



            </table>
        </div>
    </div>
    <%--显示分页--%>
    <div class="row">
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页信息--%>
        <div class="col-md-6"id="page_info_nav">

        </div>
    </div>

        <!-- 员工添加模态框 -->
        <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-2 control-label">empName</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="empName_input" placeholder="empName">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox"> Remember me
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="btn btn-default">Sign in</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

</div>

<script>
    //页面加载完成，直接发送ajax请求
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/q",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                console.log(result)
                //解析并显示员工信息
                build_emps_table(result);
                //解析并显示分页信息
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
           var empIdTd = $("<td></td>").append(item.empId);
           var empNameTd = $("<td></td>").append(item.empName);
           var genderTd = $("<td></td>").append(item.gender == "M"?"男":"女");
           var emailTd =$("<td></td>").append(item.email);
           var departmentTd = $("<td></td>").append(item.department.deptName);
            /**
             * <button class="btn btn-primary btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
             编辑
             </button>
             * @type {jQuery|HTMLElement}
             */
           var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 编辑");
           var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
               .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" 删除");
           var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
           // append()方法执行完成后,返回原来的元素
           $("<tr></tr>").append(empIdTd)
               .append(empNameTd)
               .append(genderTd)
               .append(emailTd)
               .append(departmentTd)
               .append(btnTd)
               .appendTo("#emps_table tbody");
        });

    }

    function build_page_info(result) {
        $("#page_info_area").empty();
        var pageInfo = result.extend.pageInfo;
        $("#page_info_area").append("当前:"+pageInfo.pageNum+"页,共"+pageInfo.pages+"页,共"+pageInfo.total+"记录");

    }
    function build_page_nav(result) {
        $("#page_info_nav").empty();
        var pageInfo =result.extend.pageInfo;
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPage =$("<li></li>").append($("<a></a>").append("首页")).attr("href","#");
        var Previous = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(pageInfo.hasPreviousPage == false){
            Previous.addClass("disabled");
            firstPage.addClass("disabled");
        }else {
            //为首页添加点击事件
            firstPage.click(function () {
                to_page(1);
            });
            Previous.click(function () {
                to_page(pageInfo.pageNum-1);
            });
        }


        var Next = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPage =$("<li></li>").append($("<a></a>").append("末页")).attr("href","#");
        if(pageInfo.hasNextPage == false){
            Next.addClass("disabled");
            lastPage.addClass("disabled");
        }else {
            Next.click(function () {
                to_page(pageInfo.pageNum+1);
            });
            lastPage.click(function () {
                to_page(pageInfo.pages);
            });
        }

        ul.append(firstPage).append(Previous);//添加首页和前一页的提示
        //1,2,3 遍历
        $.each(pageInfo.navigatepageNums,function (idex,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item)).attr("href","#");
            if(pageInfo.pageNum == item){
                numLi.addClass("active");
            }else{
                numLi.click(function () {
                    to_page(item);
                });
            }


            ul.append(numLi);
        });
        ul.append(Next).append(lastPage);//添加下一页和末页

        var navEle =$("<nav></nav>").append(ul);
        navEle.appendTo("#page_info_nav");
    }

    $("#emp_add_modal_btn").click(function () {
        $('#empAddModal').modal({
            backdrop:"static"
        })
    });
</script>
</body>
</html>

