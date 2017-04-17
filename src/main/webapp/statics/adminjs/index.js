//解决session过期点击菜单出错问题begin
$.ajaxSetup({  
    contentType:"application/x-www-form-urlencoded;charset=utf-8",  
    error:function(XMLHttpRequest,textStatus){  
        if(textStatus=="parsererror"){  
            window.location = mainpath;  
        }  
    }
});

$(document).ready(function(){
	$("#update-adminuser-btn").click(updateadminusermodal);
	$("#update-adminuser-btn-do").click(updateadminuser);
	$("#update-adminuser-btn2").click(updateadminusermodal2);
	$("#update-adminuser-btn2-do").click(updateadminuser2);
	
	//加载导航
	afterUtil("#homeLi", null, mainpath+"/getMenuList", printMenu, false);
	
	//加载上次最后访问url
	addUrl();
});


function printMenu(data){
	var keyList = data;  
	treeHtml = "";
	for(var i=0;i<keyList.length;i++){ 
	 if(keyList[i].type == 0 ){
		 treeHtml += "<li>"; 
		 treeHtml += "	<a href=\"#\">";
		 treeHtml += "		<span class=\"nav-label\">"+keyList[i].name+"</span>";
		 treeHtml += "		<span class=\"fa arrow\"></span>";
		 treeHtml += "	</a>"; 
		 var menuChildren = keyList[i].children
		 if(isEmpty(menuChildren)){
			 continue;
		 }
		 treeHtml += "	<ul class=\"nav nav-second-level\">";
		 for(var j=0;j<menuChildren.length;j++){
			if(menuChildren[j].children == null){
				treeHtml += "<li><a onclick=\"addCookie(this)\" id=\""+menuChildren.id+"\" class=\"J_menuItem\" href=\""+menuChildren[j].link+"\">"+menuChildren[j].name+"</a></li>";
			}else if(menuChildren[j].children != null && menuChildren[j].type == 1 ){
				treeHtml += "<li>"; 
				treeHtml += "	<a href=\"#\">";
				treeHtml += "		<span class=\"nav-label\">"+keyList[i].name+"</span>";
				treeHtml += "		<span class=\"fa arrow\"></span>";
				treeHtml += "	</a>"; 
				//treeHtml += "	<ul class=\"nav nav-second-level\">";
				treeHtml += "</li>";
			}else if(menuChildren[j].children != null){
				getTree(menuChildren[j])
			}
		 }
		 treeHtml += "	</ul>"; 
		 treeHtml += "</li>";
	 }else if(keyList[i].type == 1){
		 treeHtml += "<li>"; 
		 treeHtml += "	<a onclick=\"addCookie(this)\" id=\""+keyList[i].id+"\" class=\"J_menuItem\" href=\""+keyList[i].link+"\" >"+keyList[i].name+"</a>"; 
		 treeHtml += "</li>"; 
	 }
	}
	return treeHtml;
}

function getTree(menuTree){
	treeHtml += "<li>"; 
	treeHtml += "	<a href=\"#\" ";
	treeHtml += "		<span class=\"nav-label\">"+menuTree.name+"</span>";
	treeHtml += "		<span class=\"fa arrow\"></span>";
	treeHtml += "	</a>";
	var menuChildren = menuTree.children
	treeHtml += "	<ul class=\"nav nav-second-level\">"; 
	for(var j=0;j<menuChildren.length;j++){
		if(menuChildren[j].type == 1){
			treeHtml += "<li><a onclick=\"addCookie(this)\" id=\""+menuChildren[j].id+"\" class=\"J_menuItem\" href=\""+menuChildren[j].link+"\">"+menuChildren[j].name+"</a></li>"; 
		}else if(menuChildren[j].children != null && menuChildren[j].type == 0){
			treeHtml += "		<li>"; 
			getTree(menuChildren[j]);
			treeHtml += "		</li>"; 
		}
	}
	treeHtml += "	</ul>"; 
	treeHtml += "</li>"; 
}


function addCookie(obj){
	var cookie = $(obj).attr("id");
	setCookie("url",cookie);
}


function setCookie(name,value) 
{ 
    var Days = 30; 
    var exp = new Date(); 
    exp.setTime(exp.getTime() + Days*24*60*60*1000); 
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString(); 
} 

//读取cookies 
function getCookie(name) 
{ 
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
 
    if(arr=document.cookie.match(reg))
 
        return unescape(arr[2]); 
    else 
        return null; 
} 

//删除cookies 
function delCookie(name) 
{ 
    var exp = new Date(); 
    exp.setTime(exp.getTime() - 1); 
    var cval=getCookie(name); 
    if(cval!=null) 
        document.cookie= name + "="+cval+";expires="+exp.toGMTString(); 
} 

function addUrl(){
	var id = getCookie("url") ;
	if(notEmpty(id)){
		$("#"+id).trigger("click");
	}
}


function updateadminusermodal(){
	$("#update-adminuser-modal").modal({backdrop: 'static', keyboard: false}).modal("show");
}

function updateadminuser(){
	$.validator.setDefaults({
	    submitHandler: function() {
	    	var oldPwd = $("#oldpwd").val();
	    	var newPwd = $("#newpwd").val();
	    	$("#update-adminuser-modal").modal("hide");
    		deleteMsg("您确定要修改密码吗？", "是的,我要修改!", "让我在考虑一下...", function(){
    			ajaxUtil({
    				"oldPassword" : oldPwd,
    				"newPassword" : newPwd
    			}, path+"/changeAdminUserPassword.shtml", function(data) {
    				if(data > 0){
    					showMsg("修改成功");
    				}else{
    					 if(data == -1){
	    					showErrorMsg("旧密码错误");
	    				}else{
	    					showErrorMsg("修改失败");
	    				}
    					$("#update-adminuser-modal").modal({backdrop: 'static', keyboard: false}).modal("show");
    				}
    			},function(){
    				showErrorMsg("修改失败");
					$("#update-adminuser-modal").modal({backdrop: 'static', keyboard: false}).modal("show");
    			});
    		});
	    }
	});
	$("#update-adminuser-form").validate();
}

	
function updateadminusermodal2(){
	$("#update-adminuser-modal2").modal({backdrop: 'static', keyboard: false}).modal("show");
}

function formValidator(){
	
	$("#update-adminuser-form2").validate({
	    rules: {
	      nickname: {
	    	  required:true,
	    	  maxlength: 18
	      },
	      phone: {
	        //required: true,
	        checkPhone: true
	      }
	    },
	    messages: {
	      nickname: {
	    	  required:"请输入用户昵称",
	    	  maxlength: "用户昵称最长18位"
	      },
	      phone: {
	        //required: "请填写电话号码"
	      }
	    }
	});
}


//自定手机号验证方法
$.validator.addMethod(
	"checkPhone", //验证方法名称
	function(value, element) {//验证规则
		if(isEmpty(value)){
			return true;
		}
    	var pattern =/^1\d{10}$/;    
    	if(!pattern.exec(value)){
    		return false;
    	}
        return true;
	}, 
	'请输入正确的电话'//验证提示信息
);

function updateadminuser2(){
	$.validator.setDefaults({
		submitHandler: function() {
			$("#update-adminuser-modal2").modal("hide");
			ajaxSubmitRefresh("#update-adminuser-form2");
		}
	});
	formValidator();
}

function redictUrl(){
 window.location.replace("/lazypower-manager/page/admin/index.shtml");
}



