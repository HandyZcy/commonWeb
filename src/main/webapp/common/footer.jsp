<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<style type="text/css">
.loading {width:100%; bottom:0px; background: rgba(0,0,0,.6);z-index:10; }
.loading {width:100%;text-align: center;position:fixed;left:0px; top: -30px}

</style>

<div id="loading" class="loading hidden"  style="width: 100%">
<div class="spiner-example">
<div class="sk-spinner sk-spinner-chasing-dots" style="width: 50px; height: 50px">
<div class="sk-dot1"></div>
<div class="sk-dot2"></div>
</div>
</div>
</div>
