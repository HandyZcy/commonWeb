$(document).ready(function(){
	loadRightList(path + "/right/getAllRight");
	
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	$("#selectAll").bind("click", selectAll);
	
	$("#add-right-btn").click(function(){
		$("#add-right-modal").modal({backdrop: 'static', keyboard: false}).modal("show");
	});
	
	$("#add-right-do-btn").click(doAddRight);
	$("#update-right-do-btn").click(doUpdateRight);
});

var setting = {
	
	/*async: {
		enable: true,
		dataType: "json",
		url: path + "/right/getAllRight",
		autoParam: []
	},*/
	
	view: {
		addHoverDom: addHoverDom,
		removeHoverDom: removeHoverDom,
		selectedMulti: false
	},
	edit: {
		enable: true,
		editNameSelectAll: true,
		showRemoveBtn: showRemoveBtn,
		showRenameBtn: showRenameBtn
	},
	data: {
		simpleData: {
			enable: true
		}
	},
	callback: {
		beforeDrag: beforeDrag,
		beforeEditName: beforeEditName,
		beforeRemove: beforeRemove,
		beforeRename: beforeRename,
		onRemove: onRemove,
		onRename: onRename
	}
};

var zNodes =[];

var log, className = "dark";

function loadRightList(url){
	ajaxUtil(null, url, function(rightList){
		if(isEmpty(rightList)){
			return;
		}
		$.each(rightList,function(i,right){
			var ddd = null;
			if(right.type==0){
				ddd = {id:right.id, pId:right.parentId, name:right.name,type:right.type, open:true};
			}else{
				ddd = {id:right.id, pId:right.parentId, name:right.name,type:right.type};
			}
			zNodes.push(ddd);
		});
	},function(){
		showErrMsg("数据加载失败");
	});
}

function beforeDrag(treeId, treeNodes) {
	return false;
}

//编辑弹出层
function beforeEditName(treeId, treeNode) {
	ajaxUtil({"funcId":treeNode.id}, path+"/right/getFuncInfoById",
	function(data){
		$("#update-right-name").val(data.name);
		$("#update-right-link").val(data.link);
		$("#update-right-description").val(data.description);
		$("#state"+data.state).prop("checked",true);
		$("#update_type_"+data.state).prop("checked",true);
		$("#update-right-seqnum").val(data.seqnum);
		$("#update_id").val(data.id);
     	return true; 
	});
	$("#update-right-modal").modal({backdrop: 'static', keyboard: false}).modal("show");
	return false;
}

//删除弹出层
function beforeRemove(treeId, treeNode) {
	deleteMsg("您确定要删除 "+treeNode.name+" 吗", "确定", "取消", function(){
		ajaxUtil({"funcId":treeNode.id}, path+"/right/delById",
		function(data){
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
  			zTree.removeNode(treeNode, false);//删除节点
  			showMsg("删除成功");
         	return true; 
		}, function(){
			showErrMsg("删除失败");
			return false;
		});
	});
	return false;
}

function onRemove(e, treeId, treeNode) {
	showLog("[ "+getTime()+" onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
}

var newCount = 1;
//显示增加按钮
function addHoverDom(treeId, treeNode) {
	var treeNodeType = treeNode.type;
	if(treeNodeType == 2){
		return;
	}
	var sObj = $("#" + treeNode.tId + "_span");
	if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) 
		return;
	var addStr = "<span class='button add' id='addBtn_" + treeNode.tId + "' title='新增' onfocus='this.blur();'></span>";
	sObj.after(addStr);
	
	var btn = $("#addBtn_"+treeNode.tId);
	if (btn) btn.bind("click", function(){
		//var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		//zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, type:treeNodeType+1,name:"new node" + (newCount++)});
		$("#add-right-modal").modal({backdrop: 'static', keyboard: false}).modal("show");
		
		var type = treeNodeType+1;
		$("#add_type_"+type).prop("checked",true);
		$("#add-right-parentId").val(treeNode.id);
	});
};

function doAddRight(){
	ajaxSubmitRefresh("#add-right-form");
}

function doUpdateRight(){
	ajaxSubmitRefresh("#update-right-form");
}

//显示修改按钮
function showRenameBtn(treeId, treeNode) {
	//return !treeNode.isLastNode;
	return true;
}

//修改事件
function beforeRename(treeId, treeNode, newName, isCancel) {
	className = (className === "dark" ? "":"dark");
	showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" beforeRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
	if (newName.length == 0) {
		alert("节点名称不能为空.");
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		setTimeout(function(){zTree.editName(treeNode)}, 10);
		return false;
	}
	return true;
}

function onRename(e, treeId, treeNode, isCancel) {
	showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
}

//显示删除按钮
function showRemoveBtn(treeId, treeNode) {
	//return !treeNode.isFirstNode;
	return true;
}
//删除事件
function removeHoverDom(treeId, treeNode) {
	$("#addBtn_"+treeNode.tId).unbind().remove();
};

function showLog(str) {
	if (!log) log = $("#log");
	log.append("<li class='"+className+"'>"+str+"</li>");
	if(log.children("li").length > 8) {
		log.get(0).removeChild(log.children("li")[0]);
	}
}

function getTime() {
	var now= new Date(),
	h=now.getHours(),
	m=now.getMinutes(),
	s=now.getSeconds(),
	ms=now.getMilliseconds();
	return (h+":"+m+":"+s+ " " +ms);
}


function selectAll() {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");
}
