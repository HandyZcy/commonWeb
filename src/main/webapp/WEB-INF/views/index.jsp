<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>系统主页</title>
	<%@ include file="/common/header.jsp"%> 
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element">
                            <span><img alt="image" class="img-circle" style="width: 66px;height: 66px;" src="${adminUser.headimg}" /></span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                               <span class="block m-t-xs"><strong class="font-bold">${adminUser.nickname}</strong></span>
                                <span class="text-muted text-xs block">管理员<b class="caret"></b></span>
                                </span>
                            </a>
	                           <ul class="dropdown-menu animated fadeInRight m-t-xs"  style="width: 100px" >
								<li><a id="update-adminuser-btn" href="javascript:void(0)">修改密码</a></li>
								<li><a id="update-adminuser-btn2" href="javascript:void(0)">修改信息</a></li>
								<li><a href="http://www.lazycard.cn" target="blank">联系我们</a></li>
								<li class="divider"></li>
								<li><a href="${path}/admin/logout.shtml">安全退出</a></li>
							</ul>
                        </div>
                        <div class="logo-element">CM
                        </div>
                    </li>
                    <li id="homeLi">
                        <a class="J_menuTab" href="javascript:void(0)"  data-index="0">首页</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
               <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                   <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                        <form role="search" class="navbar-form-custom" method="post" action="">
                            <div class="form-group">
                                <input type="text" placeholder="请输入您需要查找的内容 …" class="form-control" name="top-search" id="top-search">
                            </div>
                        </form>
                    </div>
                    <ul class="nav navbar-top-links navbar-right">
						<li class="hidden-xs">
							<a class="right-sidebar-toggle" onclick="redictUrl()"  href="javascript:void(0)" data-index="0">
							<i class="fa fa-cart-arrow-down"></i>权益商品</a>
						</li>
                         <li class="dropdown hidden-xs">
                            <a  id="right-sidebar-toggle" class="right-sidebar-toggle"  data-toggle="dropdown"  aria-expanded="false">
                                <i class="fa fa-tasks"></i> 主题
                            </a>
                        </li>
                    </ul> 
                </nav> 
            </div>
            <div class="row content-tabs">
                <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
                </button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content">
                      <a class="J_menuTab  active" href="javascript:void(0);" data-id="#">首页</a>
                    </div>
                </nav>
                <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
                </button>
                <div class="btn-group roll-nav roll-right">
                    <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>

                    </button>
                    <ul role="menu" class="dropdown-menu dropdown-menu-right">
                        <li class="J_tabShowActive"><a>定位当前选项卡</a>
                        </li>
                        <li class="divider"></li>
                        <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                        </li>
                        <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                        </li>
                    </ul>
                </div>
                <a href="<%=path%>/admin/logout.shtml" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe class="J_iframe" name="iframe0" id= "content-row" width="100%" height="100%" src="" frameborder="0" data-id="" seamless></iframe>
            </div>
            <div class="footer">
                <div class="pull-right">&copy; 2017-2020 <a href="http://www.baidu.com" target="_blank">懒人用卡项目组</a>
                </div>
            </div>
        </div>
        <!--右侧部分结束-->
        
        <!--右侧边栏开始-->
        <div id="right-sidebar" class="dropdown"  >
            <div class="sidebar-container">

                <ul class="nav nav-tabs navs-2">
                    <li class="active">
                        <a data-toggle="tab" href="#tab-1">
                            <i class="fa fa-gear"></i>主题
                        </a>
                    </li>
                    <li class="">
                    	<a data-toggle="tab" href="#tab-2">通知</a>
                    </li>
                </ul>

                <div class="tab-content">
                    <div id="tab-1" class="tab-pane active">
                        <div class="sidebar-title">
                            <h3> <i class="fa fa-comments-o"></i> 主题设置</h3>
                            <small><i class="fa fa-tim"></i> 你可以从这里选择和预览主题的布局和样式，这些设置会被保存在本地，下次打开的时候会直接应用这些设置。</small>
                        </div>
                        <div class="skin-setttings">
                            <div class="title">主题设置</div>
                            <div class="setings-item">
                                <span>收起左侧菜单</span>
                                <div class="switch">
                                    <div class="onoffswitch">
                                        <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="collapsemenu">
                                        <label class="onoffswitch-label" for="collapsemenu">
                                            <span class="onoffswitch-inner"></span>
                                            <span class="onoffswitch-switch"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="setings-item">
                                <span>固定顶部</span>
                                <div class="switch">
                                    <div class="onoffswitch">
                                        <input type="checkbox" name="fixednavbar" class="onoffswitch-checkbox" id="fixednavbar">
                                        <label class="onoffswitch-label" for="fixednavbar">
                                            <span class="onoffswitch-inner"></span>
                                            <span class="onoffswitch-switch"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="setings-item">
                                <span>固定宽度</span>
                                <div class="switch">
                                    <div class="onoffswitch">
                                        <input type="checkbox" name="boxedlayout" class="onoffswitch-checkbox" id="boxedlayout">
                                        <label class="onoffswitch-label" for="boxedlayout">
                                            <span class="onoffswitch-inner"></span>
                                            <span class="onoffswitch-switch"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="title">皮肤选择</div>
                            <div class="setings-item default-skin nb">
                                <span class="skin-name ">
                         			<a href="#" class="s-skin-0">默认皮肤</a>
                    			</span>
                            </div>
                            <div class="setings-item blue-skin nb">
                                <span class="skin-name ">
                        <a href="#" class="s-skin-1">蓝色主题</a>
                    </span>
                            </div>
                            <div class="setings-item yellow-skin nb">
                                <span class="skin-name ">
                        <a href="#" class="s-skin-3">黄色/紫色主题</a>
                    </span>
                            </div>
                        </div>
                    </div>
                    <div id="tab-2" class="tab-pane">

                        <div class="sidebar-title">
                            <h3> <i class="fa fa-comments-o"></i> 最新通知</h3>
                            <small><i class="fa fa-tim"></i> 您当前有5条未读信息...</small>
                        </div>

                        <div>

                            <div class="sidebar-message">
                                <a href="#">
                                    <div class="pull-left text-center">
                                        <img alt="image" class="img-circle message-avatar" src="<%=path%>/statics/img/a1.jpg"/>

                                        <div class="m-t-xs">
                                            <i class="fa fa-star text-warning"></i>
                                            <i class="fa fa-star text-warning"></i>
                                        </div>
                                    </div>
                                    <div class="media-body">
                                       	 据天津日报报道：瑞海公司董事长于学伟，副董事长董社轩等10人在13日上午已被控制。
                                        <br>
                                        <small class="text-muted">今天 4:21</small>
                                    </div>
                                </a>
                            </div>
                          </div> 
                    </div>
                </div>

            </div>
        </div>
        
        <!--右侧边栏结束-->
        <div id="update-adminuser-modal" class="modal inmodal" tabindex="-1" role="dialog" aria-hidden="true" >
			<div class="modal-dialog">
				<div class="modal-content animated fadeIn">
					<div class="modal-header">
						<button class="close" type="button" data-dismiss="modal">
							<span aria-hidden="true">×</span>
							<span class="sr-only">Close</span>
						</button>
						<h3 align="left" >修改密码</h3>
					</div>
					
					<form  id="update-adminuser-form" action="<%=path%>/admin/changeAdminUserPassword.shtml" method="post" class="form-horizontal">
						<div class="modal-body">
							<div class="row">
							     <div class="form-group">
							        <label class="col-sm-3 control-label">邮箱：</label>
							        <div class="col-sm-9">
							            <input id="update-adminUser-email"  name="email" readonly="readonly"  value="${adminUser.username}" class="form-control" type="email">
							        </div>
							    </div>
							
							    <div class="form-group">
							        <label class="col-sm-3 control-label">用户名：</label>
							        <div class="col-sm-9">
							            <input id="update-adminUser-nickanem" maxlength="18" readonly="readonly" required=""  name="nickname"  value="${adminUser.nickname}" class="form-control" type="text">
							        </div>
							    </div>
							    <div class="form-group">
							        <label class="col-sm-3 control-label">旧密码：</label>
							        <div class="col-sm-9">
							            <input id="oldpwd" name="oldPassword"  required="" rangelength="[6,15]"  class="form-control"  type="password">
							        </div>
							    </div>
							   
							    <div class="form-group">
							        <label class="col-sm-3 control-label">新密码：</label>
							        <div class="col-sm-9">
							            <input id="newpwd" name="newPassword" required="" rangelength="[6,15]"  class="form-control" type="password"> 
							        </div>
							    </div>
							     <div class="form-group">
							        <label class="col-sm-3 control-label">确认密码：</label>
							        <div class="col-sm-9">
							            <input id="renewpwd" equalTo= "#newpwd" required="" rangelength="[6,15]" class="form-control" type="password"> 
							        </div>
							    </div>
							</div>
						</div>
						<div class="modal-footer">
						    <button class="btn btn-primary" type="submit" id="update-adminuser-btn-do">保存</button>
							<button class="btn btn-white" type="button" data-dismiss="modal">关闭</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		
		<!-- 修改个人信息 -->
		<div id="update-adminuser-modal2" class="modal inmodal" tabindex="-1" role="dialog" aria-hidden="true" >
			<div class="modal-dialog">
				<div class="modal-content animated fadeIn">
					<div class="modal-header">
						<button class="close" type="button" data-dismiss="modal">
							<span aria-hidden="true">×</span>
							<span class="sr-only">Close</span>
						</button>
						<h3 align="left" >修改信息</h3>
					</div>
					
					<form  id="update-adminuser-form2" action="<%=path%>/admin/updateAdminuser.shtml" method="post" class="form-horizontal" enctype="multipart/form-data">
						<div class="modal-body">
							<div class="row">
							     <div class="form-group">
							        <label class="col-sm-3 control-label">用户名：</label>
							        <div class="col-sm-9">
							            <input id="email"  name="email" readonly="readonly"  value="${adminUser.username}" class="form-control" type="email">
							        </div>
							    </div>
							    <div class="form-group">
							        <label class="col-sm-3 control-label">用户昵称：</label>
							        <div class="col-sm-9">
							            <input id="nickname" maxlength="18" required=""  name="nickname"  value="${adminUser.nickname}" class="form-control" type="text">
							        </div>
							    </div>
							    <div class="form-group">
							        <label class="col-sm-3 control-label">电话：</label>
							        <div class="col-sm-9">
							            <input id="phone" maxlength="11" name="phone"  value="${adminUser.phone}" class="form-control" type="text">
							        </div>
							    </div>
							    <div class="form-group">
							    	<label class="col-sm-3 control-label">用户头像：</label>
							    	<div class="col-sm-9">
										<input type="file" name="imgFile" id="wooldailycover-img" onchange="preImgBut(this.id,'wooldailycoverImgPic','deleteImgPic','delImgPicFlag');">
										<button onclick="deleteImg(this, 'imgContent', 'wooldailycoverImgPic','delImgPicFlag');" id="deleteImgPic" type="button" class="close hidden" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			                        	<input id="delImgPicFlag" name="delImgPicFlag" type="hidden" value="0">
			                        	<img src="${adminUser.headimg}" id="wooldailycoverImgPic" width="64px" height="64px">
		                        	</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
						    <button class="btn btn-primary" type="submit" id="update-adminuser-btn2-do">保存</button>
							<button class="btn btn-white" type="button" data-dismiss="modal">关闭</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<jsp:include page="/common/footer.jsp" />
    </div>
    
    <script type="text/javascript" src="<%=path%>/statics/js/plugins/validate/jquery.validate.min.js"></script>
    <script type="text/javascript" src="<%=path%>/statics/js/plugins/validate/messages_zh.min.js"></script>
    
    <script type="text/javascript" src="<%=path%>/statics/adminjs/index.js"></script>
    
    <script type="text/javascript" src="<%=path%>/statics/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script type="text/javascript" src="<%=path%>/statics/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script type="text/javascript" src="<%=path%>/statics/js/hplus.min.js"></script>
    <script type="text/javascript" src="<%=path%>/statics/js/contabs.min.js"></script>
    <script type="text/javascript" src="<%=path%>/statics/js/plugins/pace/pace.min.js"></script>
   
</body>
</html>