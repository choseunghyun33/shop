<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 막기
	if(session.getAttribute("id") != null){
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=wrong Path");
		return;
	}
	
	// 값받기 
	// 분기 - customer/employee 공통 - name, id, pass
	// customer 개별 - customerAddress, customerTelephone
	String user = request.getParameter("user");
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	// 디버깅 
	System.out.println("sign-upAcion.jsp user : " + user);
	System.out.println("sign-upAcion.jsp name : " + name);
	System.out.println("sign-upAcion.jsp id : " + id);
	System.out.println("sign-upAcion.jsp pass : " + pass);
	
	// 메서드 리턴값 담을 변수
	boolean insertComplete = false;
	
	// user (customer/employee) 분기
	if(user.equals("customer")){
		String customerAddress = request.getParameter("customerAddress");
		String customerTelephone = request.getParameter("customerTelephone");
		
		// customer객체생성하기
		Customer customer = new Customer();
		// customer setter
		customer.setCustomerName(name);
		customer.setCustomerId(id);
		customer.setCustomerPass(pass);
		customer.setCustomerAddress(customerAddress);
		customer.setCustomerTelephone(customerTelephone);
		// 디버깅
		System.out.println(customer.toString());
		
		// 메서드실행할 customerService 변수생성
		CustomerService customerService = new CustomerService();
		insertComplete = customerService.addCustomer(customer);
	} else if(user.equals("employee")) {
		// employee객체생성하기
		Employee employee = new Employee();
		// employee setter
		employee.setEmployeeName(name);
		employee.setEmployeeId(id);
		employee.setEmployeePass(pass);
		// 디버깅
		System.out.println(employee.toString());
		
		// 메서드실행할 employeeService 변수생성
		EmployeeService employeeService = new EmployeeService();
		insertComplete = employeeService.addEmployee(employee);
	}
	
	
	// 디버깅 및 재요청
	if(insertComplete){
		System.out.println("insert 성공");
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp");
	} else {
		System.out.println("insert 실패");
		response.sendRedirect(request.getContextPath() + "/theme/sign-up.jsp?errorMsg=sign-up Fail");
	}
%>