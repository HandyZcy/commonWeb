package test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.system.service.RightService;

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

}
