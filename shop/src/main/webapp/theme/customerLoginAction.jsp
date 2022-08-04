<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="repository.*" %>
<%@ page import="vo.*" %>
<%@ page import="service.CustomerService"%>
<%
	// 값받기
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	
	// 디버깅
	System.out.println("customerLoginAction.jsp coutomerId : " + customerId);
	System.out.println("customerLoginAction.jsp customerPass : " + customerPass);
	
	// 막기
	if(session.getAttribute("id") != null){
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=wrong path");
		return;
	}
	
	if(customerId == null || customerPass == null || customerId.length() < 4 || customerPass.length() < 4){
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=wrong ID or PW");
		return;
	}
	
	// 객체생성 후 setter
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	
	// 메서드 실행을 위한 객체생성
	CustomerService customerService = new CustomerService();
	// 메서드 리턴받을 객체생성 후 setter
	Customer loginCustomer = new Customer();
	// 로그인메서드에서 리턴한 객체를 담기
	loginCustomer = customerService.getCustomerByIdAndPw(customer);
	
	
	// 디버깅 및 재요청
	if(loginCustomer == null){ // 로그인 실패
		System.out.println("login 실패");
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=login Fail");
	} else { // 로그인 성공
		// 세션에 setter
		session.setAttribute("user", "customer");
		session.setAttribute("id", loginCustomer.getCustomerId());
		session.setAttribute("name", loginCustomer.getCustomerName());
		
		System.out.println("customer login 성공");
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp");
	}
%>