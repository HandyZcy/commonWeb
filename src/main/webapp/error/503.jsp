<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html >
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>懒人用卡- 403页面</title>

    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
	<link rel="shortcut icon" href="favicon.ico"> <link href="<%=path%>/admin/css/bootstrap.min14ed.css" rel="stylesheet">
    <link href="<%=path%>/admin/css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="<%=path%>/admin/css/animate.min.css" rel="stylesheet">
    <link href="<%=path%>/admin/css/style.min862f.css" rel="stylesheet">
</head>

<body class="gray-bg">
    <div class="middle-box text-center animated fadeInDown">
        <h1>403</h1>
        <h3 class="font-bold">您没有访问权限！</h3>

        <div class="error-desc">
           请联系管理员...
        </div>
    </div>
    <script type="text/javascript" src="<%=path%>/admin/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/admin/js/bootstrap.min.js"></script>
</body>
</html>