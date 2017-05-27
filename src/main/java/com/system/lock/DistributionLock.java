package com.system.lock;

/**
 * 创建时间：2016年12月8日 下午6:51:51
 * 
 * 分布式锁
 * 
 * @author andy
 * @version 2.2
 */

public interface DistributionLock {

	//加锁 加锁成功后返回加锁时间
	public Long lock(String lockKey);
	
	//解锁  
	public void unlock(String lockKey, long lockvalue);
}
