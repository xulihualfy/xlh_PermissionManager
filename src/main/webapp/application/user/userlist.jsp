
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<htlm>
<head>
    <base href="<%=request.getContextPath() +"/"%>"/>
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <title>用户列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;
</i> 首页 <span class="c-gray en">&gt;
</span> 管理员管理 <span class="c-gray en">&gt;</span>
    管理员列表
    <a class="btn btn-success radius r mr-20"
       style="line-height:1.6em;margin-top:3px"
       href="javascript:location.replace(location.href);"
       title="刷新" ><i class="Hui-iconfont">&#xe68f;</i>
    </a>
</nav>
<div class="pd-20">
    <form method="post" action="/user/getPage">
    <div class="text-c">
        <div class="row cl ">
            <div class="formControls col-3">
                用户名: <input type="text" value="${user.username}" name="username" class="input-text" style="width: 250px">
            </div>
            <div class="formControls col-4">
                邮箱： <input type="text" value="${user.email}" name="email" class="input-text" style="width: 250px">
            </div>

        </div>
        <div class="row cl">
            <div class="cl pd-5">
                <button type="submit"
                        class="btn btn-success radius" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i> 搜用户
                </button>
                <button type="button"
                        onclick="location.replace(location.href);"
                        class="btn btn-success radius" name="">
                    <i class="Hui-iconfont">&#xe66b;</i> 重置
                </button>
            </div>
        </div>


    </div>
    </form>
    <shiro:hasPermission name="user:delete">  <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
        <a href="javascript:;" onclick="batchDel()"
           class="btn btn-danger radius">
            <i class="Hui-iconfont">&#xe6e2;
            </i> 批量删除</a></shiro:hasPermission>
       <shiro:hasPermission name="user:add"> <a href="javascript:;"
           onclick="adduser('添加用户','application/user/adduser.jsp','800','500')"
           class="btn btn-primary radius">
            <i class="Hui-iconfont">&#xe600;
            </i> 添加用户</a></shiro:hasPermission>
    </span>
        <span class="r">共有数据：<strong>${page.total}</strong> 条</span>
    </div>
    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="9">用户列表</th>
        </tr>

        <tr class="text-c">
            <th width="25"><input type="checkbox" name="chck_all" value=""></th>
            <th width="40">ID</th>
            <th width="150">用户名</th>
            <th width="150">邮箱</th>
            <th width="130">性别</th>
            <th width="100">时间</th>
            <th width="100">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.records}" var="user">
        <tr class="text-c">
            <td><input type="checkbox" value="${user.id}" name="chck_one"></td>
            <td>${user.id}</td>
            <td>${user.username}</td>
            <td>${user.email}</td>
            <td><c:if test="${user.sex eq 1}">男</c:if>
                <c:if test="${user.sex eq 0}">女</c:if></td>
            <td><f:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></f:formatDate></td>

            <%--<td class="td-status"><span class="label label-success radius">已启用</span></td>--%>
            <td class="td-manage">

                <shiro:hasPermission name="user:update"><a title="编辑" href="javascript:;"
                   onclick="user_edit('编辑','user/getUserById/${user.id}','1','800','500')"
                   class="ml-5" style="text-decoration:none">
                    <i class="Hui-iconfont">&#xe6df;</i>
                </a></shiro:hasPermission>
                <shiro:hasPermission name="user:delete"> <a title="删除" href="javascript:;"
                   onclick="user_del(this,${user.id})"
                   class="ml-5" style="text-decoration:none">
                    <i class="Hui-iconfont">&#xe6e2;</i>
                </a> </shiro:hasPermission>
            </td>
        </tr>
        </c:forEach>

        </tbody>
    </table>
    <jsp:include page="/common/page.jsp"/>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript" src="js/batch-util.js"></script>
<script type="text/javascript">
    /*
        参数解释：
        title	标题
        url		请求的url
        id		需要操作的数据id
        w		弹出层宽度（缺省调默认值）
        h		弹出层高度（缺省调默认值）
    */
    /*管理员-增加*/
    function adduser(title,url,w,h){
        layer_show(title,url,w,h);
    }

    /*
    批量删除
    */
    
    function batchDel() {
        var one=$("input[name='chck_one']:checked");
        allBatchDel(one,"user/batchDel")
    }
    /*管理员-删除*/
    function user_del(obj,uid){
        layer.confirm('确认要删除吗？',function(index){
            //此处请求后台程序，下方是成功后的前台处理……

            $.ajax({

            type:"post",
            url:"user/delUser",
            data:{"uid":uid},
            success:function (result) {
                if (result.state=='SUCCESS'){
                    $(obj).parents("tr").remove();
                    layer.msg('已删除!',{icon:1,time:1000});
                    /*location.reload();*/
                } else {
                    layer.msg('删除失败!',{icon:2,time:1000});
                }
            }
            });

            /*$.post("user/delUser",uid,function () {
                $(obj).parents("tr").remove();
                layer.msg('已删除!',{icon:1,time:1000});
            })*/


        });
    }
    /*管理员-编辑*/
    function user_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-停用*/
    function admin_stop(obj,id){
        layer.confirm('确认要停用吗？',function(index){
            //此处请求后台程序，下方是成功后的前台处理……

            $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_start(this,id)" href="javascript:;" title="启用" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">已禁用</span>');
            $(obj).remove();
            layer.msg('已停用!',{icon: 5,time:1000});
        });
    }

    /*管理员-启用*/
    function admin_start(obj,id){
        layer.confirm('确认要启用吗？',function(index){
            //此处请求后台程序，下方是成功后的前台处理……


            $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_stop(this,id)" href="javascript:;" title="停用" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
            $(obj).remove();
            layer.msg('已启用!', {icon: 6,time:1000});
        });
    }
</script>
</body>
</htlm>
