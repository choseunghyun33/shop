<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="repository.*" %>
<%@ page import="service.EmployeeService"%>
<%@ page import="vo.*" %>
<%
	// 값받기
	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employeePass");
	
	// 디버깅
	System.out.println("employeeLoginAction.jsp employeeId : " + employeeId);
	System.out.println("employeeLoginAction.jsp employeePass : " + employeePass);
	
	// 막기
	if(session.getAttribute("id") != null){
		response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=wrong path");
		return;
	}
	
	if(employeeId == null || employeePass == null || employeeId.length() < 4 || employeePass.length() < 4){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=wrong ID or PW");
		return;
	}
	
	// 객체생성 후 setter
	Employee employee = new Employee();
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePass);
	
	// 메서드 실행을 위한 객체생성
	EmployeeService employeeService = new EmployeeService();
	// 메서드 리턴받을 객체생성 후 setter
	Employee loginEmployee = new Employee();
	// 로그인메서드에서 리턴한 객체를 담기
	loginEmployee = employeeService.getEmployeeByIdAndPw(employee);
	
	
	// 디버깅 및 재요청
	if(loginEmployee == null){ // 로그인 실패
		System.out.println("login 실패");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=login Fail");
	} else { // 로그인 성공
		// 세션에 setter
		session.setAttribute("user", "employee");
		session.setAttribute("id", loginEmployee.getEmployeeId());
		session.setAttribute("name", loginEmployee.getEmployeeName());
		
		System.out.println("employee login 성공");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%>