package com.system.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.system.bean.Manager;
import com.system.bean.Page;

public interface ManagerService {

	/**
	 * 分页获取账户信息
	 * @param page
	 * @return   
	 * @author Handy
	 * @date 2016年5月23日下午5:14:55
	 */
	public List<Manager> getManagerListPage(Page page);

	/**
	 * 保存信息（id 属性值为空，执行新增，否则更新）
	 * @param manager
	 * @param request
	 * @return   
	 * @author Handy
	 * @date 2016年6月1日上午11:16:54
	 */
	public JSONObject saveOrUpdateManager(Manager manager, HttpServletRequest request);

	/**
	 * 获取账户详情
	 * @param managerId
	 * @return   
	 * @author Handy
	 * @date 2016年5月23日下午5:11:09
	 */
	public Manager getManagerById(Integer managerId);

	/**
	 * 根据昵称获取用户信息
	 * @param nickname
	 * @return  
	 * @author Handy
	 * @date 2016年5月25日下午4:22:35
	 */
	public JSONObject getManagerByNickname(String nickname);

	/**
	 * 删除指定id用户
	 * @param managerId
	 * @return   
	 * @author Handy
	 * @date 2016年6月1日上午11:01:10
	 */
	public JSONObject delManagerById(Integer managerId);

	/**
	 * 更新用户信息（不涉及关联表业务处理）
	 * @param manager
	 * @return   
	 * @author Handy
	 * @date 2016年6月1日上午11:16:54
	 */
	public JSONObject editManagerBase(Manager manager);

}
