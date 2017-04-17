package com.system.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository("dao")
public class DaoImpl<T> implements DAO<T> {

	@Resource(name = "sqlSession")
	private SqlSessionTemplate sqlSessionTemplate;

	/**
	 * 保存对象
	 * @param mapperId
	 * @param record
	 * @return
	 */
	public int save(String mapperId, Object record) {
		return sqlSessionTemplate.insert(mapperId, record);
	}

	/**
	 * 批量更新
	 * @param mapperId
	 * @param obj
	 * @return
	 */
	public int batchSave(String mapperId, List<Object> objs) {
		return sqlSessionTemplate.insert(mapperId, objs);
	}

	/**
	 * 修改对象
	 * @param mapperId
	 * @param obj
	 * @return
	 */
	public int update(String mapperId, Object obj) {
		return sqlSessionTemplate.update(mapperId, obj);
	}

	/**
	 * 批量更新
	 * @param mapperId
	 * @param obj
	 * @return
	 */
	public void batchUpdate(String mapperId, List<Object> objs) {
		SqlSessionFactory sqlSessionFactory = sqlSessionTemplate.getSqlSessionFactory();
		//批量执行器
		SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH, false);
		try {
			if (objs != null) {
				for (int i = 0, size = objs.size(); i < size; i++) {
					sqlSession.update(mapperId, objs.get(i));
				}
				sqlSession.flushStatements();
				sqlSession.commit();
				sqlSession.clearCache();
			}
		} finally {
			sqlSession.close();
		}
	}

	/**
	 * 批量更新
	 * @param mapperId
	 * @param obj
	 * @return
	 */
	public int batchDelete(String mapperId, List<Object> objs) {
		return sqlSessionTemplate.delete(mapperId, objs);
	}

	/**
	 * 删除对象 
	 * @param mapperId
	 * @param obj
	 * @return
	 */
	public int delete(String mapperId, Object obj) {
		return sqlSessionTemplate.delete(mapperId, obj);
	}

	/**
	 * 查找对象
	 * @param mapperId
	 * @param obj
	 * @return
	 */
	public T findForObject(String mapperId, Object obj) {
		return sqlSessionTemplate.selectOne(mapperId, obj);
	}

	@Override
	public int findForCount(String mapperId, Object obj) {
		return sqlSessionTemplate.selectOne(mapperId, obj);
	}
	
	/**
	 * 查找对象
	 * @param mapperId
	 * @param obj
	 * @return
	 */
	public List<T> findForList(String mapperId, Object obj) {
		return sqlSessionTemplate.selectList(mapperId, obj);
	}


	public Map<Object, Object> findForMap(String mapperId, Object obj, String key, String value) {
		return sqlSessionTemplate.selectMap(mapperId, obj, key);
	}


}
