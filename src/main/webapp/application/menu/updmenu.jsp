<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath() +"/"%>"/>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
    <link href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <link href="lib/zTree/v3/css/demo.css" rel="stylesheet" type="text/css" />
    <title>添加权限</title>
</head>
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-menu-edit">
    <input type="hidden" name="id" value="${menu.id}">
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>菜单名：</label>
            <div class="formControls col-5">
                <input type="text"  class="input-text" value="${menu.menuName}"
                       placeholder="" id="menuName"
                       name="menuName"
                       datatype="*2-16" nullmsg="菜单名不能为空">
            </div>
            <div class="col-4"> </div>
        </div>

    <div class="row cl">
        <label class="form-label col-3">菜单类型：</label>
            <div class="formControls col-5">
                <span class="select-box" style="width:150px;">
                    <select class="select" name="menuType" size="1">
                         <option value="1" <c:if test="${menu.menuType eq 2}">selected="selected"</c:if>  >目录</option>
                        <option value="2" <c:if test="${menu.menuType eq 2}">selected="selected"</c:if>>菜单</option>
                        <option value="3" <c:if test="${menu.menuType eq 3}"> selected="selected"</c:if>>按钮</option>
                    </select>
                </span>
            </div>
    </div>

        <div class="row cl">
            <label class="form-label col-3">
                url：
            </label>
            <div class="formControls col-5">
                <input type="text" name="menuUrl" value="${menu.menuUrl}"
                        class="input-text">
            </div>
            <div class="col-4"> </div>
        </div>

        <div class="row cl">
            <label class="form-label col-3">
                权限码：
            </label>
            <div class="formControls col-5">
                <input type="text"
                       autocomplete="off" value="${menu.menuCode}"
                        class="input-text" name="menuCode"
                >
            </div>
            <div class="col-4"> </div>
        </div>



        <div class="row cl">
            <label class="form-label col-3">
                描述
            </label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="${menu.menuDesc}"
                        name="menuDesc"
                       id="menuDesc">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">
            父菜单：
            </label>
            <div class="formControls col-5">
                <input type="text" id="parentMenuName"
                    disabled="disabled" class="input-text" value="${menu.menuPname}">
                <input type="hidden" id="parentMenuId" name="menuPid"
                    class="input-text">
            </div>
            <div class="col-3"> </div>
                <input
                    onclick="parentmenu_add()"
                    class="btn btn-primary radius"  type="button" value="&nbsp;&nbsp;选择父菜单&nbsp;&nbsp;"/>
                <br>
        </div>

        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius"
    type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript" src="js/user-util.js"></script>
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.core-3.5.js"></script> <script type="text/javascript" src="js/ztree-util.js"></script>
    <script type="text/javascript">
    $(function(){


        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-menu-edit").Validform({
            tiptype:2,
            //回调方法，表单验证通过后才会调用
            //添加用户，使用ajax来传值
            callback:function(form){

                //获取表单数据
                let formDate = getFormDate(form);
                //传递数据并且发送异步请求
                submit("menu/updMenu",formDate);
                return false;//表单检验成功这个方法如果没有返回或者返回true就会自动提交表单，使用ajax需要关闭自动提交表单
            }
        });


    });

    //弹出框
    function parentmenu_add(){
    //调用显示出弹出框方法
    show();
    };


    </script>
</body>
</html>
