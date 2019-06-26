package org.xkj.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xkj.crud.bean.Department;
import org.xkj.crud.bean.Msg;
import org.xkj.crud.service.DepartmentService;

/**
 * 处理和部门有关的请求
 * @author Administrator
 *
 */
@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
	
}
