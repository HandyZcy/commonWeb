package com.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.system.bean.Manager;
import com.system.bean.Page;
import com.system.bean.PageData;
import com.system.service.ManagerService;
import com.system.service.RoleService;

@Controller
@RequestMapping(value = "/manager")
public class ManagerController extends BaseController {

	@Autowired
	private ManagerService managerService;
	
	@Autowired
	private RoleService roleService;

	/**
	 * 分页获取用户列表
	 * @param model
	 * @param page
	 * @return
	 * @throws Exception   
	 * @author Handy
	 * @date 2016年6月1日上午10:09:34
	 */
	@RequestMapping(value = "/getManagerList")
	public String getManagerList(Model model, Page page) {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<Manager> managerList = managerService.getManagerListPage(page);
		model.addAttribute("page", page);
		model.addAttribute("managerList", managerList);
		return "/system/managermanage";
	}

	/**
	 * 根据id删除对应数据
	 * @param managerId
	 * @return   
	 * @author Handy
	 * @date 2016年6月1日上午10:58:47
	 */
	@RequestMapping(value = "/delById")
	@ResponseBody
	public JSONObject delManagerById(Integer managerId) {
		return managerService.delManagerById(managerId);
	}

	/**
	 * 根据id获取用户详情
	 * @param managerId
	 * @param model
	 * @return   
	 * @author Handy
	 * @date 2016年6月1日上午11:14:01
	 */
	@RequestMapping(value = "/preEdit")
	@ResponseBody
	public JSONObject getUserInfoById(Integer managerId, Model model) {
		JSONObject jo = new JSONObject();
		Manager manager = null;
		if (managerId != null) {//修改
			manager = managerService.getManagerById(managerId);
		} else {//新增
			manager = new Manager();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("manager", manager);
		// 获取管理员角色
		map.put("list", roleService.findAllRole());
		
		jo.put("status", 1);
		jo.put("data", map);
		return jo;
	}

	/**
	 * 保存信息（id 属性值为空，执行新增，否则更新）
	 * @param manager
	 * @param request
	 * @return   
	 * @author Handy
	 * @date 2016年6月1日上午11:14:34
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public JSONObject saveOrUpdate(Manager manager, HttpServletRequest request) {
		JSONObject result = null;
		try {
			result = managerService.saveOrUpdateManager(manager, request);
		} catch (Exception e) {
			result = new JSONObject();
			result.put("status", "-2");
			result.put("message", "操作异常，请稍候重试");
		}
		return result;
	}

	/**
	 * 修改个人信息跳转页面
	 * @param userId
	 * @param model
	 * @return   
	 * @author Handy
	 * @date 2016年6月1日上午11:38:29
	 */
	@RequestMapping(value = "/preEditPwd")
	public String preEditPwd(String userId, Model model) {
		try {
			Integer.valueOf(userId);
		} catch (Exception e) {
			model.addAttribute("error", "User Id 异常");
		}
		model.addAttribute("userId", userId);
		return "/system/manager/manager-edit-pwd";
	}

	/**
	 * 更新用户基本信息（不涉及关联表业务处理）
	 * @param manager
	 * @return   
	 * @author Handy
	 * @date 2016年7月4日下午3:49:23
	 */
	@RequestMapping(value = "/editUserBase")
	@ResponseBody
	public JSONObject editUserBase(Manager manager, String oldpwd) {
		JSONObject result = null;
		try {
			if (StringUtils.isNotEmpty(oldpwd)) {
				//修改密码
//				Manager dbManager = managerService.getManagerById(manager.getId());
//				String encryptOldpwd = Digests.encryptPassword(oldpwd, manager.getSalt());
//				//比较加密后的旧密码是否和数据库一致，不一致则返回修改页面
//				if (!encryptOldpwd.equals(dbManager.getPwd())) {
//					result = new JSONObject();
//					result.put("status", "-1");
//					result.put("message", "旧密码输入错误");
//					return result;
//				}
			}

			result = managerService.editManagerBase(manager);
		} catch (Exception e) {
			result = new JSONObject();
			result.put("status", "-2");
			result.put("message", "操作异常，请稍候重试");
		}
		return result;
	}

}
