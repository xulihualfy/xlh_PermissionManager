
/*
提交表单
url：请求路径
formData：表单的数据
 */
function submit(url,formData) {
    //使用ajax传值
    $.post(
        url,
        formData,
        function (result) {
            response_user(result);

}

    );
}

/*
获取表单数据
form:表单对象
 */
function getFormDate(form) {
//创建一个对象用来接收表单的数据
    var formuser=new Object();
    //获取表单的数据数组
    var forms=form.serializeArray();
    for (var i=0;i<forms.length;i++){
        formuser[forms[i].name]=forms[i].value;
    }
    //返回一个装载表单数据的对象
    return formuser;
}

//响应结果
function response_user(result) {
    if (result.state=='SUCCESS'){
        layer.msg(result.msg,{ico: 1,time:1000},function () {
            var index = parent.layer.getFrameIndex(window.name);
            parent.$('.btn-refresh').click();
            parent.layer.close(index);
            location.reload();//刷新页面
        });

    }else {
        layer.msg(result.msg,{ico: 2,time:1000},function () {
            var index = parent.layer.getFrameIndex(window.name);
            parent.$('.btn-refresh').click();
            parent.layer.close(index);
        });
    }
}