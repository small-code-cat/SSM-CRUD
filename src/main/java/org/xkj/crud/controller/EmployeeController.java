package org.xkj.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xkj.crud.bean.Employee;
import org.xkj.crud.bean.Msg;
import org.xkj.crud.service.EmployeeService;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工的CRUD请求
 * 
 * @author Administrator
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	/**
	 * 将删除多个员工和删除单个员工合二为一
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids") String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			for (String str_id : str_ids) {
				del_ids.add(Integer.parseInt(str_id));
			}
			employeeService.deleteBatch(del_ids);
		} else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmpById(id);
		}
		return Msg.success();
	}
	
	/**
	 * 根据id修改员工信息
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 根据指定id查询员工信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("employee", employee);
	}

	/**
	 * 导入Jackson包，
	 * 
	 * @param pn 前段传来的页码
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		PageHelper.startPage(pn, 5);
		List<Employee> list = employeeService.getAll();
		PageInfo<Employee> pageInfo = new PageInfo<Employee>(list, 5);
		return Msg.success().add("pageInfo", pageInfo);
	}

	/**
	 * 员工保存
	 * 
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		Map<String, Object> errorMap = new HashMap<String, Object>();
		if (result.hasErrors()) {
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError error : errors) {
				errorMap.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.fail().add("errorMap", errorMap);
		} else {
			employeeService.saveEmp(employee);
			// 前台需要一个总页数来跳转到最后一页，所以在这里查询一下
			PageHelper.startPage(1, 5);
			List<Employee> list = employeeService.getAll();
			PageInfo<Employee> pageInfo = new PageInfo<Employee>(list);
			return Msg.success().add("pages", pageInfo.getPages());
		}
	}

	/**
	 * pages 检查用户名是否可用
	 * 
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName") String empName) {
		// 检查用户名是否合法
		String regx = "(^[a-zA-Z0-9_]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		if (!empName.matches(regx)) {
			return Msg.fail().add("vali_msg", "用户名可以是2-5位中文或者6-16位英文、数字和下划线的组合");
		}
		boolean flag = employeeService.checkUser(empName);
		if (flag) {
			return Msg.success().add("vali_msg", "用户名可以使用");
		} else {
			return Msg.fail().add("vali_msg", "用户名已被使用");
		}
	}

	/**
	 * 查询员工数据（分页查询）
	 * 
	 * @return
	 */
	// @RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 这不是一个分页查询；
		// 引入PageHelper分页插件
		// 在查询之前只需要调用,传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用pageinfo包装查询后的结果,只需要将Pageinfo交给页面就行了
		// 封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
		PageInfo<Employee> pageInfo = new PageInfo<Employee>(emps, 5);
		model.addAttribute("pageInfo", pageInfo);

		return "list";
	}

}
