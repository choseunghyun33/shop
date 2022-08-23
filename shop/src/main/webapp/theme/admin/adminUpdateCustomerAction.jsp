<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 막기
	if(session.getAttribute("id") == null){
			response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
			return;
		} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
			// 관리자가 아닌경우 막기
			response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
		}
	
	// 값받기
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	
	Customer customer = new Customer();
	
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	
	// 디버깅
	System.out.println("adminUpdateCustomerAction.jsp customerId" + customerId);
	
	// 객체 생성
	CustomerService customerService = new CustomerService();
	
	// 메서드 실행 true 성공
	boolean updateComplete = customerService.modifyCustomerByAdmin(customer);
	
	if(updateComplete){
		System.out.println("adminUpdateCustomerAction.jsp update 성공");
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminCustomerList.jsp");
	} else {
		System.out.println("adminUpdateCustomerAction.jsp update 실패");
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminCustomerList.jsp?errorMsg=Customer update by Admin Fail");
	}
%>