<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.OrdersService"%>
<%@ page import="vo.Cart"%>
<%@ page import="vo.Orders"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.List"%>
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");

	// 막기
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
		return;
	} else if(session.getAttribute("id") != null && "employee".equals((String)session.getAttribute("user"))) {
		// 손님이 아닌경우 막기
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
	}
	
	// test	
	String[] orderPrice = request.getParameterValues("orderPrice");
	System.out.println(Arrays.toString(orderPrice));
	
	// session 안에 cartList 가져오기
	List<Cart> cartList = (List<Cart>)session.getAttribute("cartList");
	// 디버깅
	System.out.println("buyAction.jsp cartList" + cartList.toString());
	
	
	// 리턴값 : boolean
	List<Object> addOrdersComplete = new ArrayList<>();
	
	// order 객체에 담기
	for(int i = 0; i < orderPrice.length; i++){
		Orders orders = new Orders();
		
		// orders setter
		orders.setGoodsNo(cartList.get(i).getGoodsNo());
		orders.setCustomerId(cartList.get(i).getCustomerId());
		orders.setOrderQuantity(cartList.get(i).getCartQuantity());
		orders.setOrderPrice(Integer.parseInt(orderPrice[i]));
		orders.setOrderAddr(request.getParameter("orderAddr") + " " + request.getParameter("orderDetailAddr"));
		
		// 메서드 실행할 클래스 new
		OrdersService ordersService = new OrdersService();
		
		// 주문하는 메서드 실행
		// 리턴값 : boolean
		addOrdersComplete.add(ordersService.addOrders(orders));
	}
	
	for(Object o : addOrdersComplete){
		System.out.println("buyAction.jsp addOrdersComplete : " + o);
	}
	// 재요청
	response.sendRedirect(request.getContextPath() + "/theme/ordersList.jsp");
%>