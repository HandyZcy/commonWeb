<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="mask" class="mask">正在处理中。。。。。。</div>  
<script>
//兼容火狐、IE8   
//显示遮罩层    
function showMask(){     
    $("#mask").css("height",$(document).height());     
    $("#mask").css("width",$(document).width());     
    $("#mask").show();     
}  
//隐藏遮罩层  
function hideMask(){     
    $("#mask").hide();     
}  
hideMask(); 
</script>