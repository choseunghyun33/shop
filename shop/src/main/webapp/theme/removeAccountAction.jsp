<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.CustomerService"%>
<%@ page import="vo.Customer"%>
<%@ page import="service.EmployeeService"%>
<%@ page import="vo.Employee"%>
<%
	// 막기
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
		return;
	}
	
	// customer 인가 employee 인가 분기 위한 값
	String user = (String)session.getAttribute("user");
	
	// 동일한 처리
	// 받을 값
	String id = (String)session.getAttribute("id");
	String pass = request.getParameter("pass");
	// 디버깅
	System.out.println("removeAccountAction.jsp id : " + id);
	System.out.println("removeAccountAction.jsp pass : " + pass);
	
	// 리턴받을 변수
	boolean removeComplete = false;
	
	// customer / employee 분기
	if(user.equals("customer")){
		// customer 객체에 setter
		Customer customer = new Customer();
		customer.setCustomerId(id);
		customer.setCustomerPass(pass);
		
		// delete 메서드 실행하기 위한 객체 생성
		CustomerService customerService = new CustomerService();
		removeComplete = customerService.removeCustomer(customer);
		
	} else if(user.equals("employee")){
		// employee 객체에 setter
		Employee employee = new Employee();
		employee.setEmployeeId(id);
		employee.setEmployeePass(pass);
		
		// delete 메서드 실행하기 위한 객체 생성
		EmployeeService employeeService = new EmployeeService();
		removeComplete = employeeService.removeEmployee(employee);
	}

	
	// 디버깅 및 재요청 (분기)
	if(removeComplete){
		System.out.println("remove 성공");
		session.invalidate(); // 세션 비우기
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp");
	} else {
		System.out.println("remove 실패");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=remove account Fail");
	}
%>