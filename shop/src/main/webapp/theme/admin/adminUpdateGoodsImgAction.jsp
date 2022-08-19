<%@ page import="vo.GoodsImg"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- request대신 사용하는 API - 원래것을 덮어서 사용 -->
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<!-- file을 새로 만들지 않고 rename을 이용하여 사용 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
	// 경로
	String dir = request.getServletContext().getRealPath("upload");
	// 디버깅
	System.out.println("adminUpdateGoodsImgAction.jsp dir : " + dir);
	// 파일사이즈
	int max = 10 * 1024 * 1024; 
	// request에 기능덮기 (request, 경로, 파일사이즈, 인코딩, 이름설정)
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "UTF-8", new DefaultFileRenamePolicy());
	
	// 값받기
	GoodsImg goodsImg = new GoodsImg();
	
	goodsImg.setGoodsNo(Integer.parseInt(mRequest.getParameter("goodsNo")));
	
	
%>