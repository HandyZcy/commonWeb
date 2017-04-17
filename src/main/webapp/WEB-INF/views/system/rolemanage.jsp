<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>角色管理</title>
	<%@ include file="/common/header.jsp"%>
	<link href="${path}/statics/js/plugins/zTree_v3-master/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript" src="${path}/statics/js/plugins/zTree_v3-master/js/jquery.ztree.all.js"></script>
<script type="text/javascript" src="${path}/statics/adminjs/rolemanage.js"></script>

<body class="gray-bg">
    <div class="row  border-bottom white-bg dashboard-header">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-10" id="searchParam">
						<div class="col-md-4">
							<input id="search-key" name="name" type="text" placeholder="搜索角色名称" class="input-md form-control"> 
						</div>
						<span class="input-group-btn">
							<button type="button" class="btn btn-md btn-primary" id="search-role-btn" onclick="searchSub('searchParam')">搜索</button>
						</span>
					</div>
					<div class="col-md-2 ">
						<span class="input-group-btn">
							<button class="btn btn-md btn-primary" id="add-role-btn">添加</button>
						</span>
					</div>
				</div>
				<hr>
				<div>
					<div style="text-align: center">
						<table id="role-table" class="table table-hover table-condensed table-striped" >
							<thead>
								<tr>
									<td>ID</td>
									<td>名称</td>
									<td>操作</td>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty roleList}">
										<tr>
											<td colspan="3">暂无数据</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${roleList}" var="role" varStatus="indexId">
											<tr>
												<td class="td-name">${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
												<td class="td-name">${role.name}</td>
												<td>
													<a class="btn btn-primary btn-sm" href="javascript:updateRoleRight(${role.id})">分配权限</a>
													<a class="btn btn-primary btn-sm" href="javascript:updateRole(${role.id})"> 编辑</a>
													<a class="btn btn-danger btn-sm" href="javascript:delRole(${role.id},'${role.name}')"> 删除 </a>
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<%@ include file="/common/page.jsp" %>
					</div>
					<div id="paging_btn"></div>
				</div>
			</div>
		</div>

		<!-- modal starts -->
		<div class="modal fade" id="add-role-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width:900px">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>添加角色</h3>
					</div>
					<div class="modal-body">
						<form id="add-role-form" action="${path}/role/saveOrUpdate.shtml" method="post">
							<div class="form-group">
								<label for="title">角色名称</label>
								<input type="text" placeholder="角色名称" name="name"  id="add-role-name" class="form-control" >
							</div>
							<div><label id="add-role-hint" style="color:red"></label></div>
						</form>
					</div>
					<div class="modal-footer">
						<a id="add-role-do-btn" class="btn btn-primary" > 确 定 </a>
						<a href="#" class="btn btn-default" data-dismiss="modal"> 取 消 </a>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="update-role-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

			<div class="modal-dialog" style="width:900px">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>更新角色</h3>
					</div>
					<div class="modal-body">
						<form id="update-role-form" action="${path}/role/saveOrUpdate.shtml" method="post">
							<div class="form-group hide">
								<input type="text" id="update-role-id" name="id" class="form-control">
							</div>
							<div class="form-group">
								<label for="title">角色名称</label>
								<input type="text" id="update-role-name" placeholder="角色名称 " name="name" class="form-control" >
							</div>
							<div class="row"></div>
							<div><label id="update-role-hint" style="color:red"></label></div>
						</form>
					</div>
					<div class="modal-footer">
						<a id="update-role-do-btn" class="btn btn-primary" > 确 定 </a>
						<a href="#" class="btn btn-default" data-dismiss="modal"> 取 消 </a>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="role-right-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width:900px">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>管理角色权限</h3>
					</div>
					<div class="modal-body">
						<div class="row">
							<form action="" method="post" class="form form-horizontal" id="form-article-add">
								<div id="tab-system">
									<div class="zTreeDemoBackground left">
										<ul id="treeDemo" class="ztree"></ul>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<a id="save-role-right-btn" class="btn btn-primary" > 确 定 </a>
						<a href="#" class="btn btn-default" data-dismiss="modal"> 取 消 </a>
					</div>
				</div>
			</div>
		</div>
		<!-- modal ends -->
        
      </div>
      <%@include file="/common/mask.jsp" %>
	</body>
</html>