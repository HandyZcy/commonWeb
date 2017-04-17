package test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.system.service.RightService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath*:/config/spring/spring-config.xml"})
public class MybatisCacheTest {

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
