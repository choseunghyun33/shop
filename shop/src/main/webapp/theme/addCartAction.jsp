<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.CustomerService"%>
<%@ page import="service.GoodsService"%>
<%@ page import="java.util.Map"%>
<%@ page import="service.CartService"%>
<%@ page import="vo.Cart"%>
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

	// 뷰를 카트를 보여줄지 구매창을 보내줄지 분기를 위해 받아오는 변수
	String submit = request.getParameter("submit");
	// 디버깅
	System.out.println("addCartAction.jsp submit : " + submit);

	// 메서드 파라미터에 담을 객체 만들기
	// 장바구니 객체에 값 받아서 넣기
	Cart cart = new Cart();
	
	// cart setter
	cart.setGoodsNo(Integer.parseInt(request.getParameter("goodsNo")));
	cart.setCartQuantity(Integer.parseInt(request.getParameter("cartQuantity")));
	cart.setCustomerId((String)session.getAttribute("id"));
	
	// 디버깅
	System.out.println("addCartAction.jsp cart : " + cart.toString());
			
	
	// submit에 따라 실행할 분기
	if("buy".equals(submit)){ // buy 라면 session에 담고 구매창으로 이동
		// session에 담기
		session.setAttribute("directOrder", cart);
		
		response.sendRedirect(request.getContextPath() + "/theme/buyList.jsp");
		// 디버깅
		System.out.println("addCartAction.jsp buyList.jsp로 이동");
	} else if("addtocart".equals(submit)){ // addtocart 라면 카트로 이동
		// 카트에 담을 메서드
		CartService cartService = new CartService();
		cartService.addCart(cart);
		
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/cartList.jsp");
		// 디버깅
		System.out.println("addCartAction.jsp cartList.jsp로 이동");
	}
%>