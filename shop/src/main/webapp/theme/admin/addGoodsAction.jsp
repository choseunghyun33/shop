<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="service.GoodsService"%>
<%@ page import="vo.Goods"%>
<%@ page import="vo.GoodsImg"%>
<%@ page import="java.io.File"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 막기
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
		return;
	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
		// 관리자가 아닌경우 막기
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
	}


	// cos 라이브러리 사용하기
	String dir = request.getServletContext().getRealPath("/theme/upload");
	// 디버깅
	System.out.println("addGoodsAction.jsp dir : " + dir);
	
	// 파일사이즈 (용량)
	int max = 10 * 1024 * 1024; // 1024byte -> 1kbyte, 1024kbyte -> 1mbyte
	
	// 원래 request에 래핑 (request, 경로, 파일사이즈, 인코딩, 이름재설정)
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "UTF-8", new DefaultFileRenamePolicy());
	
	// 입력한 값 받기
	String goodsName = mRequest.getParameter("goodsName");
	int goodsPrice = Integer.parseInt(mRequest.getParameter("goodsPrice"));
	String soldOut = mRequest.getParameter("soldOut");
	
	// 파일 값 받기
	String contentType = mRequest.getContentType("imgFile");
	String originFilename = mRequest.getOriginalFileName("imgFile");
	String filename = mRequest.getFilesystemName("imgFile");
	
	// 디버깅	
	System.out.println("addGoodsAction.jsp goodsName : " + goodsName);
	System.out.println("addGoodsAction.jsp goodsPrice : " + goodsPrice);
	System.out.println("addGoodsAction.jsp soldOut : " + soldOut);
	System.out.println("addGoodsAction.jsp contentType : " + contentType);
	System.out.println("addGoodsAction.jsp originFilename : " + originFilename);
	System.out.println("addGoodsAction.jsp filename : " + filename);
	
	// 객체에 담기
	Goods goods = new Goods();
	// goods setter
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setSoldOut(soldOut);
	// 디버깅
	System.out.println("addGoodsAction.jsp goods : " + goods.toString());
	
	
	// 이미지 파일 객체에 담기
	GoodsImg goodsImg = new GoodsImg();
	// goodsImg setter
	goodsImg.setContentType(contentType);
	goodsImg.setOriginFilename(originFilename);
	goodsImg.setFilename(filename);
	// 디버깅
	System.out.println("addGoodsAction.jsp goodsImg : " + goodsImg.toString());
	
	
	// 메서드실행
	GoodsService goodsService = new GoodsService();
	goodsService.addGoods(goods, goodsImg);
	
	
	
	// 이미지 파일이 아닐 경우 막기
	if(!(contentType.equals("image/gif") || contentType.equals("image/png") || contentType.equals("image/jpeg"))){
		// 이미 업로드된 파일을 삭제
		File f = new File(dir + "/" + filename);
		if(f.exists()){ // 파일이 존재하면 삭제
			f.delete();
		}
		
		// 에러메세지
		String errorMsg = URLEncoder.encode("이미지파일만 업로드가능합니다", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/theme/admin/adminGoodsForm.jsp?errorMsg=" + errorMsg);
		return;
	}
	
	// 재요청
	response.sendRedirect(request.getContextPath() + "/theme/admin/adminGoodsList.jsp");
%>