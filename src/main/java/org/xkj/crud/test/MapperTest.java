package org.xkj.crud.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.xkj.crud.bean.Employee;
import org.xkj.crud.dao.DepartmentMapper;
import org.xkj.crud.dao.EmployeeMapper;

//RunWith指定用什么模块来进行单元测试
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		System.out.println(departmentMapper);
		//1.插入几个部门
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
		
		//2.生成员工数据，测试员工插入
//		employeeMapper.insert(new Employee(null, "薛克军", "M", "983527960@qq.com", 1));
		
		//3.批量插入多个员工；批量，使用可以执行批量操作的SQLSession
		//这个mapper是可以执行BATCH的mapper
//		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//		for(int i=0; i<1000; i++) {
//			String uid = UUID.randomUUID().toString().substring(0, 5);
//			mapper.insertSelective(new Employee(null, uid, "M", uid+"@qq.com", 1));
//		}
		
		//4.查询员工数据
		Employee employee = employeeMapper.selectByPrimaryKeyWithDept(10);
		System.out.println(employee);
		
	}
}
