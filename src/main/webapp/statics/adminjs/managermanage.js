$(document).ready(function(){
	
	$("#add-manager-btn").click(function(){
		$("#add-manager-modal").modal({backdrop: 'static', keyboard: false}).modal("show");
		preAddManager();
	});
	
	$("#add-manager-do-btn").click(doAddManager);
	$("#update-manager-do-btn").click(doUpdateManager);
	
	
});


function preAddManager(){
	loadSelection("#add-manager-role", null, path + "/manager/preEdit.shtml", null)
}

function preUpdateManager(managerId){
	ajaxUtil({"managerId":managerId}, path + "/manager/preEdit.shtml", function(data){
		var roleList = data.list;
		var manager = data.manager;
		$("#update-manager-role").html("");
		for (var i = 0;i<roleList.length;i++){
			var role = roleList[i];
			var selected = "";
			for(var j = 0; j < manager.roleList.length; j++){
				var managerRole = manager.roleList[j];
				if(managerRole.id == role.id){
					selected = "selected=\"selected\"";
				}
			}
			$("#update-manager-role").append("<option value=\"" + role.id + "\"" + selected + ">" + role.name + "</option>");
		}
		$("#update-manager-nickname").val(manager.nickname);
		$("#update-manager-pwd").val(manager.pwd);
		$("#update-manager-rePwd").val(manager.pwd);
		$("#update-manager-name").val(manager.name);
		$("#update_state"+manager.state).val(manager.state);
		$("#update-manager-mobile").val(manager.mobile);
		$("#updateManagerId").val(manager.id);
	});
	$("#update-manager-modal").modal({backdrop: 'static', keyboard: false}).modal("show");
}

function doAddManager(){
	ajaxSubmitRefresh("#add-manager-form");
}

function doUpdateManager(){
	ajaxSubmitRefresh("#update-manager-form");
}

function delManager(managerId,name){
	deleteMsg("您确定要删除 "+name+" 的用户吗？", "是的,我要删除", "让我考虑一下...", function(){
		ajaxUtil({"managerId" : managerId}, path+"/manager/delById.shtml", function(data){
			showMsgWithFresh("删除成功");
		}, function(){
			showErrMsg("删除失败");
		});
	});
}

