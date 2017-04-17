<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员管理</title>
	<%@ include file="/common/header.jsp"%>
</head>

<body class="gray-bg">
    <div class="row  border-bottom white-bg dashboard-header">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-10" id="searchParam">
						<div class="col-md-4">
							<input id="search-key" name="nickname" type="text" placeholder="搜索用户名" class="input-md form-control"> 
						</div>
						<span class="input-group-btn">
							<button type="button" class="btn btn-md btn-primary" id="search-manager-btn" onclick="searchSub('searchParam')" >搜索</button>
						</span>
					</div>
					<div class="col-md-2 ">
						<span class="input-group-btn">
							<button class="btn btn-md btn-primary" id="add-manager-btn">添加</button>
						</span>
					</div>
				</div>
				<hr>
				<div>
					<div style="text-align: center">
						<table id="manager-table" class="table table-hover table-condensed table-striped" >
							<thead>
								<tr>
									<td>管理员名称</td>
									<td>账户</td>
									<td>角色</td>
									<td>操作</td>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty managerList}">
										<tr>
											<td colspan="3">暂无数据</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${managerList}" var="manager">
											<tr>
												<td class="td-name">${manager.name}</td>
												<td class="td-name">${manager.nickname}</td>
												<td class="td-name">
													<c:forEach items="${manager.roleList}" var="role" varStatus="status">
														${role.name}
														<c:if test="${!status.first}">,</c:if>
													</c:forEach>
												</td>
												<td>
													<a class="btn btn-primary btn-sm" href="javascript:preUpdateManager(${manager.id})"> 编辑</a>
													<a class="btn btn-danger btn-sm" href="javascript:delManager(${manager.id},'${manager.name}')"> 删除 </a>
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
		<div class="modal fade" id="add-manager-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width:900px">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>添加管理员</h3>
					</div>
					<div class="modal-body">
						<form id="add-manager-form" action="${path}/manager/saveOrUpdate.shtml" method="post">
							<div class="form-group">
								<label for="title">账号</label>
								<input type="email" placeholder="请输入邮箱格式账号" name="nickname"  id="add-manager-nickname" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">登录密码</label>
								<input type="password" placeholder="请输入登录密码" name="pwd"  id="add-manager-pwd" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">确认密码</label>
								<input type="password" placeholder="请再次输入密码" name="rePwd"  id="add-manager-rePwd" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">所属角色</label>
								<select name="roleIds" class="form-control" id="add-manager-role">
								</select>
							</div>
							<div class="form-group">
								<label for="title">姓名</label>
								<input type="text" placeholder="请输入姓名" name="name"  id="add-manager-name" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">用户状态</label>
								<div class="radio i-checks">
	                                <label><input type="radio" value="0" name="state" id="state0" checked="checked"> <i></i> 禁用</label>
	                                &nbsp;&nbsp;
	                                <label><input type="radio" value="1" name="state" id="state1"> <i></i> 启用</label>
	                            </div>
							</div>
							<div class="form-group">
								<label for="title">手机号</label>
								<input type="text" placeholder="请输入手机号码" name="mobile"  id="add-manager-mobile" class="form-control" >
							</div>
							<div><label id="add-manager-hint" style="color:red"></label></div>
						</form>
					</div>
					<div class="modal-footer">
						<a id="add-manager-do-btn" class="btn btn-primary" > 确 定 </a>
						<a href="#" class="btn btn-default" data-dismiss="modal"> 取 消 </a>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="update-manager-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

			<div class="modal-dialog" style="width:900px">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>更新角色</h3>
					</div>
					<div class="modal-body">
						<form id="update-manager-form" action="${path}/manager/saveOrUpdate.shtml" method="post">
							<div class="form-group">
								<label for="title">账号</label>
								<input type="email" placeholder="请输入邮箱格式账号" name="nickname"  id="update-manager-nickname" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">登录密码</label>
								<input type="password" placeholder="请输入登录密码" name="pwd"  id="update-manager-pwd" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">确认密码</label>
								<input type="password" placeholder="请再次输入密码" name="rePwd"  id="update-manager-rePwd" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">所属角色</label>
								<select name="roleIds" class="form-control" id="update-manager-role">
									
								</select>
							</div>
							<div class="form-group">
								<label for="title">姓名</label>
								<input type="text" placeholder="请输入姓名" name="name"  id="update-manager-name" class="form-control" >
							</div>
							<div class="form-group">
								<label for="title">用户状态</label>
								<div class="radio i-checks">
	                                <label><input type="radio" value="0" name="state" id="update_state0" checked="checked"> <i></i> 禁用</label>
	                                &nbsp;&nbsp;
	                                <label><input type="radio" value="1" name="state" id="update_state1"> <i></i> 启用</label>
	                            </div>
							</div>
							<div class="form-group">
								<label for="title">手机号</label>
								<input type="text" placeholder="请输入手机号码" name="mobile"  id="update-manager-mobile" class="form-control" >
								<input type="hidden" name="id" id="updateManagerId">
							</div>
							<div><label id="update-manager-hint" style="color:red"></label></div>
						</form>
					</div>
					<div class="modal-footer">
						<a id="update-manager-do-btn" class="btn btn-primary" > 确 定 </a>
						<a href="#" class="btn btn-default" data-dismiss="modal"> 取 消 </a>
					</div>
				</div>
			</div>
		</div>
		
		<!-- modal ends -->
        
      </div>
      <%@include file="/common/mask.jsp" %>
	</body>
	
	<script type="text/javascript" src="${path}/statics/adminjs/managermanage.js"></script>
</html>