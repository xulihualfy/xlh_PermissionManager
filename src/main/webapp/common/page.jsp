<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=request.getContextPath() +"/"%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="js/layui/css/layui.css" media="all">
<!-- <link rel="stylesheet" href="js/layui/css/layui.css"> -->
<!-- <script src="js/layui/layui.js" charset="utf-8"></script> -->
<script src="js/layui/layui.js"></script>
</head>
<body>
<div id="demo7"></div>
</body>
<script type="text/javascript">
layui.use('laypage', function(){
  var laypage = layui.laypage;
  
  //完整功能
  laypage.render({
    elem: 'demo7'
    ,curr:${page.current}//当前页面
    ,count: ${page.total}//总条数
    ,limit:${page.size}//每页需要展示的条数
    ,limits:[5, 10, 15, 20, 30]//每页需要展示的条数的选择项
    ,layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']
    ,jump: function(obj, first){//回调函数，跳转页面使用
        //obj包含了当前分页的所有参数，比如：
        console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
        console.log(obj.limit); //得到每页显示的条数
        
        //首次不执行
        if(!first){
          //do something
          window.location.href="${url}?current="+obj.curr+"&size="+obj.limit;
        }
      }
  });
});</script>
</html>
