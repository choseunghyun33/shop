<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.EmployeeService"%>
<%
	// 막기
	if(session.getAttribute("id") == null){
   		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
   		return;
   	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
   		// 관리자가 아닌경우 막기
   		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
   	}

	// 받을값
	String employeeId = request.getParameter("employeeId");
	String active = request.getParameter("active");
	// 디버깅
	System.out.println("updateActive.jsp employeeId : " + employeeId);
	System.out.println("updateActive.jsp active : " + active);
	
	// 메서드 실행할 객체생성
	EmployeeService employeeService = new EmployeeService();
	boolean activeUpdate = employeeService.modifyActiveById(employeeId, active);
	
	// 분기
	if(activeUpdate){ // 성공
		System.out.println("updateActive.jsp update 성공");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminEmployeeList.jsp");
	} else { // 실패
		System.out.println("updateActive.jsp update 실패");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminEmployeeList.jsp?errorMsg=active update Fail");
	}
%>	