package test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.system.utils.RedisManager;

/**
 * 
 * @ClassName:  RedisManagerTest   
 * @author: HandyZcy 
 * @date:2017年5月3日上午11:36:55   
 *
 */
public class RedisManagerTest extends BaseJunitTest{

	@Autowired
	private RedisManager redisManager;
	
	@Test
	public void testRedisManagerSetGet() {
		List<String> list = new ArrayList<String>();
        list.add("测试list");
        list.add("测试list2");
        
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("test*","测试数据");
        map.put("测试数据","啥的");
        map.put("listTest",list);
        redisManager.setEx("testMap2", map, 10);

        Map<String,Object> mapResult = redisManager.get("testMap2");
        System.out.println("===================================================");
        Set<Entry<String, Object>> entries = mapResult.entrySet();
        Iterator<Entry<String, Object>> iterator = entries.iterator();
        while (iterator.hasNext()) {
			Entry<String, Object> entry = iterator.next();
			System.out.println(entry.getKey() + "++++++++++" +  entry.getValue());
			
		}
	}
	
	@Test
	public void testDel(){
		long delNum = redisManager.del("testMap2");
		System.out.println("++++++++++++++++++++++++" + delNum);
	}
}
