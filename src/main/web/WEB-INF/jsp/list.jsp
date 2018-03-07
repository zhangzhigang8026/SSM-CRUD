<%--
  Created by IntelliJ IDEA.
  User: Zhang
  Date: 2018/3/7
  Time: 13:57
  To change this template use File | Settings | File Templates.
--%>
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
            <button class="btn bg-primary">新增</button>
            <button class="btn bg-danger">删除</button>
        </div>
    </div>
        <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <td>#</td>
                    <td>empName</td>
                    <td>gender</td>
                    <td>email</td>
                    <td>deptName</td>
                    <td>操作</td>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <td>${emp.empId}</td>
                        <td>${emp.empName}</td>
                        <td>${emp.gender=="M"?"男":"女"}</td>
                        <td>${emp.email}</td>
                        <td>${emp.department.deptName}</td>
                        <td>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td>1</td>
                    <td>zhang</td>
                    <td>M</td>
                    <td>113225@163.com</td>
                    <td>研发</td>
                    <td>
                        <button class="btn btn-primary btn-sm">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            编辑
                        </button>
                        <button class="btn btn-danger btn-sm">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            删除
                        </button>
                    </td>
                </tr>


            </table>
        </div>
    </div>
        <%--显示分页--%>
    <div class="row">
       <div class="col-md-6">
           当前${pageInfo.pageNum}页，共${pageInfo.pages}页，总${pageInfo.total}
       </div>
        <%--分页信息--%>
       <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="${APP_PATH}/emps?pn=1">首页</a>
                    </li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num == pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_Num}</a></li>
                        </c:if>
                        <c:if test="${page_Num != pageInfo.pageNum}">
                            <li ><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                        </c:if>

                    </c:forEach>

                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <li>
                        <a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a>
                    </li>
                </ul>
            </nav>
       </div>
    </div>

</div>
</body>
</html>
