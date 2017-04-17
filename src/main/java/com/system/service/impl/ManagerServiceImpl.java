package com.system.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.system.bean.Manager;
import com.system.bean.Page;
import com.system.bean.PageData;
import com.system.dao.DAO;
import com.system.service.ManagerService;

@Service(value = "managerService")
public class ManagerServiceImpl implements ManagerService {

	@Resource(name = "dao")
	private DAO<Manager> dao;
	
	private Logger logger = LoggerFactory.getLogger(ManagerServiceImpl.class);

	@Override
	public List<Manager> getManagerListPage(Page page) {
		List<Manager> ManagerList = dao.findForList("ManagerMapper.getManagerListPage", page);
		return ManagerList;
	}

	@Override
	public Manager getManagerById(Integer ManagerId) {
		Manager manager = null;
		if (ManagerId != null) {
			try {
				manager = dao.findForObject("ManagerMapper.getById", ManagerId);
			} catch (Exception e) {
				logger.error("查询异常", e);
			}
		}
		return manager;
	}

	@Override
	public JSONObject getManagerByNickname(String nickname) {
		JSONObject result = new JSONObject();
		Manager manager = dao.findForObject("ManagerMapper.getByNickname", nickname);
		result.put("status", "1");
		result.put("message", "");
		result.put("data", manager);
		return result;
	}


	@Override
	public JSONObject delManagerById(Integer managerId) {
		JSONObject result = new JSONObject();
		if (managerId != null) {
			try {
				int rowNum = (int) dao.delete("ManagerMapper.delManagerById", managerId);
				if (rowNum == 1) {
					dao.delete("ManagerRoleMapper.clearRoleByManagerId", managerId);
					result.put("status", 1);
					result.put("message", "操作成功");
				} else {
					result.put("status", "-2");
					result.put("message", "执行结果异常，请稍候重试");
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "数据操作异常，请稍候重试");
			}
		} else {
			result.put("status", -2);
			result.put("message", "参数异常");
		}
		return result;
	}

	@Override
	public JSONObject saveOrUpdateManager(Manager manager, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		try {
			String[] ManagerRoleIds = request.getParameterValues("roleIds");
			if (manager.getId() != null) {//修改
				Manager dbManager = this.getManagerById(manager.getId());
				if (dbManager != null) {
					String dbPwd = dbManager.getPwd();
					//处理密码修改加密问题
					if (dbPwd != null && !dbPwd.equals(manager.getPwd())) {
//						manager.setPwd(Digests.encryptPassword(manager.getPwd(), manager.getSalt()));
					}
				}
				int rowNum = (int) dao.update("ManagerMapper.update", manager);
				if (rowNum == 1) {
					result.put("status", "1");
					result.put("message", "操作成功");
				} else {
					result.put("status", "-2");
					result.put("message", "执行结果异常，请稍候重试");
				}
			} else {//增加
//				manager.setPwd(Digests.encryptPassword(manager.getPwd(), manager.getSalt()));
				int rowNum = (int) dao.save("ManagerMapper.insert", manager);
				if (rowNum == 1) {
					result.put("status", "1");
				} else {
					result.put("status", "-2");
					result.put("message", "执行结果异常，请稍候重试");
				}
			}
			//维护 Manager 和 role 的关联关系表 t_Manager_role
			if (result.getIntValue("status") == 1) {
				//清除原有关联关系
				dao.delete("ManagerRoleMapper.clearRoleByManagerId", manager.getId());
				PageData ManagerRolePd = new PageData();
				ManagerRolePd.put("managerId", manager.getId());
				ManagerRolePd.put("roleIds", ManagerRoleIds);
				//建立新关联关系
				dao.save("ManagerRoleMapper.saveManagerRole", ManagerRolePd);
			}
		} catch (Exception e) {
			logger.error("保存Manager信息时异常", e);
			result.put("status", "-2");
			result.put("message", "数据操作异常，请稍候重试");
			throw new RuntimeException("手动抛出异常，回滚事务");
		}
		return result;
	}


	@Override
	public JSONObject editManagerBase(Manager manager) {
		JSONObject result = new JSONObject();
//		Manager.setPwd(Digests.encryptPassword(manager.getPwd(), manager.getSalt()));
		int rowNum = (int) dao.update("ManagerMapper.update", manager);
		if (rowNum == 1) {
			result.put("status", "1");
			result.put("message", "操作成功");
		} else {
			result.put("status", "-2");
			result.put("message", "执行结果异常，请稍候重试");
		}
		return result;
	}
}
