<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String ckId = request.getParameter("ckId");
	
	// service -> false
	response.sendRedirect(request.getContextPath() + "/addCustomer.jsp?errorMsg=Duplicate ID");
	// service -> true
	response.sendRedirect(request.getContextPath() + "/addCustomer.jsp?ckId=" + ckId);
%>