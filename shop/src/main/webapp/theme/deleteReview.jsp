<%@page import="service.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 막기
	if(session.getAttribute("id") == null){
   		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
   		return;
   	} else if(session.getAttribute("id") != null && "employee".equals((String)session.getAttribute("user"))) {
   		// 사용자가 아닌경우 막기
   		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
		return;
   	}

	// 값받기
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	// 디버깅
	System.out.println("deleteReview.jsp orderNo : " + orderNo);
	
	// 삭제 메서드 실행
	boolean deleteReviewComplete = new ReviewService().removeReviewByOrderNo(orderNo);
	
	// true 성공 false 실패
	if(deleteReviewComplete) { // true 성공
		// 디버깅
		System.out.println("deleteReview.jsp deleteReviewComplete 성공");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/ordersList.jsp");
	} else { // false 실패
		// 디버깅
		System.out.println("deleteReview.jsp deleteReviewComplete 실패");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/ordersList.jsp&errorMsg=review Delete Fail");
	}
%>