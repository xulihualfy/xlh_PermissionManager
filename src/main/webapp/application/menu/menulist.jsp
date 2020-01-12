
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath() +"/"%>"/>
    <title>权限列表页面</title>
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</head>
<body>
<nav class="breadcrumb">
    <i class="Hui-iconfont">&#xe67f;</i>
    首页 <span class="c-gray en">&gt;
    </span> 管理员管理 <span class="c-gray en">&gt;
    </span> 权限管理
    <a class="btn btn-success radius r mr-20"
    style="line-height:1.6em;margin-top:3px"
    href="javascript:location.replace(location.href);"
    title="刷新" ><i class="Hui-iconfont">&#xe68f;</i>
    </a>
    </nav>
<%--<div class="pd-20">
    <div class="text-c">
        <form class="Huiform" method="post" action="" target="_self">
            <input type="text" class="input-text" style="width:250px"
    placeholder="权限名称" id="" name="">
            <button type="submit" class="btn btn-success"  name="">
    <i class="Hui-iconfont">&#xe665;</i> 搜权限节点</button>
        </form>
    </div>--%>
    <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
    <a href="javascript:;" onclick="datadel()"
    class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>
    批量删除</a> <a href="javascript:;"
    onclick="menu_add('添加权限节点','application/menu/addmenu.jsp','800','500')"
    class="btn btn-primary radius">
    <i class="Hui-iconfont">&#xe600;
    </i> 添加权限节点</a></span> <span class="r">
    共有数据：<strong>${page.total}</strong> 条</span> </div>
    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="7">权限节点</th>
        </tr>
        <tr class="text-c">
            <th width="40">ID</th>
            <th width="100">名称</th>
            <th width="50">类型</th>
            <th width="100">url</th>
            <th width="100">权限码</th>
            <th width="40">父菜单</th>
            <th width="40">操作</th>
        </tr>
        </thead>
        <tbody>

    <c:forEach items="${page.records}" var="menu">
        <tr class="text-c">
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
            <td>${menu.menuUrl}</td>
            <td>${menu.menuCode}</td>
            <td>${menu.menuPname}</td>

            <td><a title="编辑" href="javascript:;" onclick="menu_edit('角色编辑','menu/getMenuById/${menu.id}','800','','500')"
                class="ml-5" style="text-decoration:none">
                 <i class="Hui-iconfont">&#xe6df;</i>
                </a>
                <a title="删除" href="javascript:;" onclick="admin_permission_del(this,'1')" class="ml-5" style="text-decoration:none">
                <i class="Hui-iconfont">&#xe6e2;</i>
            </a>
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
<script type="text/javascript">
    /*
        参数解释：
        title	标题
        url		请求的url
        id		需要操作的数据id
        w		弹出层宽度（缺省调默认值）
        h		弹出层高度（缺省调默认值）
    */
    /*管理员-权限-添加*/
    function menu_add(title,url,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-权限-编辑*/
    function menu_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

    /*管理员-权限-删除*/
    function admin_permission_del(obj,id){
        layer.confirm('角色删除须谨慎，确认要删除吗？',function(index){
            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1000});
        });
    }
</script>
</body>
</html>
