<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsImgService"%>
<%@ page import="vo.GoodsImg"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.File"%>
<!-- request대신 사용하는 API - 원래것을 덮어서 사용 -->
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<!-- file을 새로 만들지 않고 rename을 이용하여 사용 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
	// 경로
	String dir = request.getServletContext().getRealPath("/theme/upload");
	// 디버깅
	System.out.println("adminUpdateGoodsImgAction.jsp dir : " + dir);
	// 파일사이즈
	int max = 10 * 1024 * 1024; 
	// request에 기능덮기 (request, 경로, 파일사이즈, 인코딩, 이름설정)
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "UTF-8", new DefaultFileRenamePolicy());
	
	// 값받기 객체에 담아서 파라미터로 넘기
	int goodsNo = Integer.parseInt(mRequest.getParameter("goodsNo"));
	// 수정할 이미지 받아오기
	// goodsNo은 그대로 사용하면 되고 imgFile에 관한 것만 받으면 됨
	String contentType = mRequest.getContentType("imgFile");
	String originFilename = mRequest.getOriginalFileName("imgFile");
	String filename = mRequest.getFilesystemName("imgFile");
		
	
	GoodsImg goodsImg = new GoodsImg();
	goodsImg.setGoodsNo(goodsNo);
	
	// 원래 이미지 삭제하기 위한 메서드 실행
	goodsImg = new GoodsImgService().getGoodsImg(goodsImg);
	
	// 이미지 먼저 삭제하기
	File f = new File(dir + "/" + goodsImg.getFilename());
	if(f.exists()){
		f.delete();
	}
	
	
	// 이미지 파일이 아닌경우 막기
	if(!(contentType.equals("image/gif") || contentType.equals("image/png") || contentType.equals("image/jpeg"))){
		// 만들어져 있다면 삭제
		f = new File(dir + "/" + filename);
		if(f.exists()){
			f.delete();
		}
		
		String errorMsg = URLEncoder.encode("이미지파일만 업로드 가능", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/theme/adminUpdateGoods.jsp?errorMsg=" + errorMsg);
		return;
	}
	
	// goodsImg 객체 재활용하여 새로 넣을 이미지에 대한 setter
	goodsImg.setGoodsNo(goodsNo);
	goodsImg.setContentType(contentType);
	goodsImg.setOriginFilename(originFilename);
	goodsImg.setFilename(filename);
	
	// 메서드실행
	boolean updateImgComplete = new GoodsImgService().modifyGoodsImg(goodsImg);
	
	// 디버깅
	if(updateImgComplete){
		System.out.println("adminUpdateGoodsImgAction.jsp img update 성공");
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminGoodsOne.jsp?goodsNo=" + goodsNo);
	} else {
		System.out.println("img update 실패");
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminGoodsOne.jsp?goodsNo=" + goodsNo + "&errorMsg=img update Fail");
	}
	
%>