<%@page import="service.OrdersService"%>
<%@page import="vo.Cart"%>
<%@page import="vo.Orders"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// session 안에 있는 카트를 가져오기
	Cart cart = (Cart)session.getAttribute("cart");
	
	// order 객체에 담기
	Orders orders = new Orders();
	
	// orders setter
	orders.setGoodsNo(cart.getGoodsNo());
	orders.setCustomerId((String)session.getAttribute("id"));
	orders.setOrderQuantity(cart.getCartQuantity());
	orders.setOrderPrice(Integer.parseInt(request.getParameter("orderPrice")));
	orders.setOrderAddr(request.getParameter("orderAddr") + " " + request.getParameter("orderDetailAddr"));
	
	// 메서드 실행할 클래스 new
	OrdersService ordersService = new OrdersService();
	
	// 주문하는 메서드 실행
	// 리턴값 : boolean
	boolean addOrdersComplete = ordersService.addOrders(orders);
	
	// true 라면 성공
	if(addOrdersComplete){
		System.out.println("buyAction.jsp addOrders 성공");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/ordersList.jsp");
	} else {
		System.out.println("buyAction.jsp addOrders 실패");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/ordersList.jsp?errorMsg=orders Fail");
	}
	
%>