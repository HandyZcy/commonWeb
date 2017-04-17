package com.system.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.system.bean.ManagerRole;
import com.system.dao.DAO;
import com.system.service.ManagerRoleService;

@Service("managerRoleService")
public class ManagerRoleServceImpl implements ManagerRoleService{

	@Autowired
	private DAO<ManagerRole> dao;
	
	@Override
	public int getManagerNumByRoleId(Integer roleId) {
		if (roleId == null) {
			return 0;
		}
		return dao.findForCount("ManagerRoleMapper.getManagerNumByRoleId", roleId);
	}

}
