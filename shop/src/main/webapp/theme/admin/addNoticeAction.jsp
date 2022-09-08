<%@page import="service.NoticeService"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		return;
	}

	// 값 받기
	// 객체에 넣어서 파라미터로 사용하기
	Notice notice = new Notice();
	notice.setNoticeTitle(request.getParameter("noticeTitle"));
	notice.setNoticeContent(request.getParameter("noticeContent"));
	
	// 디버깅
	System.out.println("addNoticeAction.jsp notice : " + notice);
	
	// 메서드 사용하기
	boolean addNoitceComplete = new NoticeService().addNotice(notice);
	
	// 성공 실패 분기
	if(addNoitceComplete){ // 성공
		// 디버깅
		System.out.println("addNoticeAction 성공");
		// 재요청	
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminNoticeList.jsp");
	} else { // 실패
		// 디버깅
		System.out.println("addNoticeAction 실패");
		// 재요청	
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminNoticeList.jsp?errorMsg=add Notice Fail");
	}
%>