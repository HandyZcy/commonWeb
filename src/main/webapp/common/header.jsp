<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<LINK rel="Bookmark" href="${path}/statics/img/favicon.ico" >
<!--[if lt IE 9]>
   <meta http-equiv="refresh" content="0;ie.html" />
   <![endif]-->
<link rel="shortcut icon" href="${path}/statics/img/favicon.ico"> 
<link href="${path}/statics/css/bootstrap.min14ed.css" rel="stylesheet">
<link href="${path}/statics/css/font-awesome.min93e3.css" rel="stylesheet">
<link href="${path}/statics/css/animate.min.css" rel="stylesheet">
<link href="${path}/statics/css/style.min862f.css" rel="stylesheet">
<link href="${path}/statics/css/plugins/sweetalert/sweetalert.css" rel="stylesheet"> 

<script type="text/javascript" src="${path}/statics/js/jquery.min.js"></script>
<script type="text/javascript" src="${path}/statics/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${path}/statics/js/plugins/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript" src="${path}/statics/js/plugins/layer/layer.min.js"></script>
<script type="text/javascript" src="${path}/statics/js/content.min.js"></script>
<script type="text/javascript" src="${path}/statics/js/welcome.min.js"></script>
    
<script type="text/javascript" src="${path}/statics/js/jquery.form.js"></script>

<script type="text/javascript" src="${path}/statics/adminjs/common.js"></script>

<script type="text/javascript">
$(function(){
   var notice = '${notice}';
   if(notice != null && notice!=''){
	   layer.msg(notice,{icon: 6,time:2000});
   }
});
</script>

<!--[if IE 6]>
<script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
