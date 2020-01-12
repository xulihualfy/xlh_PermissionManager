
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <title>添加用户</title>
</head>
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-admin-add">
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>用户：</label>
            <div class="formControls col-5">
                <input value="哈哈哈" type="text"  class="input-text" value=""
                       placeholder="" id="username"
                       name="username"
                       datatype="*2-16" nullmsg="用户名不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">
                <span class="c-red">*</span>
                初始密码：
            </label>
            <div class="formControls col-5">
                <input type="password" name="password" placeholder="密码"
                       autocomplete="off" value="123456" class="input-text"
                       datatype="*6-20" nullmsg="密码不能为空">
            </div>
            <div class="col-4"> </div>
        </div>

        <div class="row cl">
            <label class="form-label col-3">
                <span class="c-red">*</span>
                确认密码：
            </label>
            <div class="formControls col-5">
                <input type="password" placeholder="密码"
                       autocomplete="off" value="123456"
                        class="input-text"
                       datatype="*"
                       recheck="password" errormsg="您两次输入的账号密码不一致！"
                >
            </div>
            <div class="col-4"> </div>
        </div>

        <div class="row cl">
            <label class="form-label col-3">
                <span class="c-red">*</span>
                性别：
            </label>
            <div class="formControls col-5 skin-minimal">
                <div class="radio-box">
                    <input type="radio" id="sex-1" value="1" checked="checked" name="sex"
                           datatype="*" nullmsg="请选择性别！">
                    <label for="sex-1">男</label>
                </div>
                <div class="radio-box">
                    <input type="radio" id="sex-2" value="0" name="sex">
                    <label for="sex-2">女</label>
                </div>
            </div>
            <div class="col-4"> </div>
        </div>

        <div class="row cl">
            <label class="form-label col-3">
                <span class="c-red">*</span>
                邮箱：
            </label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="123456@dd.com"
                       placeholder="@" name="email"
                       id="email" datatype="e" nullmsg="请输入邮箱！">
            </div>
            <div class="col-4"> </div>
        </div>

            <div class="col-4"> </div>

        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
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
<script type="text/javascript">
    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-admin-add").Validform({
            tiptype:2,
            //回调方法，表单验证通过后才会调用
            //添加用户，使用ajax来传值
            callback:function(form){

                //获取表单数据
                let formDate = getFormDate(form);
                //传递数据并且发送异步请求
                submit("user/addUser",formDate);
                return false;//表单检验成功这个方法如果没有返回或者返回true就会自动提交表单，使用ajax需要关闭自动提交表单
            }
        });
    });
</script>
</body>
</html>
