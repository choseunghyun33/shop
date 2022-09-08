<%@page import="service.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Cart"%>
<%
	//인코딩
	request.setCharacterEncoding("UTF-8");

	// 막기
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
		return;
	} else if(session.getAttribute("id") != null && "employee".equals((String)session.getAttribute("user"))) {
		// 손님이 아닌경우 막기
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
		return;
	}
	
	// 값받아서 cart에 담기
	Cart cart = new Cart();
	cart.setGoodsNo(Integer.parseInt(request.getParameter("goodsNo")));
	cart.setCustomerId((String)session.getAttribute("id"));
	cart.setCartQuantity(Integer.parseInt(request.getParameter("cartQuantity")));

	// 디버깅	
	System.out.println("modifyCartQuantity.jsp cart : " + cart);
	
	// 카트수량 변경하기 메서드
	CartService cartService = new CartService();
	cartService.modifyCartQuantityPlus(cart);
	
	// 재요청
	response.sendRedirect(request.getContextPath() + "/theme/cartList.jsp");
%>