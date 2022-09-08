<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.OrdersService"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="vo.Orders"%>
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 막기
	if(session.getAttribute("id") == null){
   		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
   		return;
   	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
   		// 관리자가 아닌경우 막기
   		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
		return;
   	}
	
	// 값 받기
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String orderState = request.getParameter("orderState");
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
	String orderAddr = request.getParameter("orderAddr");
	
	// 값 담을 객체 초기화
	Orders orders = new Orders();
	orders.setOrderNo(orderNo);
	orders.setOrderState(orderState);
	orders.setOrderPrice(orderPrice);
	orders.setOrderQuantity(orderQuantity);
	orders.setOrderAddr(orderAddr);
	
	// 디버깅
	System.out.println("adminUpdateOrdersAction.jsp orders : " + orders.toString());
	
	// 메서드 실행 위한 객체 초기화
	OrdersService ordersService = new OrdersService();
	boolean updateComplete = ordersService.modifyOrdersByOrders(orders);
	
	if(updateComplete){ // 성공
		System.out.println("adminUpdateOrdersAction.jsp update 성공");
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminOrdersListByorderNo.jsp?orderNo=" + orderNo);
	} else {
		System.out.println("adminUpdateOrdersAction.jsp update 실패");
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminOrdersListByorderNo.jsp?orderNo=" + orderNo + "&errorMsg=Order update Fail");
	}
%>