function allBatchDel(checkObj,url) {
    //创建一个数组来接受被选择的id
    var idArray=new Array();

    //获取被选择的对象id，装到数组里面
    checkObj.each(function (index,obj) {
        idArray.push($(obj).val())
    });
    //把获取到的id值传到后台（把数组装到对象里面再传过去）
    var param=new Object();
    param.ids=idArray;

    $.post(url,param,function () {
        location.reload();
    })
}