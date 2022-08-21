<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.OrdersService"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="service.CartService"%>
<%@ page import="vo.Cart"%>
<%
	// 주문할 목록 가져오기
	String[] goodsNo = request.getParameterValues("goodsNo");
	
	// 디버깅
	System.out.println("cartAction.jsp String[] goodsNo : " + Arrays.toString(goodsNo));
	
	// Cart안에 있는 내용 가져오기
	// 조회하기 위한 파라미터 만들기
	Cart paramCart = new Cart();
	paramCart.setCustomerId((String)session.getAttribute("id"));
	
	// 메서드실행을 위한 객체 생성
	CartService cartService = new CartService();
	
	// 메서드 실행
	List<Map<String, Object>> cartList = cartService.getCartById(paramCart);
	
	// Cart에 담기
	List<Cart> list = new ArrayList<>();
	
	// goodsNo에 담긴 개수 만큼 cart셍성하여 list에 담기
	for(int i = 0; i < cartList.size(); i++){
		Cart cart = new Cart();
	
		cart.setGoodsNo(Integer.parseInt(goodsNo[i]));
		cart.setCustomerId((String)session.getAttribute("id"));
		cart.setCartQuantity((Integer)cartList.get(i).get("cartQuantity"));
		
		// 디버깅
		System.out.println("cartAction.jsp cart : " + cart.toString());
		
		list.add(cart);
	}
	
	// 디버깅
	System.out.println("cartAction.jsp list : " + list.toString());
	
	// 삭제일경우 리턴값
	boolean removeComplete = false;
	
	// 분기 
	// 주문하기인가 삭제인가
	if("order".equals(request.getParameter("submit"))){
		// 세션에 담기
		session.setAttribute("cartList", list);
		
		// 주문/결제 리스트로 보내기
		response.sendRedirect(request.getContextPath() + "/theme/buyList.jsp");
	} else if("remove".equals(request.getParameter("submit"))) {
		// 삭제 메서드
		removeComplete = cartService.removeCartById(list);
		
		// 디버깅
		System.out.println("cartAction.jsp removeComplete : " + removeComplete + " <-- true 성공 / false 실패");
		
		// 카트로 재요청하기
		response.sendRedirect(request.getContextPath() + "/theme/cartList.jsp");
	}
	
%>