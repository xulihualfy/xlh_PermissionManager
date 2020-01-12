
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
    <title>用户列表</title>
</head>
<body>

<div class="pd-20">
    <form method="post" action="/auth/toAuthUserList/">
        <div class="text-c">
            <div class="row cl ">
                <div class="formControls col-3">
                    用户名: <input type="text" value="${user.username}" name="username" class="input-text" style="width: 250px">
                </div>
            </div>
            <div class="row cl">
                <div class="cl pd-5">
                    <button type="submit"
                            class="btn btn-success radius"  name="">
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
    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="9">用户列表</th>
        </tr>

        <tr class="text-c">
            <th width="25"><input type="checkbox" name="chck_all" value=""></th>
            <th width="40">ID</th>
            <th width="150">用户名</th>
            <th width="130">性别</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.records}" var="user">
        <tr class="text-c">
            <td><input type="checkbox" value="${user.id}" name="chck_one"></td>
            <td>${user.id}</td>
            <td>${user.username}</td>
            <td><c:if test="${user.sex eq 1}">男</c:if>
                <c:if test="${user.sex eq 0}">女</c:if></td>
        </tr>
        </c:forEach>

        </tbody>
    </table>

    <jsp:include page="/common/page.jsp"/>
</div>
<div class="row cl">
    <div class="cl pd-5">
        <button type="button" onclick="userPermission()"
                class="btn btn-success radius" id="" name="">
            <i class="Hui-iconfont">&#xe62d;</i> 授权
        </button>
    </div>
</div>
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
    /*管理员-授权*/
    function userPermission() {
        //获取到后台传送过来的角色id

        var id="${rid}";
        //获取到被选择的用户id
        var idArray=new Array();
        $("input[name='chck_one']:checked").each(function (index,obj) {
            idArray.push($(obj).val());
        });
        var param=new Object();
        param.rid=id;
        param.ids=idArray;
        
        $.post(
            "auth/addAuthToUser",
            param,
            function (data) {
                response_user(data);
            }
            
        )
    }




</script>
</body>

</htlm>
