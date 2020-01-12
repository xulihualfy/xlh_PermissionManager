
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<htlm>
<head>
    <base href="<%=request.getContextPath() +"/"%>"/>
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="9">权限信息列表</th>
        </tr>

        <tr class="text-c">
            <th width="25"><input type="checkbox" name="chck_all" value=""></th>
            <th width="40">ID</th>
            <th width="150">权限名</th>
            <th width="90">权限类型</th>
            <th width="90">父菜单</th>
            <th width="100">操作</th>
        </tr>
        </thead>
        <tbody>`
        <c:forEach items="${menu}" var="menu">
        <tr class="text-c">
            <td><input type="checkbox" value="${menu.id}" name="chck_one"></td>
            <td>${menu.id}</td>
            <td>${menu.menuName}</td>
            <td>
                <c:choose>

                    <c:when test="${menu.menuType == 1}">
                        目录
                    </c:when><c:when test="${menu.menuType == 2}">
                    菜单
                </c:when>

                    <c:otherwise>
                        按钮
                    </c:otherwise>
                </c:choose>
            </td>
            <td>${menu.menuPname}</td>

            <td class="td-manage">
                <a title="删除" href="javascript:;"
                   onclick="Menu_delAuth(this,${menu.id})"
                   class="ml-5" style="text-decoration:none">
                    <i class="Hui-iconfont">&#xe6e2;</i>
                </a></td>
        </tr>
        </c:forEach>

        </tbody>
    </table>


<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript" src="js/batch-util.js"></script>
<script type="text/javascript" src="js/user-util.js"></script>
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
    function Menu_delAuth(obj,pid){
        layer.confirm('确认要取消该权限吗？',function(index){
            //此处请求后台程序，下方是成功后的前台处理……

            $.ajax({

            type:"post",
            url:"auth/delMenuAuth",
            data:{"pid":pid},
            success:function (result) {
                response_user(result);
            }
            });
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
