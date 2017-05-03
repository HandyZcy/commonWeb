package com.system.shiro;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.system.utils.RedisManager;

public class RedisCacheManager implements CacheManager {
    
    private static final Logger logger = LoggerFactory.getLogger(RedisCacheManager.class);
    
    @SuppressWarnings("rawtypes")
    private final ConcurrentMap<String, Cache> caches = new ConcurrentHashMap<String, Cache>();  
    
    private RedisManager redisManager;  
  
    /** 
     * The Redis key prefix for caches  
     */  
    private String keyPrefix = "shiro_redis_cache:"; 
    
    @Override
    public <K, V> Cache<K, V> getCache(String name) throws CacheException {
        logger.debug("获取名称为: " + name + " 的RedisCache实例");
        @SuppressWarnings("unchecked")
        Cache<K, V> c = caches.get(name);
        if (c == null) {  
            
            // create a new cache instance  
            c = new RedisCache<K, V>(redisManager, keyPrefix);  
              
            // add it to the cache collection  
            caches.put(name, c);  
        }  
        return c;  
    }
    
    public RedisManager getRedisManager()
    {
        return redisManager;
    }
    
    public void setRedisManager(RedisManager redisManager)
    {
        this.redisManager = redisManager;
    }
    
}
