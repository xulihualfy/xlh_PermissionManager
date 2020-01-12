<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/10/14
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<TITLE> ZTREE DEMO </TITLE>
<base href="<%=request.getContextPath() +"/"%>"/>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="lib/zTree/v3/css/demo.css" type="text/css">
<link rel="stylesheet" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="js/ztree-util.js"></script>
<script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script>

<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="js/user-util.js"></script>
<SCRIPT LANGUAGE="JavaScript">
    var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        check: {//扩展包里面的可勾选的方法
            enable: true,
            chkStyle: "checkbox",
            chkboxType: { "Y" : "s", "N" : "ps" }//Y:表示勾选，N：表示取消勾选 ps：表示父子关联
        }
    };
    // zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）
    var zNodes =[];
    $(document).ready(function(){
        //获取传过来的rid
        var rid=${param.rid};

        //发送异步请求获取树节点里面的数据（从后台获取）
        $.get("auth/getAuthMenuList/"+rid,"",function (data) {
            let format1 = format(data);
            //alert(format1);
            zNodes=format1;
        zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        });
    });
</SCRIPT>
</HEAD>
<BODY>
<input type="button" value="确定" onclick="authMenu()">
<div>
    <ul id="treeDemo" class="ztree"></ul>
</div>

<script>
    //给角色添加菜单权限
    function authMenu() {
        //获取到这个树容器（通过id）
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        //获取勾选的树节点
        var nodes = treeObj.getCheckedNodes(true);

        var MenunodeIds=new Array();

        //遍历(json对象)选中的节点id并且封装到集合里面

        nodes.forEach(x => {
            MenunodeIds.push(x.id);
        });

        //把数组封装到对象中去
        var param=new Object();
        param.ids=MenunodeIds;
        //获取到角色id
        var id=${param.rid};
        //封装到对象中去
        param.rid=id;
        //发送异步请求，把数据传到后台
        $.post("auth/addAuthMenu",param,function (data) {
            if (data.state=='SUCCESS'){
                layer.msg(data.msg,{ico: 1,time:1000},function () {
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.$('.btn-refresh').click();
                    parent.layer.close(index);
                });

            }else {
                layer.msg(data.msg,{
                    ico: 2,
                    time:1000
                },function () {
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.$('.btn-refresh').click();
                    parent.layer.close(index);
                });
            }
        })

    }

</script>
</BODY>
</html>
