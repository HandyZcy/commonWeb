<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
   
%>
<!DOCTYPE html >
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>欢迎登录后台管理系统</title>
	
	<link rel="shortcut icon" href="favicon.ico"> <link href="<%=path%>/statics/css/bootstrap.min14ed.css" rel="stylesheet">
	<link href="<%=path%>/statics/css/font-awesome.min93e3.css" rel="stylesheet">
	
	<link href="<%=path%>/statics/css/animate.min.css" rel="stylesheet">
	<link href="<%=path%>/statics/css/style.min862f.css" rel="stylesheet">
	<!--[if lt IE 9]>
	<meta http-equiv="refresh" content="0;ie.html" />
	<![endif]-->
	<script>if(window.top !== window.self){ window.top.location = window.location;}</script>
</head>

<body class="gray-bg">
	<div class="">
        <div style="text-align: center;">
            <div>
               <div style="text-align: center;">
               	<h6 class="logo-name" style="font-size: 110px;">CM</h6>
               </div>
            </div>
            <div class="middle-box text-center loginscreen  animated fadeInDown">
            <h3>欢迎使用后台管理系统</h3>
            
            <form class="m-t" role="form" action="login" method="post">
                <div class="form-group">
                    <input type="email" name="nickname" class="form-control" placeholder="请输入用户名">
                </div>
                <div class="form-group">
                    <input type="password" name="pwd" class="form-control" placeholder="密码">
                </div>
                <button type="submit" id="add-submit" class="btn btn-primary block full-width m-b">登 录</button>

                <!-- <p class="text-muted text-center"> <a href="login.html#"><small>忘记密码了？</small></a> | <a href="register.html">注册一个新账号</a> </p>-->
                
            </form>
            </div>
        </div>
    </div>
    
    <script type="text/javascript" src="<%=path%>/statics/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/statics/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function() {
			if (event.keyCode == 13) {
				$("#add-submit").trigger("submit");
			}
		})
	</script>
</body>
</html>
