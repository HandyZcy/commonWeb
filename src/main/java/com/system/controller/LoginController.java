package com.system.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.system.bean.Manager;
import com.system.bean.Right;
import com.system.bean.Role;
import com.system.service.RightService;
import com.system.utils.Constant;
import com.system.utils.Digests;
import com.system.utils.TreeUtil;

@Controller
public class LoginController extends BaseController{

	Logger logger = LoggerFactory.getLogger(LoginController.class);
	
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
		String nickName = manager.getNickname();
		String password = manager.getPwd();
		if (StringUtils.isEmpty(nickName) || StringUtils.isEmpty(password)) {
			model.addAttribute("backMsg", "请完善登录信息");
			return "login";
		}
		Subject currentUser = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(nickName, Digests.encryptPassword(password, manager.getSalt()));
		try {
			//token.setRememberMe(true);
			currentUser.login(token);
		} catch (LockedAccountException lae) {
			token.clear();
			model.addAttribute("error", "用户已经被锁定不能登录，请与管理员联系！");
			return "login";
		} catch (ExcessiveAttemptsException e) {
			token.clear();
			model.addAttribute("error", "账号：" + nickName + " 登录失败次数过多!");
			return "login";
		} catch (AuthenticationException e) {
			this.logger.error("exception-info", e);
			token.clear();
			model.addAttribute("error", "用户或密码不正确！");
			return "login";
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
		Session session = SecurityUtils.getSubject().getSession();
		Manager currentUser = (Manager) session.getAttribute(Constant.MANAGER_SESSION_KEY);
		List<Right> rightList = null;
		if (currentUser == null) {
			return null;
		}
		if (currentUser.getNickname().equals(Constant.SUPER_ADMIN_NAME)) {
			rightList = rightService.getAllRight();
		} else {
			//1、获取用户角色列表
			List<Role> roleList = currentUser.getRoleList();
			
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
