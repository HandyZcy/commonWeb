var path = "/commonWeb";
var mainpath = "/commonWeb";
var host = "commonWeb";
var urlhost = window.location.protocol +"//" + window.location.host;

var pageNo ="";
var pagingmain ;
var take = true;

$(document).ready(function(){
	document.onclick = function (event)  
    {     
        var e = event || window.event;  
        var elem = e.srcElement||e.target ;  
              
        while(elem)  
        {   
            if(elem.id == "right-sidebar-toggle" || elem.id == "right-sidebar" )  
            {  
            	if(elem.id == "right-sidebar-toggle"){
            		if($("#right-sidebar").hasClass("sidebar-open")){
            			 $("#right-sidebar").removeClass("sidebar-open");
            			 return;
            		}
            	}
            	$("#right-sidebar").addClass("sidebar-open"); return;  
            }  
            elem = elem.parentNode;       
        }  
        //隐藏div的方法  
        
       $("#right-sidebar").removeClass("sidebar-open");
       $("#right-sidebar", parent.document).removeClass("sidebar-open");
    }  
	
	
	$(".refresher").click(function(){
		refresh();
	});
});

function printUtil(panel, requestdata, ajaxurl, printfunction){
	$.ajax({
		type: 'POST',
		url: ajaxurl,
		data: requestdata,
		cache:false,
		dataType:"json",
		async: false,
        success: function(response) {
        	if (response.code){
        		if (panel != null && panel.length > 0){
        			$(panel).html("");
        			if (printfunction != null)
        				$(panel).html(printfunction(response.response));
        		}
        		return true;
	        } else {
	        	//alert(response.reason);
	        }
        },
        error: function(x, e) {
        	showMsg("error", x);
        },
        complete: function(x) {
        	//alert("call complete");
        }
	});
	return false;
}

function appendUtil(panel, requestdata, ajaxurl, printfunction, ajaxasync) {
	if (isEmpty(ajaxasync)) {
		ajaxasync = false;
	}
	$.ajax({
		type : 'POST',
		url : ajaxurl,
		data : requestdata,
		cache : false,
		dataType : "json",
		async : ajaxasync,
		success : function(response) {
			if (response.code) {
				if (panel != null && panel.length > 0) {
					if (printfunction != null)
						$(panel).append(printfunction(response.response));
				}
				return true;
			} else {
				// alert(response.reason);
			}
		},
		error : function(x, e) {
			// alert("error", x);
		},
		complete : function(x) {
			// alert("call complete");
		}
	});
	return false;
}

/**
 * 
 * @param panel
 * @param requestdata
 * @param ajaxurl
 * @param printfunction
 * @param ajaxasync
 * @returns {Boolean}
 */
function afterUtil(panel, requestdata, ajaxurl, printfunction, ajaxasync) {
	if (isEmpty(ajaxasync)) {
		ajaxasync = false;
	}
	$.ajax({
		type : 'POST',
		url : ajaxurl,
		data : requestdata,
		cache : false,
		dataType : "json",
		async : ajaxasync,
		success : function(data) {
			if (panel != null && panel.length > 0) {
				if (printfunction != null)
					$(panel).after(printfunction(data));
			}
			return true;
		},
		error : function(x, e) {
			// alert("error", x);
		},
		complete : function(x) {
			// alert("call complete");
		}
	});
	return false;
}

function ajaxUtilAsync(requestdata, ajaxurl, succFunction, failFunction) {
	$.ajax({
		url : ajaxurl,
		type : "POST",
		dataType : "json",
		cache : false,
		data : requestdata,
		async : true,
		success : function(response) {
			if (typeof response.code == "number") {
				if (response.code > 0) {
					if (succFunction != null)
						succFunction(response.response);
				} else {
					if (failFunction != null)
						failFunction(response.response);
				}
			} else {
				if (response.result) {
					if (succFunction != null)
						succFunction(response.response);
				} else {
					if (failFunction != null)
						failFunction(response.response);
				}
			}
		},
		error : function(x, e) {
			// alert("error", x);
		},
		complete : function(x) {
		}
	});
	return false;
}

/**
 * ajax 请求工具类
 * @param requestdata 请求参数，json格式，如{"id":treeNode.id, "name":treeNode.name}
 * @param ajaxurl 请求url地址
 * @param succFunc 请求处理成功后的回调函数，没有传 null
 * @param failFunc 请求处理失败后的回调函数，没有传 null
 * @param errFunc	请求响应失败的回调函数，没有传 null
 * @param beforeFunc 请求发送前的回调函数，没有传 null
 * @param finishFunc 请求响应完成后的回调函数，没有传 null
 * @returns {Boolean}
 */
function ajaxUtil(requestdata, ajaxurl, succFunc, failFunc, errFunc, beforeFunc, finishFunc){
	$.ajax({
        url: ajaxurl,
        type: "POST",
        dataType: "json",
        cache:false,
        data: requestdata,
        async: false,
    	beforeSend : function(){
			 if(notEmpty(beforeFunc)){
				 beforeFunc;
			 }
    	},
        success: function(data) {
        	if (data.status==1){
        		if(notEmpty(succFunc)){
        			succFunc(data.data);
        		}
	        } else {
	        	if(notEmpty(failFunc)){
	        		failFunc(data.data);
	        	}
	        }
        },
        error: function(x, e) {
        	if(notEmpty(errFunc)){
        		errFunc;
        	}else{
        		showErrMsg("请求失败");
        	}
        },
        complete: function(x) {
        	if(notEmpty(finishFunc)){
        		finishFunc;
        	}
        }
	});
	return false;
}
function loadSelection(panel, requestdata, ajaxurl, itemName){
	ajaxUtil(requestdata, ajaxurl, function(response){
		var list = response.list;
		for (var i = 0;i<list.length;i++){
			$(panel).append("<option value='"+list[i].id+"'>"+list[i].name+"</option>");
		}
	}, null);
}
function loadSelectionNV(panel, requestdata, ajaxurl, itemName, itemValue){
	ajaxUtil(requestdata, ajaxurl, function(response){
		$(panel).html("");
		var list = response.list;
		for (var i = 0;i<list.length;i++){
			$(panel).append("<option value='"+list[i][itemValue]+"'>"+list[i][itemName]+"</option>");
		}
	}, null);
}
function loadSelectionAppend(panel, requestdata, ajaxurl, itemName, itemValue){
	ajaxUtil(requestdata, ajaxurl, function(response){
		var list = response.list;
		for (var i = 0;i<list.length;i++){
			$(panel).append("<option value='"+list[i][itemValue]+"'>"+list[i][itemName]+"</option>");
		}
	}, null);
}
function getFileUrl(sourceId) {
	var url = "";
	if (navigator.userAgent.indexOf("MSIE")>=1) { // IE
	url = document.getElementById(sourceId).value;
	} else if(navigator.userAgent.indexOf("Firefox")>0) { // Firefox
	url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0));
	} else if(navigator.userAgent.indexOf("Chrome")>0) { // Chrome
	url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0));
	}
	return url;
}

	/**
	* 将本地图片 显示到浏览器上
	*/
function preImg(sourceId, targetId) {
	var url = getFileUrl(sourceId);
    var imgPre = document.getElementById(targetId);
    imgPre.src = url;
}

//显示图片 并控制删除按钮 标志位
function preImgBut(sourceId, imgSrcId, delButId, delImgFlag) {
	var url = getFileUrl(sourceId);
    var imgPre = document.getElementById(imgSrcId);
    imgPre.src = url;
	
	if(url !== null && url != ""){
		$("#" + delButId).removeClass("hidden").addClass("show");
		$("#" + delImgFlag).val(0);
	}else{
		$("#" + delButId).removeClass("show").addClass("hidden");
	}
}

//删除图片  删除图片默认标记为1
function deleteImg(delBut, filedId, imgSrcId,  delImgFlag){
	$("#" + imgSrcId).attr("src", "");
	$("#" + delImgFlag).val(1);
	$(delBut).removeClass("show").addClass("hidden");
	$("#" + filedId).html($("#" + filedId).html());
}
	
function updateImg(resourceName, key) {
	var userImg = $("#userImg").val();
	if(userImg == "") {
		alert("请选择图片！");
		return;
	}
	var tmp = userImg.toLowerCase();
	var length = tmp.length - 4;
	if(tmp.lastIndexOf(".bmp") != length && tmp.lastIndexOf(".jpg") != length && tmp.lastIndexOf(".png") != length) {
		alert("只支持bmp、jpg和png格式的图片！");
		return;
	}
    var hideForm = $('#modifyUserInfoForm');
    var options = {
        dataType : "json",
        beforeSubmit : function() {
            //alert("正在上传");
        },
        success : function(result) {
        	if (result.result){
	            //update img
	            $("#userImgPic").attr("src", result.response);
	            savePicResource(resourceName, "#userImgPic", key);
        	} else {
        		alert("图片修改失败！");
        	}
        },
        error : function(result) {
        	alert("图片修改失败！");
        }
    };
    hideForm.ajaxSubmit(options);
}

function updateImgById(id, resourceName, key) {
	var userImg = $("#userImg"+id).val();
	if(userImg == "") {
		alert("请选择图片！");
		return;
	}
	var tmp = userImg.toLowerCase();
	var length = tmp.length - 4;
	if(tmp.lastIndexOf(".bmp") != length && tmp.lastIndexOf(".jpg") != length && tmp.lastIndexOf(".png") != length) {
		alert("只支持bmp、jpg和png格式的图片！");
		return;
	}
    var hideForm = $('#modifyUserInfoForm'+id);
    var options = {
        dataType : "json",
        beforeSubmit : function() {
            //alert("正在上传");
        },
        success : function(result) {
        	if (result.code){
	            //update img
	            $("#userImgPic").attr("src", result.response);
	            savePicResource(resourceName, "#userImgPic"+id, key);
        	} else {
        		alert("图片修改失败！");
        	}
        },
        error : function(result) {
        	alert("图片修改失败！");
        }
    };
    hideForm.ajaxSubmit(options);
}

function savePicResource(resourceName, panel, key){
	var picURL = $(panel).attr("src");
	var json = {"resourceName":resourceName,"key":key, "value": picURL};
	ajaxUtil(json, mainpath+"/module/updateResource.shtml", showMsgWithoutRefresh("修改成功"), null);
}
function saveResource(resourceName, panel, key){
	var value = $(panel).val();
	var json = {"resourceName":resourceName,"key":key, "value": value};
	ajaxUtil(json, mainpath+"/module/updateResource.shtml", showMsgWithoutRefresh("修改成功"), null);
}

function refresh(){
	if(notEmpty(pageNo) && notEmpty(pagingmain)){
		eval(pagingmain.replace("#pageNo", pageNo));
	}else{
		window.location.href = window.location.href;
	}
}
function ajaxSubmit(formId) {
	$("#loading").removeClass("hidden").addClass("show");
    var hideForm = $(formId);
    var options = {
        dataType : "json",
        beforeSubmit : function() {
        },
        success:function(result) {
        	$("#loading").removeClass("show").addClass("hidden");
        	var file = $("input[type='file']");
    		file.each(function(){
    			 if(this.outerHTML){
                     this.outerHTML=this.outerHTML;
                 }
    		 });
        	take = true;
        	if (result.code){
        		showMsgWithoutRefresh("提交成功");
        	} else {
        		showErrMsg("提交失败！");//
        	}
        },
        error : function(result) {
        	$("#loading").removeClass("show").addClass("hidden");
        	take = true;
        	showErrMsg("提交失败！");
        }
    };
    if(take == true){
    	$("#loading").removeClass("hidden").addClass("show");
    	take =false;
    	hideForm.ajaxSubmit(options);
    }
}

function ajaxSubmitRefresh(formId) {
    var hideForm = $(formId);
    var options = {
        dataType : "json",
        beforeSubmit : function() {
        },
        success : function(data) {
        	$("#loading").removeClass("show").addClass("hidden");
        	var file = $("input[type='file']");
    		file.each(function(){
    			 if(this.outerHTML){
                     this.outerHTML=this.outerHTML;
                 }
    		 });

        	take = true;
        	if (data.status==1){
        		showMsgWithFresh("提交成功");
        	} else {
        		showErrMsg("提交失败！");
        	}
        },
        error : function(result) {
        	var file = $("input[type='file']");
        	file.each(function(){
   			 if(this.outerHTML){
                    this.outerHTML=this.outerHTML;
                }
   		 });
        	$("#loading").removeClass("show").addClass("hidden");
        	showErrMsg("提交失败！");
        }
    };
    if(take == true){
    	take = false;
    	$("#loading").removeClass("hidden").addClass("show");
    	hideForm.ajaxSubmit(options);
    }
}

function ajaxSubmitWithFunc(formId, beforeFunc, succFunc, failFunc) {
	$("#loading").removeClass("hidden").addClass("show");
    var hideForm = $(formId);
    var options = {
        dataType : "json",
        beforeSubmit : function() {
        	if(notEmpty(beforeFunc)){
        		beforeFunc;
        	}
        },
        success : function(result) {
        	var file = $("input[type='file']");
    		file.each(function(){
    			 if(this.outerHTML){
                     this.outerHTML=this.outerHTML;
                 }
    		 });
        	toke = true;
        	if (result.status==1){
        		if (succFunc){
        			$("#loading").removeClass("show").addClass("hidden");
                	take = true;
        			succFunc(result.data);
        		}
        	} else {
        		if (failFunc){
        			failFunc(result.data);
        		}
        	}
        },
        error : function(result) {
        	var file = $("input[type='file']");
    		file.each(function(){
    			 if(this.outerHTML){
                     this.outerHTML=this.outerHTML;
                 }
    		 });
        	toke = true;
        	showMsg("提交失败！");
        }
    };
    if(take == true){
    	take =false;
        hideForm.ajaxSubmit(options);
    }
}

function showMsg(msg) {
	swal({
		title : msg,
		type : "success",
		timer: 2000,
		allowOutsideClick : true
	});
}

function showMsgWithFresh(msg) {
	swal({
		title : msg,
		type : "success",
		allowOutsideClick : true
	}, function() {
		refresh();
	});
}

function showErrMsg(msg) {
	swal({
		title : msg,
		type : "error",
		allowOutsideClick : true
	});
}

function showMsgWithoutRefresh(msg) {
	swal({
		title : msg,
		type : "success",
		allowOutsideClick : true
	});
}

function deleteMsg(title, confirmButtonText, cancelButtonText, func) {
	swal({
		title : title,
		type : "warning",
		confirmButtonColor : "#DD6B55",
		confirmButtonText : confirmButtonText,
		cancelButtonText : cancelButtonText,
		showCancelButton : true,
		closeOnConfirm : false
	}, function(isConfirm) {
		if (isConfirm) {
			func();
		}
	});
}

function ajaxGetUtilAsync(requestdata, ajaxurl, succFunction, failFunction) {
	$.ajax({
		url : ajaxurl,
		type : "get",
		dataType : "json",
		cache : false,
		data : requestdata,
		async : false,
		success : function(response) {
			if (typeof response.code == "number") {
				if (response.code > 0) {
					if (succFunction != null)
						succFunction(response.response);
				} else {
					if (failFunction != null)
						failFunction(response.response);
				}
			} else {
				if (response.result) {
					if (succFunction != null)
						succFunction(response.response);
				} else {
					if (failFunction != null)
						failFunction(response.response);
				}
			}
		},
		error : function(x, e) {
			// alert("error", x);
		},
		complete : function(x) {
		}
	});
	return false;
}

function urlparameter(paras){
	var url = location.href;
	var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
	var paraObj = {}
	for (i=0; j=paraString[i]; i++){
		paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length);
	}
	var returnValue = paraObj[paras.toLowerCase()];
	if(typeof(returnValue)=="undefined"){
		return "";
	}else{
		return returnValue;
	}
}

// 对Date的扩展，将 Date 转化为指定格式的String   
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
// 例子：   
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.format = function(fmt)   
{ //author: meizz   
  var o = {   
    "M+" : this.getMonth()+1,                 //月份   
    "d+" : this.getDate(),                    //日   
    "h+" : this.getHours(),                   //小时   
    "m+" : this.getMinutes(),                 //分   
    "s+" : this.getSeconds(),                 //秒   
    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
    "S"  : this.getMilliseconds()             //毫秒   
  };   
  if(/(y+)/.test(fmt))   
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
  for(var k in o)   
    if(new RegExp("("+ k +")").test(fmt))   
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
  return fmt;   
}  

/**
 * 
 * @param panel 用于显示列表的容器
 * @param container 用于显示分页按钮的容器
 * @param count 共有多少分页
 * @param pageNo 当前第几页
 * @param pageSize 每页显示多少条
 * @param funcName 点击分页后的函数
 */
function setPage(panel, container, count, url, data, pageNo, pageSize, funcName) {
	var a = [];
	var pageindex = pageNo;
	pagingmain = funcName+"('"+panel+"','"+url+"','"+data+"', '#pageNo', '"+pageSize+"')";
	var pageLink = "javascript:"+funcName+"('"+panel+"','"+url+"','"+data+"', '#pageNo', '"+pageSize+"')";
	a[a.length] = "<div class=\"row\">";
	a[a.length] = "<div  style = \"text-align:center\">";
	a[a.length] = "<div id=\"editable_paginate\" class=\"dataTables_paginate paging_simple_numbers\">";
	a[a.length] = "<ul class=\"pagination\">";
	
  //总页数少于10 全部显示,大于10 显示前3 后3 中间3 其余....
  if (pageindex == 1) {
    a[a.length] = "<li class=\"paginate_button previous disabled\"  tabindex=\"0\" ><a href=\"javascript:void(0)\">上一页</a></li>";
  } else {
    a[a.length] = "<li  class=\"paginate_button previous\"  tabindex=\"0\"><a  onclick = \" javascript:getPage('"+(parseInt(pageNo)-1)+"')\"  href=\""+pageLink.replace("#pageNo", pageNo-1)+"\">上一页</a></li>";
  }
  function setPageList(i) {
    if (pageindex == i) {
      a[a.length] = "<li class=\"paginate_button active\" aria-controls=\"editable\" tabindex=\"0\"><a onclick = \"javascript:getPage('"+i+"')\"   href=\""+pageLink.replace("#pageNo", i)+"\">"+i+"</a></li>";
    } else {
      a[a.length] = "<li class=\"paginate_button\" aria-controls=\"editable\" tabindex=\"0\"><a onclick = \"javascript:getPage('"+i+"')\"     href=\""+pageLink.replace("#pageNo", i)+"\">"+i+"</a></li>";
    }
  }
  //总页数小于10
  if (count <= 10) {
    for (var i = 1; i <= count; i++) {
      setPageList(i);
    }
  }else {
    if (pageindex <= 4) {
      for (var i = 1; i <= 5; i++) {
        setPageList(i);
      }
      a[a.length] = "<li class=\"paginate_button disabled\" aria-controls=\"editable\" tabindex=\"0\" ><a href=\"#\">…</a></li><li class=\"paginate_button\" aria-controls=\"editable\" tabindex=\"0\"><a onclick = \"javascript:getPage('"+count+"')\"   href=\""+pageLink.replace("#pageNo", count)+"\">"+count+"</a></li>";
    } else if (pageindex >= count - 3) {
      a[a.length] = "<li class=\"paginate_button\" aria-controls=\"editable\" tabindex=\"0\"><a onclick = \"javascript:getPage('"+1+"')\"   href=\""+pageLink.replace("#pageNo", 1)+"\">1</a></li><li class=\"paginate_button disabled\" aria-controls=\"editable\" tabindex=\"0\" ><a href=\"#\">…</a></li>";
      for (var i = count - 4; i <= count; i++) {
        setPageList(i);
      }
    }
    else { //当前页在中间部分
      a[a.length] = "<li class=\"paginate_button\" aria-controls=\"editable\" tabindex=\"0\"><a  onclick = \"javascript:getPage('"+1+"')\"   href=\""+pageLink.replace("#pageNo", 1)+"\">1</a></li><li class=\"paginate_button disabled\" aria-controls=\"editable\" tabindex=\"0\" ><a href=\"javascript:void(0)\">…</a></li>";
      for (var i = parseInt(pageindex) - 2; i <= parseInt(pageindex) + 2; i++) {
        setPageList(i);
      }
      a[a.length] = "<li class=\"paginate_button disabled\" aria-controls=\"editable\" tabindex=\"0\" ><a href=\"javascript:void(0)\">…</a></li><li class=\"paginate_button\" aria-controls=\"editable\" tabindex=\"0\"><a  onclick = \"javascript:getPage('"+count+"')\"   href=\""+pageLink.replace("#pageNo", count)+"\">"+count+"</a></li>";
    }
  }
  if (pageindex == count) {
	    a[a.length] = "<li class=\"paginate_button next disabled\" aria-controls=\"editable\" tabindex=\"0\"><a href=\"javascript:void(0)\">下一页</a></li>";
	  } else {
	    a[a.length] = "<li id=\"editable_next\" class=\"paginate_button next\" aria-controls=\"editable\" tabindex=\"0\"><a onclick = \"javascript:getPage('"+(parseInt(pageNo)+1)+"')\" href=\""+pageLink.replace("#pageNo", parseInt(pageNo)+1)+"\" >下一页</a>";
	  }
  a[a.length] = "</div>";
  container.innerHTML = a.join("");
  //事件点击
}

function getPage(obj){
	pageNo = obj;
}

//判断为空
function isEmpty(src){
	if((undefined == src) || ("undefined" == typeof src)  || (src == null) || ($.trim(src) == "") ){
		return true;
	}
	return false;
}

//判断不为空
function notEmpty(src){
	return !isEmpty(src);
}

//获取两个时间的日期差
function getdays(stime1, edate) {
	var sdate = new Date(stime1.replace(/\-/g, "/"));
	var diff = edate - sdate.getTime();
	var day = (diff / (24 * 60 * 60 * 1000)) + 1;
	return (day < 0) ? 0 : day;
}

//初始化UEditor编辑跳转
function ueditor_init(){
	UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
	UE.Editor.prototype.getActionUrl = function(action) {
		if (action == "uploadimage" || action == "uploadscrawl") {
			return urlhost+mainpath+"/admin/upload/media.shtml?mtype=image";
		} else if (action == "uploadvideo") {
			return urlhost+mainpath+"/admin/upload/media.shtml?mtype=video";
		} else {
			return this._bkGetActionUrl.call(this, action);
		}
	} 
}