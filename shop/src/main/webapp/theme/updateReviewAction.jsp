<%@page import="service.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Review"%>
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");

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
	String goodsName = request.getParameter("goodsName");
	
	// review 객체로 파라미터 사용할 것임으로 객체에 담기
	Review review = new Review();
	// review setter
	review.setOrderNo(orderNo);
	review.setReviewContent(request.getParameter("reviewContent"));
	review.setStar(Integer.parseInt(request.getParameter("star")));
	
	// 디버깅
	System.out.println("updateReviewAction.jsp review : " + review.toString());
	
	// 메서드 실행
	// 리턴값 boolean true 일 경우 성공
	boolean updateReviewComplete = new ReviewService().modifyReviewByOrderNo(review);
	
	if(updateReviewComplete) { // true 성공
		// 디버깅
		System.out.println("updateReviewAction.jsp updateReviewComplete 성공");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/reviewOne.jsp?orderNo=" + orderNo + "&goodsName=" + goodsName);
	} else { // false 실패
		// 디버깅
		System.out.println("updateReviewAction.jsp updateReviewComplete 실패");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/reviewOne.jsp?orderNo=" + orderNo + "&goodsName=" + goodsName + "&errorMsg=review Update Fail");
	}
%>