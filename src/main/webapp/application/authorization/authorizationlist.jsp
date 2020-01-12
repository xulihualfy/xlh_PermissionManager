<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/10/13
  Time: 13:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath() +"/"%>"/>
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <title>用户-角色-权限列表</title>
</head>
<body>


<div class="pd-20">

    <div class="row cl">
        <label class="form-label col-1">角色：</label>
        <div class="formControls col-2">
                <span class="select-box" style="width:150px;">
                    <select id="role" class="select" name="id" size="1">
                        <option value="">请选择</option>
                        <c:forEach items="${role}" var="role">
                        <option value="${role.id}">${role.roleName}</option>
                        </c:forEach>
                    </select>
                </span>
        </div>

        <label class="form-label col-1">授权类型：</label>
        <div class="formControls col-2">
                <span class="select-box" style="width:150px;">
                    <select id="Type" class="select" name="menuType" size="1">
                         <option value="">请选择</option>
                        <option value="1">权限</option>
                        <option value="2">人员</option>
                    </select>
                </span>
        </div>

        <div class="cl pd-5">
            <button type="button"  onclick="queryAuth()"
                    class="btn btn-success radius" id="" name="">
                <i class="Hui-iconfont">&#xe665;</i> 搜索
            </button>
        </div>

        <div class="col-4"> </div>
    </div>


    <div class="cl pd-5 bg-1 bk-gray">
        <span class="l">
            <a href="javascript:;" onclick="authUser()"
               class="btn btn-primary radius">
                <i class="Hui-iconfont">&#xe600;</i>
                授权用户
            </a>
            <a class="btn btn-primary radius" href="javascript:;"
               onclick="toAuthMenu()">
                <i class="Hui-iconfont">&#xe600;
                </i> 授权菜单
            </a>
        </span>
    </div>
    <table id="role-auth-user" class="table table-border table-bordered table-hover table-bg">

    </table>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript" src="js/batch-util.js"></script>
<script type="text/javascript">
    function queryAuth() {
       
    //判断用户是否选择了查询条件

       var roleid= $("#role").val();
       var type= $("#Type").val();
        let is = isChoose(roleid,type);
        if (!is) {
            return;
        }

        if (type==1){//根据角色的id来查询权限
            //table加载后台返回的数据
            $("#role-auth-user").load("auth/getAuthByRoleId/"+roleid);

        } else {//根据角色的id来查询用户
            $("#role-auth-user").load("auth/getUserByRoleId/"+roleid);
        }

    }

    //对用户进行授权
    function authUser() {
        var roleid= $("#role").val();
        let is = isChoose(roleid,true);//校验是否选择了权限
        if (!is){
            return;
        }

        //弹出一个用户列表框，选择用户进行授权
        layer_show("用户列表","auth/toAuthUserList?rid="+roleid,800,500);
    }
    
    function toAuthMenu() {
        var roleid= $("#role").val();
        let is=isChoose(roleid,true);
        if (!is){
            return;
        }
        //弹出框，然后初始化树
        layer_show("授权菜单","application/authorization/menuZtree.jsp?rid="+roleid,500,500);
    }

    function isChoose(roleid,type) {
        debugger
        if (!roleid){
            alert("请选择角色");
            return false;
        }
        if (!type){
            alert("请选择授权类型");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
