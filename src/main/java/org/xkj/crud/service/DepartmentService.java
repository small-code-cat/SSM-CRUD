package org.xkj.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xkj.crud.bean.Department;
import org.xkj.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {

	@Autowired
	private DepartmentMapper departmentMapper;

	public List<Department> getDepts() {
		// 参数为null表示不带条件查询，即查询全部
		return departmentMapper.selectByExample(null);
	}

}
