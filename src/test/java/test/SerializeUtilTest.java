package test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

import org.junit.Test;

import com.system.utils.SerializerUtil;

public class SerializeUtilTest {

	@Test
	public void test() {
		List<String> list = new ArrayList<String>();
        list.add("测试list");
        list.add("测试list2");
        
        HashMap<String,Object> map = new HashMap<String, Object>();
        map.put("test*","测试数据");
        map.put("测试数据","啥的");
        map.put("listTest",list);
        
        byte[] bytes = SerializerUtil.serialize(map);
        
        HashMap<String,Object> deserializeMap = SerializerUtil.deserialize(bytes);
        
        System.out.println("===================================================");
        Set<Entry<String, Object>> entries = deserializeMap.entrySet();
        Iterator<Entry<String, Object>> iterator = entries.iterator();
        while (iterator.hasNext()) {
			Entry<String, Object> entry = iterator.next();
			System.out.println(entry.getKey() + "++++++++++" +  entry.getValue());
			
		}
	}

}
