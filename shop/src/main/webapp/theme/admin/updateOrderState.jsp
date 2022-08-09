<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.OrdersService"%>
<%
	// 디버깅
	request.setCharacterEncoding("UTF-8");
	// 막기
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
		return;
	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
		// 관리자가 아닌경우 막기
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
	}

	// 값받기
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String orderState = request.getParameter("orderState");
	String path = request.getParameter("path");
	// 디버깅
	System.out.println("updateOrderState.jsp orderNo" + orderNo);
	System.out.println("updateOrderState.jsp orderState" + orderState);
	System.out.println("updateOrderState.jsp orderState" + path);
	
	// 메서드 실행 할 객체 생성
	OrdersService ordersService = new OrdersService();
	boolean updateComplete = ordersService.modifyOrderStateByOrderNo(orderState, orderNo);
	
	// 분기 (재요청) - 들어온 페이지로 보내주기
	if(updateComplete){
		System.out.println("updateOrderState.jsp update 성공");
		response.sendRedirect(request.getContextPath() + "/theme/admin/" + path);
	} else {
		System.out.println("updateOrderState.jsp update 실패");
		response.sendRedirect(request.getContextPath() + "/theme/admin/" + path + "?errorMsg=soldOut update Fail");
	}
%>