<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.CustomerService"%>
<%
	// 막기
	if(session.getAttribute("id") == null){
  		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
  		return;
  	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
  		// 관리자가 아닌경우 막기
  		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
		return;
  	}

	// 값받기
	String customerId = request.getParameter("customerId");
	// 디버깅
	System.out.println("adminDeleteCustomer.jsp customerId" + customerId);
	
	// 객체 생성
	CustomerService customerService = new CustomerService();
	
	// 메서드 실행 true 성공
	boolean deleteComplete = customerService.removeCustomerByAdmin(customerId);
	
	if(deleteComplete){
		System.out.println("adminDeleteCustomer.jsp delete 성공");
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminCustomerList.jsp");
	} else {
		System.out.println("adminDeleteCustomer.jsp delete 실패");
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminCustomerList.jsp?errorMsg=Customer delete by Admin Fail");
	}
%>