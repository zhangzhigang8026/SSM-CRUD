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
                                <label for="empName_input" class="col-sm-2 control-label">empName</label>
                                <div class="col-sm-10">
                                    <input type="text" name="empName" class="form-control" id="empName_input" placeholder="empName">
                                    <span id="helpBlock1" class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email_input" class="col-sm-2 control-label">email</label>
                                <div class="col-sm-10">
                                    <input type="email" name="email" class="form-control" id="email_input" placeholder="email@email.com">
                                    <span id="helpBlock2" class="help-block"></span>
                                </div>
                            </div>
                              <div class="form-group">
                                <label  class="col-sm-2 control-label">gender</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label">deptName</label>
                                <div class="col-sm-4">
                                    <%--部门信息--%>
                                    <select class="form-control" name="dId" >

                                    </select>
                                </div>
                            </div>


                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                    </div>
                </div>
            </div>
        </div>
       <%--员工修改模态框--%>
        <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >员工修改</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="empName_input" class="col-sm-2 control-label">empName</label>
                                <div class="col-sm-10">
                                    <p class="form-control-static "id="empName_update_static"></p>                                    <span  class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email_input" class="col-sm-2 control-label">email</label>
                                <div class="col-sm-10">
                                    <input type="email" name="email" class="form-control" id="email_update_input" placeholder="email@email.com">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label">gender</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender1_update_input" value="M" checked> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label">deptName</label>
                                <div class="col-sm-4">
                                    <%--部门信息--%>
                                    <select class="form-control" name="dId" >

                                    </select>
                                </div>
                            </div>


                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
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
    var totalRecord,currentNum;
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
           var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 编辑");
           //为编辑按钮添加一个自定义的属性,来表示当前员工的id
            editBtn.attr("edit-id",item.empId);
           var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm dele_btn")
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

        totalRecord=pageInfo.pages;//末页保存到全局变量中
        currentNum=pageInfo.pageNum;

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

    //点击新增按钮,弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //表单重置
         $("#empAddModal form")[0].reset();
            show_validate_msg("#empName_input");
            show_validate_msg("#email_input");
        //发送ajax请求,查出部门信息
        getDept("#empAddModal select");
        //弹出模态框
        $('#empAddModal').modal({
            backdrop:"static"
        })
    });

    //校验表单
    function validate_add_form() {
        //拿到校验数据,正则匹配
        var empName = $("#empName_input").val();
        var regName =  /(^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){5,16})|(^[\u2e80-\u9fff]{2,5})$/;
        if(!regName.test(empName)){
            //alert("用户名可以上2-5位中文或6-16位英文和数字的组合");
            show_validate_msg("#empName_input","error","用户名可以上2-5位中文或6-16位英文和数字的合法组合");
            return false;
        }else {
            show_validate_msg("#empName_input","success","");
        }
        var email=$("#email_input").val();
        var regEmail = /^([0-9A-Za-z\-_\.]+)@([0-9A-Za-z]+\.[A-Za-z]{2,3}(\.[A-Za-z]{2})?)$/g;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            show_validate_msg("#email_input","error","邮箱格式不正确");
            return false;
        }else {
            show_validate_msg("#email_input","success","");
        }
        return true;
    }
    function show_validate_msg(ele,status,msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }

    }
    //校验用户名是否可用
    $("#empName_input").change(function () {
        //发送ajax
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkUser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                console.log(result);
                if(result.code==200 ){
                    console.log(result.code);
                    show_validate_msg("#empName_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax_va","success");
                }else {
                    show_validate_msg("#empName_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax_va","error");
                }
            }

        });
    });

    //点击保存,保存员工
    $("#emp_save_btn").click(function () {
        //校验表单数据

        //ajax数据
       if($(this).attr("ajax_va")=="error"){
            return false;
       }else {
           if(!validate_add_form()){
               return false;
           }
       }
        //发送ajax保存信息
        $.ajax({
            url:"${APP_PATH}/addemp",
            data:$("#empAddModal form").serialize(),
            type:"POST",
            success:function (result) {
                console.log(result);
                if(result.code==200){
                    //关闭模态框
                    $("#empAddModal").modal('hide');
                    to_page(totalRecord);
                }else {
                    if(undefined!=result.extend.errorFields.name){
                        show_validate_msg("#empName_input","error",result.extend.errorFields.name);
                    }
                    if(undefined!=result.extend.errorFields.email){
                        show_validate_msg("#email_input","error",result.extend.errorFields.email);
                    }
                }


            }
        });
    });

    //获得部门信息
    function getDept(ele) {
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                //$("#empAddModal select").empty();
                $(ele).empty();
                console.log(result);
                $.each(result.extend.depts,function (){

                    var optionsEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    //optionsEle.appendTo($("#empAddModal select"));
                    optionsEle.appendTo($(ele));
                });
            }
        });
    }

    //为编辑按键绑定事件
$(document).on("click",".edit_btn",function () {
    //alert("qq");
    //查出部门列表
    getDept("#empUpdateModal select");
    //查出员工信息
    getEmp($(this).attr("edit-id"));

    //把员工ID传递给模态框
    $("#emp_update_btn").attr("edit_id",$(this).attr("edit-id"))
    $("#empUpdateModal").modal({backdrop:"static"});
})
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                console.log(result);
                var empData=result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }
    $("#emp_update_btn").click(function () {
        //验证邮箱合法性
        console.log(this);
        var email=$("#email_updata_input").val();
        var regEmail = /^([0-9A-Za-z\-_\.]+)@([0-9A-Za-z]+\.[A-Za-z]{2,3}(\.[A-Za-z]{2})?)$/g;
        if(!regEmail.test(email)){
            show_validate_msg("#email_updata_input","error","邮箱不合法");
           // return false;
        }else {
            show_validate_msg("#email_updata_input","success","");
        }
        //console.log($('#emp_update_btn').attr('edit_id'));
        //发送ajax 更新数据
        <%--$.ajax({--%>
            <%--url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),--%>
            <%--type:"POST",--%>
            <%--data:$("#empUpdateModal form").serialize()+"&_method=PUT",--%>
            <%--success:function (result) {--%>
                <%--console.log(result);--%>
            <%--}--%>
        <%--});--%>
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                console.log(result);
                //关闭模态框
                $("#empUpdateModal").modal("hide");
                //回到本页
                to_page(currentNum);

            }
        });

    });
</script>
</body>
</html>

