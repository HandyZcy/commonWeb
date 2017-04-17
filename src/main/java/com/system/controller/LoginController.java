package com.system.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.system.bean.Manager;
import com.system.bean.Right;
import com.system.bean.Role;
import com.system.service.ManagerService;
import com.system.service.RightService;
import com.system.service.RoleService;
import com.system.utils.Constant;
import com.system.utils.TreeUtil;

@Controller
public class LoginController extends BaseController{

	Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private ManagerService managerService;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private RightService rightService;
	
	/**
	 * 转到登录页
	 * @return
	 */
	@RequestMapping("/toLogin")
	public String toLogin(){
		return "login";
	}
	
	/**
	 * 登录信息验证
	 * @param request
	 * @param manager
	 * @return
	 */
	@RequestMapping("/login")
	public String login(HttpServletRequest request,Manager manager, Model model){
		//根据验证结果处理
		HttpSession session = request.getSession();
		if (StringUtils.isEmpty(manager.getNickname()) || StringUtils.isEmpty(manager.getPwd())) {
			model.addAttribute("backMsg", "请完善登录信息");
			return "login";
		}
		JSONObject jsonObject = managerService.getManagerByNickname(manager.getNickname());
		Object object = jsonObject.get("data");
		if(object != null){
			Manager dbManager = (Manager) object;
			//TODO 处理登录信息验证
			session.setAttribute("currentUser", dbManager);
		}else{
			if (Constant.SUPER_ADMIN_NAME.equals(manager.getNickname())) {
				session.setAttribute("currentUser", manager);
			}
		}
		return "redirect:loginSuccess";
	}
	
	
	/**
	 * 加载主页数据
	 * @return
	 */
	@RequestMapping("/loginSuccess")
	public String loginSuccess(){
		return "index";
	}
	
	/**
	 * 获取当前用户的权限列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getMenuList")
	@ResponseBody
	public List<Right> getMenuList(HttpServletRequest request){
		//处理当前用户的角色信息
		HttpSession session = this.getRequest().getSession();
		Manager currentUser = (Manager) session.getAttribute("currentUser");
		List<Right> rightList = null;
		if (currentUser == null) {
			return null;
		}
		if (currentUser.getNickname().equals(Constant.SUPER_ADMIN_NAME)) {
			rightList = rightService.getAllRight();
		} else {
			//1、获取用户角色列表
			List<Role> roleList = roleService.getRoleListByManagerId(currentUser.getId());
			StringBuffer userRoleIds = new StringBuffer();
			for (Role role : roleList) {
				userRoleIds.append(role.getId());
				userRoleIds.append(",");
			}
			if (userRoleIds.length() > 0) {
				userRoleIds.deleteCharAt(userRoleIds.length() - 1);
			}
			//2、获取用户权限列表
			rightList = rightService.getRightByRoleId(userRoleIds.toString());
		}
		
		//3、处理权限列表子父级关系
		TreeUtil treeUtil = new TreeUtil();
		List<Right> menuList = treeUtil.getChildRights(rightList, 1);
		return menuList;
	}
	
}
