package org.xkj.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.xkj.crud.bean.Employee;

import com.github.pagehelper.PageInfo;

/**
 * 使用Spring测试模块提供的测试请求功能，测试crud请求的正确性
 * Spring4测试的时候,需要Servlet3.0的支持，导入2.5就会出错
 * @author Administrator
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // 自动装配springmvc IOC容器
@ContextConfiguration(locations = { "classpath:applicationContext.xml", "classpath:springmvc-servlet.xml" })
public class MvcTest {

	// 传入springmvc的IOC,但是IOC容器无法自动装配，必须使用注解
	@Autowired
	WebApplicationContext context;

	// 虚拟mvc请求，获取到处理结果
	MockMvc mockMvc;

	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}

	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();
		//请求成功以后，请求域中会有pageinfo；我们可以取出pageInfo进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo<Employee> pageInfo = (PageInfo<Employee>) request.getAttribute("pageInfo");
		System.out.println("当前页码："+pageInfo.getPageNum());
		System.out.println("总页码："+pageInfo.getPages());
		System.out.println("总记录数："+pageInfo.getTotal());
		System.out.println("在页面需要连续显示的页码");
		int[] nums = pageInfo.getNavigatepageNums();
		for(int i : nums) {
			System.out.print(i + " ");
		}
		System.out.println();
		
		//获取员工数据
		List<Employee> list = pageInfo.getList();
		for(Employee employee : list) {
			System.out.println(employee);
		}
	}

}
