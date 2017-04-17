$(document).ready(function(){
	
	$("#add-role-btn").click(function(){
		$("#add-role-modal").modal({backdrop: 'static', keyboard: false}).modal("show");
	});
	
	$("#add-role-do-btn").click(doAddrole);
	$("#update-role-do-btn").click(doUpdaterole);
	
	$("#save-role-right-btn").click(saveRoleRight);
	
	loadAllRight(path + "/right/getAllRight.shtml");
	
});

function loadAllRight(url){
	ajaxUtil(null, url, function(rightList){
		if(isEmpty(rightList)){
			return;
		}
		allRightList = rightList;
	},function(){
		showErrMsg("数据加载失败");
	});
}

function updateRole(id){
	$("#update-role-hint").html("");
	ajaxUtil({"roleId":id}, path+"/role/getById.shtml", function(data){
		$("#update-role-id").val(data.id);
		$("#update-role-name").val(data.name);
	});
	$("#update-role-modal").modal({backdrop: 'static', keyboard: false}).modal("show");
}

function doAddrole(){
	$("#add-role-modal").modal("hide");
	ajaxSubmitRefresh("#add-role-form");
}

function doUpdaterole(){
	var name = $("#update-role-name").val();
	if(isEmpty($.trim(name))){
		$("#update-role-hint").html("角色名称不能为空");
	}
	$("#update-role-modal").modal("hide");
	ajaxSubmitRefresh("#update-role-form");
}

function delRole(id, name){
	deleteMsg("您确定要删除 "+name+" 的角色吗？", "是的,我要删除", "让我考虑一下...", function(){
		ajaxUtil({"roleId" : id}, path+"/role/delById.shtml", function(data){
			showMsg("删除成功");
		}, function(){
			showErrMsg("删除失败");
		});
	});
}

var nowRoleId;

function updateRoleRight(roleId){
	nowRoleId = roleId;
	loadRoleRightList(path+"/role/getRoleRightById.shtml")
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
}

var allRightList;
var zNodes = [];
var ddd = null;
var setting = {
	view: {
		dblClickExpand: false,
		showLine: false,
		selectedMulti: false
	},
	data: {
		simpleData: {
			enable:true,
			idKey: "id",
			pIdKey: "pId",
			rootPId: ""
		}
	},
	check: {
		enable: true
	},
	callback: {
		beforeClick: function(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.checkNode(treeNode, null, true, false);//控制复选框
			if (treeNode.isParent) {
				zTree.expandNode(treeNode);
				return false;
			} else {
				//demoIframe.attr("src",treeNode.file + ".html");
				return true;
			}
		}
	}
};

function loadRoleRightList(url){
	$("#role-right-modal").modal({backdrop: 'static', keyboard: false}).modal("show");
	ajaxUtil({"roleId":nowRoleId}, url, function(roleRightList){
		zNodes = [];
		ddd = null;
		for (var i = 0; i < allRightList.length; i++) {
			var right = allRightList[i];
			var checkFlag = false;
			var openFlag = false;
			for (var j = 0; j < roleRightList.length; j++) {
				if(roleRightList[j].rightId == right.id){
					checkFlag = true;
					openFlag = true;
				}
			}
			ddd = {id:right.id, pId:right.parentId, name:right.name,type:right.type, checked:checkFlag, open:openFlag};
			zNodes.push(ddd);
		}
	},function(){
		showErrMsg("数据加载失败");
	});
}

function saveRoleRight(){
	var rightIds = new Array(); //定义数组，记录选中的id
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	var checkedNodes = zTree.getCheckedNodes(true);
	$.each(checkedNodes,function(i,checkNode){
		if(checkNode.parentId != 0){//去除根目录
			rightIds.push(checkNode.id);
		}
	});
	ajaxUtil({"roleId":nowRoleId,"rightIds":rightIds.toString()}, path+"/role/saveRoleRight.shtml", function(data){
		showMsg("操作成功");
	}, function(){
		showErrMsg("操作失败");
	})
	rightIds = new Array();//清空数组
}