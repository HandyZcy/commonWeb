package com.system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.system.bean.Page;
import com.system.bean.PageData;
import com.system.bean.Role;
import com.system.bean.RoleRight;
import com.system.service.RoleRightService;
import com.system.service.RoleService;

@Controller
@RequestMapping(value = "/role")
public class RoleController extends BaseController {

	@Autowired
	private RoleService roleService;
	
	@Autowired
	private RoleRightService roleRightService;

	/**
	 * 翻页获取角色列表
	 * @param model
	 * @param page
	 * @return
	 * @author Handy
	 * @date 2016年5月30日下午9:35:00
	 */
	@RequestMapping(value = "/getRoleList")
	public String getRoleList(Model model, Page page) {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<Role> roleList = roleService.findByListPage(page);
		model.addAttribute("page", page);
		model.addAttribute("roleList", roleList);
		return "/system/rolemanage";
	}

	/**
	 * 到信息展示页
	 * @param roleId
	 * @return   
	 * @author Handy
	 * @date 2016年5月30日下午9:37:07
	 */
	@RequestMapping(value = "/getById")
	@ResponseBody
	public JSONObject preEditRole(Integer roleId) {
		Role role = null;
		if (roleId != null) {//修改
			role = roleService.getRoleInfoById(roleId);
		} else {//新增
			role = new Role();
		}
		JSONObject jo = new JSONObject();
		jo.put("status", 1);
		jo.put("data", role);
		return jo;
	}

	/**
	 * 保存角色信息（id属性值非空进行修改，否则进行新增）
	 * @param role
	 * @return   
	 * @author Handy
	 * @date 2016年5月30日下午9:37:31
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public JSONObject saveOrUpdate(Role role) {
		return roleService.saveOrUpdate(role);
	}

	/**
	 * 删除
	 * @param roleId
	 * @return   
	 * @author Handy
	 * @date 2016年5月30日下午9:40:58
	 */
	@RequestMapping(value = "/delById")
	@ResponseBody
	public JSONObject delRoleById(Integer roleId) {
		return roleService.delRoleById(roleId);
	}

	/**
	 * 获取角色权限列表
	 * @param roleId
	 * @return   
	 * @author Handy
	 * @date 2016年1月7日下午8:16:58
	 */
	@RequestMapping("/getRoleRightById")
	@ResponseBody
	public JSONObject getRoleRightById(Integer roleId) {
		JSONObject jo = new JSONObject();
		if (roleId != null) {//查询角色已有权限
			List<RoleRight> roleRightList = roleRightService.findAllRightByRoleId(roleId);
			jo.put("data", roleRightList);
		}
		jo.put("status", 1);
		return jo;
	}

	/**
	 * 保存角色分配的权限
	 * @return   
	 * @author Handy
	 * @date 2016年1月8日下午2:18:06
	 */
	@RequestMapping(value = "/saveRoleRight")
	@ResponseBody
	public JSONObject saveRoleRight(Integer roleId, String rightIds) {
		return roleService.saveAssignRight(roleId, rightIds);
	}
}
