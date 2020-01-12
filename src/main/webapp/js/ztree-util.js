/*
       弹出框
       */
function show() {
    var htmlStr = "";
    htmlStr += '<div style="width:300px;height:200px" >';
    htmlStr += '<div style=" line-height:30px; text-indent:10px; margin-bottom:20px; background-color:#eee; position:relative;">组织</div>';
    htmlStr += '<div style="display:block; padding-bottom:5px;" align="center"  >';
    htmlStr += '<div><table><tr><td><input type="hidden" id="tmp_pid" width="50px"/><input type="text" id="tmp_pname" width="50px"><button onclick="ParentMenu();">确定</button></td></tr></table></div>';
    htmlStr += '<div id="treeDemo" class="ztree"></div>';
    htmlStr += '</div>';
    htmlStr += '</div>';

    //调用弹出框的方法
    layer.open({
        type: 1,
        area: [300+'px', 400 +'px'],
        fix: false, //不固定
        maxmin: true,
        shade:0.4,
        title: '添加父菜单',
        content: htmlStr,

    });
    //调用初始化数的方法
    initZtree();
};

//初始化树插件
function initZtree() {

    var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        async: {//使用同步还是异步请求
            enable: true,//该属性设置成true表示使用异步请求
            url: "menu/getParentMenuById",//表示请求的地址
            autoParam: ["id"]//自动提交的参数
        },
        callback: {//回调函数，展示树结构之后调用，（给树结构点击事件）

            onClick: zTreeOnClick
        }

    };

    var zNodes=[];
    $(document).ready(function(){
        zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
    });
}


//ztree的点击事件  treeNode：表示的是树的节点对象
function zTreeOnClick(event, treeId, treeNode) {
    $("#tmp_pid").val(treeNode.id);
    $("#tmp_pname").val(treeNode.name);
};

//点击确定按钮的点击事件（选择父菜单）
//选择之后按确定按钮
function ParentMenu() {
    //把数据显示到添加页面
    $("#parentMenuName").val($("#tmp_pname").val());
    $("#parentMenuId").val($("#tmp_pid").val());
    //关闭弹出框
    layer.close(parent.layer.index);
}

function format(json){
    var ret = [], o = {};

    function add(arr, data){
        var obj = {
            "id": data.id,
            "pId": data.pid,
            "name":data.name,
            "open":true,
            "children": [],
            "checked":data.checked
        };
        o[data.id] = obj;
        arr.push(obj);
    }

    json.forEach(x => {
        if(o[x.pid]){
            add(o[x.pid].children, x);
        }else{
            add(ret, x);
        }
    });
    return ret;
}
