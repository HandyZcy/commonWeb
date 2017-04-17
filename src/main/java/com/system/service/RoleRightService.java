package com.system.service;

import java.util.List;

import com.system.bean.RoleRight;

public interface RoleRightService {

	/**
	 * 根据角色id获取权限id列表
	 * @param roleId
	 * @return null 或者 角色id对应权限id列表
	 */
	List<RoleRight> findAllRightByRoleId(Integer roleId);
}
