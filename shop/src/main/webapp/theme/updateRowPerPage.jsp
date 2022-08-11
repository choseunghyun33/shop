<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 값받기
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));

	// 재요청
	response.sendRedirect(request.getContextPath() + "/theme/customerGoodsList.jsp?rowPerPage=" + rowPerPage);
%>