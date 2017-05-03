package test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.system.service.ManagerService;
import com.system.service.RightService;
import com.system.utils.SpringContextHolder;

public class MybatisCacheTest extends BaseJunitTest{

	@Autowired
	private RightService rightService;
	
	@Test
	public void mybatisCacheTest() {
		rightService.getAllRight();
		System.out.println("+++++++++++++++++++++++++++++++++++++");
		rightService.getRightByRoleId("3");
		System.out.println("+++++++++++++++++++++++++++++++++++++");
		rightService.getAllRight();
	}

	@Test
	public void testSpringContextHolder(){
		ManagerService managerService = SpringContextHolder.getBean(ManagerService.class);
		System.out.println("=============================================="+managerService.toString());
		System.out.println(SpringContextHolder.getBean("redisTemplate").toString());
	}
}
