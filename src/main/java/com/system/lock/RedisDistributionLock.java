package com.system.lock;

import java.io.Serializable;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;

import com.system.utils.SpringContextHolder;



/**
 * redis分布式锁
 *
 * @author: HandyZcy 
 * @date:2017年5月18日下午12:27:33   
 *
 */

public class RedisDistributionLock implements DistributionLock{

	private static final long LOCK_TIMEOUT = 60 * 1000; //加锁超时时间 单位毫秒  意味着加锁期间内执行完操作 如果未完成会有并发现象
	
	private static final Logger LOG = LoggerFactory.getLogger(RedisDistributionLock.class); //redis锁日志
	
	@SuppressWarnings("unchecked")
	private static RedisTemplate<Serializable, Serializable> redisTemplate = (RedisTemplate<Serializable, Serializable>) SpringContextHolder
			.getBean("redisTemplate");
	
	/**
	 * 获取到锁加锁，取不到锁一直等待直到获得锁。
	 * 逻辑如下：
	 * 1、尝试获取锁：
	 *     获取锁的过程，其实就是通过 Redis setNX() 命令为 lockKey 设置 value( value = 系统当前时间 + 锁超时时间 + 1，即System.currentTimeMillis() + LOCK_TIMEOUT + 1)。
	 *     设置成功则获取锁成功，然后通过 Reids expire() 命令为 lockKey 设置超时时间；
	 * 2、如果操作1失败，代表锁已被其它线程获得，但是有一种情况是：
	 *     如果获得锁的线程异常结束或者其它原因，导致该线程不能正常释放已获得的锁，锁就会这种情况下就需要我们做释放锁的操作，否则获取锁会一直等待，
	 *  我们怎么判断锁是否超时了呢？
	 *  还记得我们第一次 setNX() 时，设置锁对应的 value 吗？对，就是通过锁的 value 和 当前系统时间做比较。
	 *  如果锁的 value 不为空，并且 value 小于 当前系统时间就可以判定，锁已超时且未被释放。
	 *  我们就可以通过 getSet() 命令为锁设置新值的 newValue，并且返回 oldValue，我们通过 oldValue 和 value进行比较，如果value == oldValue 则代表当前线程重新获取了锁。
	 *  当有多个线程同时检测到锁超时，因为判断了 value == oldValue，所以会只有一个线程获取到锁。
	 */
	@Override
	public synchronized Long lock(String lockKey) {
		LOG.info("开始执行加锁");
		while (true) { //循环获取锁
			Long lock_timeout = System.currentTimeMillis() + LOCK_TIMEOUT + 1; //锁时间
			if (redisTemplate.execute(new RedisCallback<Boolean>() {

				@Override
				public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
					JdkSerializationRedisSerializer jdkSerializer = new JdkSerializationRedisSerializer();
					byte[] value = jdkSerializer.serialize(lock_timeout);
					return connection.setNX(lockKey.getBytes(), value);
				}
			})) { //如果加锁成功
				LOG.info("加锁成功");
				redisTemplate.expire(lockKey, LOCK_TIMEOUT, TimeUnit.MILLISECONDS); //设置超时时间，释放内存
				return lock_timeout;
			}else {
				Long currt_lock_timeout_Str = (Long) redisTemplate.opsForValue().get(lockKey); // redis里的时间
				if (currt_lock_timeout_Str != null && currt_lock_timeout_Str < System.currentTimeMillis()) { //锁已经失效
					// 判断是否为空，不为空的情况下，说明已经失效，如果被其他线程设置了值，则第二个条件判断是无法执行
					
					Long old_lock_timeout_Str = (Long) redisTemplate.opsForValue().getAndSet(lockKey, lock_timeout);
					// 获取上一个锁到期时间，并设置现在的锁到期时间
					if (old_lock_timeout_Str != null && old_lock_timeout_Str.equals(currt_lock_timeout_Str)) {
						// 如过这个时候，多个线程恰好都到了这里，但是只有一个线程的设置值和当前值相同，他才有权利获取锁
						LOG.info("加锁成功");
						redisTemplate.expire(lockKey, LOCK_TIMEOUT, TimeUnit.MILLISECONDS); //设置超时时间，释放内存
						return lock_timeout;
					}
				}
			}
			
		    try {
				TimeUnit.MILLISECONDS.sleep(100);//睡眠100毫秒
			} catch (InterruptedException e) {
				e.printStackTrace();
			} 
		}
	}

	@Override
	public synchronized void unlock(String lockKey, long lockvalue) {
		LOG.info("开始执行解锁");
		Long currt_lock_timeout_Str = (Long) redisTemplate.opsForValue().get(lockKey); // redis里的时间
		if (currt_lock_timeout_Str != null && currt_lock_timeout_Str == lockvalue) {
			redisTemplate.delete(lockKey); //删除键 
			LOG.info("解锁成功");
		}
	}
	
	public long currtTimeFromRedis(){ //获取redis当前时间
		return redisTemplate.execute(new RedisCallback<Long>() {
			@Override
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				return connection.time();
			}
		});
	}
    
}
