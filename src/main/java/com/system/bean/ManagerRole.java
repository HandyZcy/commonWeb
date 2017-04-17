package com.system.bean;

import java.util.Date;

/**
 * t_manager_role 表对应的实体类
 *    
 * @author Handy
 * @date 2016年6月1日下午12:00:23
 */
public class ManagerRole {

	private Integer id;
	private Integer managerId;
	private Integer roleId;
	private Date createdAt;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getManagerId() {
		return managerId;
	}

	public void setManagerId(Integer managerId) {
		this.managerId = managerId;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

}
