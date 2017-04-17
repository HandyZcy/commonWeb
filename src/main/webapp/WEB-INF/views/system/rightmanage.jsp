<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<!DOCTYPE HTML>
<html lang="en">
	<head>
		<%@ include file="/common/header.jsp"%> 
		<link href="${path}/statics/js/plugins/zTree_v3-master/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css">
		<link href="${path}/statics/css/plugins/iCheck/custom.css" rel="stylesheet">
	</head>
	<style type="text/css">
		.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
		.ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
		.ztree li ul.level0 {padding:0; background:none;}
	</style>

<script type="text/javascript" src="${path}/statics/js/plugins/zTree_v3-master/js/jquery.ztree.all.js"></script>
<script type="text/javascript" src="${path}/statics/adminjs/rightmanage.js"></script>

<body class="gray-bg">
    <div style="padding-left: 2%;" class="row  border-bottom white-bg dashboard-header">
		<div class="row">
			<form action="" method="post" class="form form-horizontal" id="form-article-add">
				<div id="tab-system">
					<div class="zTreeDemoBackground left">
						<ul id="treeDemo" class="ztree"></ul>
					</div>
				</div>
			</form>
		</div>
		
		<!-- modal starts -->
		<div class="modal fade" id="add-right-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width:900px">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>添加权限</h3>
					</div>
					<div class="modal-body">
						<form id="add-right-form" action="${path}/right/saveOrUpdate.shtml" method="post">
							<div class="form-group">
								<label for="title">功能名称</label>
								<input type="text" placeholder="请输入功能名称" name="name" id="add-right-name" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">链接地址</label>
								<input type="text" placeholder="请输入功能链接地址" name="link" id="add-right-link" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">权限信息：</label>
								<input type="text" placeholder="请输入权限信息" name="description" id="add-right-description" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">功能状态</label>
								<div class="radio i-checks">
	                                <label><input type="radio" value="0" name="state" checked="checked" > <i></i> 禁用</label>
	                                &nbsp;&nbsp;
	                                <label><input type="radio" value="1" name="state"> <i></i> 启用</label>
	                            </div>
							</div>
							<div class="form-group">
								<label for="title">功能类型</label>
								<div class="radio i-checks">
	                                <label><input type="radio" value="2" name="type" id="add_type_2"> <i></i> 功能</label>
	                                &nbsp;&nbsp;
	                                <label><input type="radio" value="1" name="type" id="add_type_1"> <i></i> 菜单</label>
	                                &nbsp;&nbsp;
	                                <label><input type="radio" value="0" name="type" id="add_type_0"> <i></i> 包</label>
	                            </div>
							</div>
							<div class="form-group">
								<label for="title">排列序号</label>
								<input type="number" name="seqnum" id="add-right-seqnum" class="form-control" >
								<input type="hidden" name="parentId" id="add-right-parentId">
							</div>
							<div><label id="add-right-hint" style="color:red"></label></div>
						</form>
					</div>
					<div class="modal-footer">
						<a id="add-right-do-btn" class="btn btn-primary" > 确 定 </a>
						<a href="#" class="btn btn-default" data-dismiss="modal"> 取 消 </a>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="update-right-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width:900px">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>修改权限</h3>
					</div>
					<div class="modal-body">
						<form id="update-right-form" action="${path}/right/saveOrUpdate.shtml" method="post">
							<div class="form-group">
								<label for="title">功能名称</label>
								<input type="text" placeholder="请输入功能名称" name="name" id="update-right-name" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">链接地址</label>
								<input type="text" placeholder="请输入功能链接地址" name="link" id="update-right-link" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">权限信息</label>
								<input type="text" placeholder="请输入权限信息" name="description" id="update-right-description" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">功能状态</label>
								<div class="radio i-checks">
	                                <label><input type="radio" value="0" name="state" id="state0"> <i></i> 禁用</label>
	                                &nbsp;&nbsp;
	                                <label><input type="radio" value="1" name="state" id="state1"> <i></i> 启用</label>
	                            </div>
							</div>
							<div class="form-group">
								<label for="title">功能类型</label>
								<div class="radio i-checks">
	                                <label><input type="radio" value="2" name="type" id="update_type_2"> <i></i> 功能</label>
	                                &nbsp;&nbsp;
	                                <label><input type="radio" value="1" name="type" id="update_type_1"> <i></i> 菜单</label>
	                                &nbsp;&nbsp;
	                                <label><input type="radio" value="0" name="type" id="update_type_0"> <i></i> 包</label>
	                            </div>
							</div>
							<div class="form-group">
								<label for="title">排列序号</label>
								<input type="number" name="seqnum" id="update-right-seqnum" class="form-control" >
								<input type="hidden" name="id" id="update_id">
							</div>
							<div><label id="update-right-hint" style="color:red"></label></div>
						</form>
					</div>
					<div class="modal-footer">
						<a id="update-right-do-btn" class="btn btn-primary" > 确 定 </a>
						<a href="#" class="btn btn-default" data-dismiss="modal"> 取 消 </a>
					</div>
				</div>
			</div>
		</div>
		<!-- modal ends -->
	</div>
	<%@ include file="/common/mask.jsp" %>
</body>

</html>
