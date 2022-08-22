<%@page import="service.NoticeService"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 막기
	if(session.getAttribute("id") == null){
			response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
			return;
		} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
			// 관리자가 아닌경우 막기
			response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
		}
	
	// 값 받기
	// 메서드 파라미터로 넘길 객체 생성
	Notice notice = new Notice();
	// notice setter
	notice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
	
	// 메서드 실행 (리턴값 true - 성공)
	boolean deleteNoticeComplete = new NoticeService().removeNoticeByNoticeNo(notice);
	
	// 분기
	// 성공 실패로 분기를 나눈다.
	if(deleteNoticeComplete){ // true - 성공
		// 디버깅
		System.out.println("adminUpdateNoticeAction.jsp deleteNotice 성공");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminNoticeList.jsp");
	} else { // false - 실패
		// 디버깅
		System.out.println("adminUpdateNoticeAction.jsp deleteNotice 실패");
		// 재요청
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminNoticeList.jsp&errorMsg=notice Delete Fail");
	}
%>