<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="emp_add_input" placeholder="姓名"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									id="email_add_input" placeholder="xxx@qq.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="inlineRadio1" value="M" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="inlineRadio2" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-4">
								<!-- 部门提交id即可 -->
								<select class="form-control" name="deptId"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empname_update_p" name="empName"></p>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									id="email_update_input" placeholder="xxx@qq.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" value="M" checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-4">
								<!-- 部门提交id即可 -->
								<select class="form-control" name="deptId"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_udpate_btn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					新增
				</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
					删除
				</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"/></th>
							<th>id</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门名称</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6" id="page_info"></div>
			<!-- 分页条 -->
			<div class="col-md-6" id="page_nav"></div>
		</div>
	</div>

	<script type="text/javascript">
		//全局变量当前页码
		var currentPage;
		//1.页面加载完成后，直接去发送一个AJAX请求，要到分页数据
		$(function() {
			//默认开始跳转到第一页
			to_page(1);
		});

		//将跳转页面抽取成一个方法，重复使用
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//设置全局变量currentPage
					currentPage = result.extend.pageInfo.pageNum;
					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析显示分页信息
					build_page_info(result);
					//3.解析并显示分页条
					build_page_nav(result);
				}
			});
		}

		//解析显示员工表
		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == "M" ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var departMentTd = $("<td></td>").append(
						item.departMent.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm edit_btn").append(
						$("<span>编辑</span>").addClass(
								"glyphicon glyphicon-pencil")).attr("emp-id", item.empId).attr("pagenum", result.extend.pageInfo.pageNum);
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn").append(
						$("<span>删除</span>").addClass(
								"glyphicon glyphicon-trash")).attr("emp-id", item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(
						delBtn);
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(departMentTd).append(
						btnTd).appendTo("#emps_table tbody");
			});
		}

		//解析显示分页信息
		function build_page_info(result) {
			$("#page_info").empty();
			$("#page_info").append(
					"当前" + result.extend.pageInfo.pageNum + "页，总"
							+ result.extend.pageInfo.pages + "页，总"
							+ result.extend.pageInfo.total + "条记录");
		}

		//解析显示分页条
		function build_page_nav(result) {
			$("#page_nav").empty();

			var pageUl = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href", "#"));
			if (!result.extend.pageInfo.hasPreviousPage) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href", "#"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (!result.extend.pageInfo.hasNextPage) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}

			pageUl.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", "#"));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				pageUl.append(numLi);
			});
			pageUl.append(nextPageLi).append(lastPageLi);
			var pageNav = $("<nav></nav>").append(pageUl).appendTo("#page_nav");
		}

		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function() {
			//1.弹出之前，应该清空表单里面的信息
			//jquery中没有reset()方法，这个方法是DOM对象所特有的
			form_reset("#empAddModal form");
			//$("#empAddModal form")[0].reset();
			//发送AJAX请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModal select");
			//弹出模态框
			$("#empAddModal").modal({
				backdrop : "static"
			});
		});

		//重置所有表单样式
		function form_reset(ele) {
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}

		//查出所有的部门信息并显示在下拉列表中
		function getDepts(ele) {
			//将之前的添加的option全部清空
			$(ele).empty();
			//假如改写过后出现404，可能是因为项目没有及时更新，应该重启tomcat
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					$.each(result.extend.depts, function() {
						var option = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						$(ele).append(option);
					});

				}
			});
		}

		//校验表单数据
		function validate_add_form() {
			var empName = $("#emp_add_input").val();
			var regName = /(^[a-zA-Z0-9_]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;

			/*if (!regName.test(empName)) {
				//alert("用户名可以是2-5位中文或者6-16位英文、数字和下划线的组合");
				$("#emp_add_input").parent().removeClass("has-success");
				$("#emp_add_input").parent().addClass("has-error");
				$("#empname_err_msg").text("用户名可以是2-5位中文或者6-16位英文、数字和下划线的组合");
				show_validate_msg("#emp_add_input", 200,
						"用户名可以是2-5位中文或者6-16位英文、数字和下划线的组合");
				return false;
			} else {
				$("#emp_add_input").parent().removeClass("has-error");
				$("#emp_add_input").parent().addClass("has-success");
				$("#empname_err_msg").text("");
				show_validate_msg("#emp_add_input", 100, "");
			}*/

			//2.校验邮箱
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");
				/*$("#email_add_input").parent().removeClass("has-success");
				$("#email_add_input").parent().addClass("has-error");
				$("#email_err_msg").text("邮箱格式不正确");*/
				show_validate_msg("#email_add_input", 200, "邮箱格式不正确");
				return false;
			} else {
				/*$("#email_add_input").parent().removeClass("has-error");
				$("#email_add_input").parent().addClass("has-success");
				$("#email_err_msg").text("");*/
				show_validate_msg("#email_add_input", 100, "邮箱可以使用");
			}

			return true;
		}

		//显示校验结果的提示信息
		function show_validate_msg(ele, status_code, msg) {
			//100代表成功，200代表失败
			//清空上次添加的class
			$(ele).parent().removeClass("has-success has-error");
			//清空上次设置的消息提示
			$(ele).next("span").text("");
			if (100 == status_code) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
			//为保存按钮加上自定义属性用于判读是否可提交,必须将#去掉，否则会报错
			$("#emp_save_btn")
					.attr(ele.replace("#", "") + "_data", status_code);
		}

		$("#emp_save_btn")
				.click(
						function() {
							//先对表单数据进行校验，合法才发送AJAX请求
							if (!validate_add_form()) {
								return;
							}
							//取出保存按钮的自定义属性值并进行判断通过后才可以发送请求
							var empName_flag = $("#emp_save_btn").attr(
									"emp_add_input_data");
							var email_flag = $("#emp_save_btn").attr(
									"email_add_input_data");
							if (empName_flag != 100 || email_flag != 100) {
								return;
							}
							//1.模态框中填写的表单数据提交给服务器进行保存
							//2.发送AJAX请求保存员工
							$
									.ajax({
										url : "${APP_PATH}/emp",
										type : "POST",
										data : $("#empAddModal form")
												.serialize(),
										success : function(result) {
											if (result.code == 100) {
												//alert(result.msg);
												//员工保存成功
												//1.关闭模态框
												$("#empAddModal").modal('hide');
												//2.来到最后一页，显示刚才保存的数据
												to_page(result.extend.pages);
											} else {
												if (undefined != result.extend.errorMap.empName) {
													show_validate_msg(
															"#emp_add_input",
															result.code,
															result.extend.errorMap.empName);
												}
												if (undefined != result.extend.errorMap.email) {
													show_validate_msg(
															"#email_add_input",
															result.code,
															result.extend.errorMap.email);
												}
											}
										}
									});
						});

		//检查用户名是否重复
		$("#emp_add_input").change(
				function() {
					var empName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkuser",
						data : "empName=" + empName,
						type : "GET",
						success : function(result) {
							/*if (result.code == 100) {
								show_validate_msg("#emp_add_input", "success",
										"用户名可用");
							} else {
								show_validate_msg("#emp_add_input", "error",
										"用户名重复");
							}*/
							show_validate_msg("#emp_add_input", result.code,
									result.extend.vali_msg);
						}
					});
				});
		
		/*
		AJAX是在页面加载完成后(包括执行完js)才发送的请求
		1.我们是按钮创建之前就绑定了click，所以绑定不上
		方法：1.可以在创建按钮的时候绑定（但会使那个函数变得臃肿）
			 2.绑定方法.live(function)
			可是第二种方法在新版的jQuery中取消了，所有使用on进行替代
		*/
		$(document).on("click", ".edit_btn", function(){
			//清空之前编辑留下的class
			form_reset("#empUpdateModal form");
			//查询部门信息
			getDepts("#empUpdateModal select");
			//查出员工信息
			getEmpInfo($(this).attr("emp-id"));
			//给更新按钮添加上员工id信息，并加上当前页码数
			$("#emp_udpate_btn").attr("emp-id", $(this).attr("emp-id"));
			//弹出模态框
			$("#empUpdateModal").modal({
				backdrop : "static"
			});
		});
		
		//查询员工信息
		function getEmpInfo(id) {
			$.ajax({
				url : "${APP_PATH}/emp/"+id,
				type : "GET",
				success : function(result) {
					var empData = result.extend.employee;
					$("#empname_update_p").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name='gender']").val([empData.gender]);
					$("#empUpdateModal select").val([empData.deptId]);
				}
			});
		}
		
		//给更新按钮绑定事件
		$("#emp_udpate_btn").click(function(){
			//发送AJAX请求之前应该检查Email格式是否正确
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_update_input", 200, "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_update_input", 100, "邮箱可以使用");
			}
			//员工id可以通过按钮中的属性获取
			var empId = $(this).attr("emp-id");
			//发送PUT的AJAX请求，有两种方式，本次使用第二种
			$.ajax({
				url : "${APP_PATH}/emp/"+empId,
				data : $("#empUpdateModal form").serialize(),
				type : "PUT",
				success : function(result) {
					//关闭模态框
					$("#empUpdateModal").modal('hide');
					//再回到当前页面，更新一下数据
					to_page($(".edit_btn").attr("pagenum"));
				}
			});
		});
		
		//给所有的删除按钮绑定上事件
		$(document).on("click", ".delete_btn", function(){
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("emp-id");
			if(confirm("确认删除【"+empName+"】吗")) {
				$.ajax({
					url : "${APP_PATH}/emp/"+empId,
					type : "DELETE",
					success : function(result) {
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
		
		//完成全选/全不选
		$("#check_all").click(function(){
			//attr获取checked是undefined;
			//我们这些dom原生的属性用prop，自定义属性用attr获取属性值
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		
		//给check_item绑定事件
		$(document).on("click", ".check_item", function(){
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked", flag);
		});
		
		//批量删除员工
		$("#emp_delete_all_btn").click(function(){
			var empNames = "";
			var del_ids = "";
			$.each($(".check_item:checked"), function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				del_ids += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除多余的逗号
			empNames = empNames.substring(0, empNames.length-1);
			//去除多余的-
			del_ids = del_ids.substring(0, del_ids.length-1);
			if(confirm("确认删除【"+empNames+"】吗")) {
				$.ajax({
					url : "${APP_PATH}/emp/"+del_ids,
					type : "DELETE",
					success : function(result) {
						alert(result.msg);
						to_page(currentPage);
						//将check_all的状态改为false
						$("#check_all").prop("checked", false);
					}
				});
			}
		});
	</script>
</body>
</html>