<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.ReviewService"%>
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
	// Review 객체로 파라미터 넘길 값 만들기
	Review review = new Review();
	
	// review setter
	review.setOrderNo(Integer.parseInt(request.getParameter("orderNo")));
	review.setStar(Integer.parseInt(request.getParameter("star")));
	review.setReviewContent(request.getParameter("reviewContent"));
	
	// 디버깅
	System.out.println("addReviewAction.jsp review : " + review.toString());
	
	// 메서드 실행
	// 리턴값 boolean
	boolean addReviewComplete = new ReviewService().addReview(review);
	
	// 실행 성공 실패
	// true / false 분기
	if(addReviewComplete){ // true
		// 디버깅
		System.out.println("addReviewAction.jsp	addReview 성공");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/ordersList.jsp");
	} else { // false
		// 디버깅
		System.out.println("addReviewAction.jsp	addReview 실패");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/ordersList.jsp?errorMsg=addReview Fail");
	}
%>