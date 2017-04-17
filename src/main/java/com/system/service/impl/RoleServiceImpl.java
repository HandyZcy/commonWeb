package com.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.system.bean.Page;
import com.system.bean.PageData;
import com.system.bean.Role;
import com.system.dao.DAO;
import com.system.service.ManagerRoleService;
import com.system.service.RoleService;

@Service(value = "roleService")
public class RoleServiceImpl implements RoleService {

	private static Logger logger = LoggerFactory.getLogger(RoleService.class);

	@Resource(name = "dao")
	private DAO<Role> dao;
	
	@Autowired
	private ManagerRoleService managerRoleService;
	

	@Override
	public List<Role> findByListPage(Page page) {
		List<Role> roleList = null;
		roleList = dao.findForList("RoleMapper.findByListPage", page);
		return roleList;
	}

	@Override
	public Role getRoleInfoById(int roleId) {
		Role role = null;
		role = dao.findForObject("RoleMapper.getRoleById", roleId);
		return role;
	}

	@Override
	public JSONObject saveOrUpdate(Role role) {
		JSONObject result = new JSONObject();
		try {
			if (role.getId() != null) {//修改
				int rowNum = (int) dao.update("RoleMapper.update", role);
				if (rowNum == 1) {
					result.put("status", 1);
					result.put("message", "操作成功");
					result.put("role", role);
				} else {
					result.put("status", -2);
					result.put("message", "执行结果异常，请稍候重试");
				}
			} else {//增加
				int rowNum = (int) dao.save("RoleMapper.insert", role);
				if (rowNum == 1) {
					result.put("status", 1);
					result.put("message", "操作成功");
					result.put("role", role);
				} else {
					result.put("status", -2);
					result.put("message", "执行结果异常，请稍候重试");
				}
			}
		} catch (Exception e) {
			logger.error("exception-info", e);
			result.put("status", -2);
			result.put("message", "数据操作异常，请稍候重试");
		}
		return result;
	}

	@Override
	public JSONObject delRoleById(int roleId) {
		JSONObject result = new JSONObject();
		int managerNum = managerRoleService.getManagerNumByRoleId(roleId);
		if (managerNum > 0) {
			result.put("status", "-1");
			result.put("message", "此角色有管理员帐号正在使用，请先删除相关的管理员再删除此角色。");
			return result;
		}
		try {
			int rowNum = (int) dao.delete("RoleMapper.delRoleById", roleId);
			if (rowNum == 1) {
				result.put("status", 1);
				result.put("message", "操作成功");
			} else {
				result.put("status", "-2");
				result.put("message", "执行结果异常，请稍候重试");
			}
		} catch (Exception e) {
			logger.error("删除角色异常", e);
			result.put("status", -2);
			result.put("message", "数据操作异常，请稍候重试");
		}
		return result;
	}

	@Override
	public JSONObject saveAssignRight(int roleId, String rightIds) {
		JSONObject result = new JSONObject();
		if (!StringUtils.isEmpty(rightIds)) {
			try {
				dao.delete("RoleRightMapper.clearByRoleId", roleId);
				PageData pd = new PageData();
				pd.put("roleId", roleId);
				pd.put("rightIds", rightIds.split(","));
				dao.save("RoleRightMapper.insert", pd);
				result.put("status", "1");
				result.put("message", "");
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", "-2");
				result.put("message", "数据操作异常，请稍后重试");
			}
		} else {
			result.put("status", "-2");
			result.put("message", "参数异常，请稍后重试");
		}
		return result;
	}

	@Override
	public List<Role> findAllRole() {
		List<Role> roleList = null;
		roleList = dao.findForList("RoleMapper.findAllRole", null);
		return roleList;
	}

	@Override
	public List<Role> getRoleListByManagerId(Integer managerId) {
		if (managerId == null) {
			return null;
		}
		return dao.findForList("RoleMapper.getRoleListByManagerId", managerId);
	}
	
	

}
