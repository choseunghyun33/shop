<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%
	// 막기
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
		return;
	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
		// 관리자가 아닌경우 막기
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
		return;
	}

	// 값받기
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String soldOut = request.getParameter("soldOut");
	// 디버깅
	System.out.println("updateSoldOut.jsp goodsNo" + goodsNo);
	System.out.println("updateSoldOut.jsp soldOut" + soldOut);
	
	// 메서드 실행 할 객체 생성
	GoodsService goodsService = new GoodsService();
	boolean updateComplete = goodsService.modifySoldOutByKey(goodsNo, soldOut);
	
	// 분기 (재요청)
	if(updateComplete){
		System.out.println("updateSoldOut.jsp update 성공");
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminGoodsList.jsp");
	} else {
		System.out.println("updateSoldOut.jsp update 실패");
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminGoodsList.jsp?errorMsg=soldOut update Fail");
	}
%>