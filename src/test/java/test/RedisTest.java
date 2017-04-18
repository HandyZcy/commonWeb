package test;

import java.io.Serializable;
import java.util.Iterator;
import java.util.Set;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;

public class RedisTest extends BaseJunitTest{

	@Autowired
	private RedisTemplate<Serializable, Serializable> redisTemplate;
	
	JdkSerializationRedisSerializer jdkSerialization = new JdkSerializationRedisSerializer();
	
	@Test
	public void test() {
		Long dbSize = redisTemplate.execute(new RedisCallback<Long>() {
			@Override
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				return connection.dbSize();
			}
		});
		System.out.println(dbSize);
		Set<Serializable> keySet = redisTemplate.keys("*");
		Iterator<Serializable> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = (String) iterator.next();
			System.out.println(key);
		}
	}

}
