package com.system.dao;

import java.util.List;
import java.util.Map;

public interface DAO<T> {

	/**
	 * 保存对象
	 * @param mapperId
	 * @param record
	 * @return int：操作影响记录数
	 */
	public int save(String mapperId, Object record);

	/**
	 * 修改对象
	 * @param mapperId
	 * @param record
	 * @return int：操作影响记录数
	 */
	public int update(String mapperId, Object record);

	/**
	 * 删除对象 
	 * @param mapperId
	 * @param record：要删除的对象，包含可以唯一标识对象的属性
	 * @return int：操作影响记录数
	 */
	public int delete(String mapperId, Object record);

	/**
	 * 查找对象
	 * @param mapperId
	 * @param record
	 * @return T 
	 */
	public T findForObject(String mapperId, Object record);

	/**
	 * 查找对象
	 * @param mapperId
	 * @param record
	 * @return
	 */
	public List<T> findForList(String mapperId, Object record);
	
	/**
	 * 统计数量
	 * @param mapperId
	 * @param obj
	 * @return
	 */
	public int findForCount(String mapperId, Object obj);

	/**
	 * 查找对象封装成Map
	 * @param s
	 * @param obj
	 * @return
	 */
	public Map<Object, Object> findForMap(String sql, Object obj, String key, String value);

}
