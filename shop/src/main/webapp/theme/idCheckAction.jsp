<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.SignService"%>
<%
	// 막기
	if(session.getAttribute("id") != null){
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=wrong Path");
		return;
	}

	// 받을 값
	String user = request.getParameter("user");
	String ckId = request.getParameter("ckId");
	// 디버깅
	System.out.println("idCheckAcion.jsp user : " + user);
	System.out.println("idCheckAcion.jsp ckId : " + ckId);
	
	// 중복검사
	SignService signService = new SignService();
	boolean ckIdComplete = signService.idCheck(ckId);
	
	// 중복인지 아닌지 분기 // user (customer/employee) 분기
	if(ckIdComplete && user.equals("customer")){ 
		// true 이고 customer 라면
		response.sendRedirect(request.getContextPath() + "/theme/sign-up.jsp?customerCkId=" + ckId);
	} else if(ckIdComplete && user.equals("employee")){
		// true 이고 employee 라면
		response.sendRedirect(request.getContextPath() + "/theme/sign-up.jsp?employeeCkId=" + ckId);
	} else {
		// false 라면
		response.sendRedirect(request.getContextPath() + "/theme/sign-up.jsp?errorMsg=Duplicate ID");
	}
	
%>