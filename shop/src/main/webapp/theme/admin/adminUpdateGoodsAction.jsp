<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%@ page import="vo.Goods"%>
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
   	}
	
	// 값받기
	Goods goods = new Goods();
	goods.setGoodsNo(Integer.parseInt(request.getParameter("goodsNo")));
	goods.setGoodsName(request.getParameter("goodsName"));
	goods.setGoodsPrice(Integer.parseInt(request.getParameter("goodsPrice")));
	goods.setSoldOut(request.getParameter("soldOut"));
	
	// 디버깅
	System.out.println("adminUpdateGoodsAction.jsp goods : " + goods.toString());
	
	// 메서드 호출
	GoodsService goodsService = new GoodsService();
	boolean updateGoodsComplete = goodsService.modifyGoods(goods);
	
	if(updateGoodsComplete){
		System.out.println("adminUpdateGoodsAction.jsp update 성공");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminUpdateGoods.jsp?goodsNo=" + goods.getGoodsNo());
	} else {
		System.out.println("adminUpdateGoodsAction.jsp update 실패");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminUpdateGoods.jsp?goodsNo=" + goods.getGoodsNo() + "&errorMsg=update Fail");
	}
%>