package com.system.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.system.bean.RoleRight;
import com.system.dao.DAO;
import com.system.service.RoleRightService;

@Service("roleRightService")
public class RoleRightServiceImpl implements RoleRightService {

	@Autowired
	private DAO<RoleRight> dao;
	
	@Override
	public List<RoleRight> findAllRightByRoleId(Integer roleId) {
		if (roleId == null) {
			return null;
		}
		return dao.findForList("RoleRightMapper.findAllRightByRoleId", roleId);
	}

}
