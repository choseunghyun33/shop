<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Notice"%>
<%@ page import="java.util.List"%>
<%@ page import="service.NoticeService"%>
<%@ include file="adminHeader.jsp"%>
	<%
		// 유효성 검정 코드
	   	if(session.getAttribute("id") == null){
	   		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
	   		return;
	   	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
	   		// 관리자가 아닌경우 막기
	   		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
	   	}
	
		// 페이징
		int currentPage = 1; // 현재페이지
		final int ROW_PER_PAGE = 10; // 묶음

		if(request.getParameter("currentPage") != null){
			// 받아오는 페이지가 있다면 현재페이지변수에 담기
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 숫자페이징
		int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1; // 시작페이지값 ex) ROW_PER_PAGE 가 10 일경우 1, 11, 21, 31
		int endPage = startPage + ROW_PER_PAGE - 1; // 끝페이지값 ex) ROW_PER_PAGE 가 10 일경우 10, 20, 30, 40
		int lastPage = new NoticeService().lastPage(ROW_PER_PAGE);
		

		// endPage 는 lastPage보다 크면 안된다
		endPage = Math.min(endPage, lastPage); // 두 값의 최소값이 endPage가 된다
				
		// list 가져오기 메서드
		List<Notice> list = new NoticeService().getNoticeListByPage(ROW_PER_PAGE, currentPage);
	%>
    <!-- Modal -->
    <div class="modal fade bg-white" id="templatemo_search" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="w-100 pt-1 mb-5 text-right">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" method="get" class="modal-content modal-body border-0 p-0">
                <div class="input-group mb-2">
                    <input type="text" class="form-control" id="inputModalSearch" name="q" placeholder="Search ...">
                    <button type="submit" class="input-group-text bg-success text-light">
                        <i class="fa fa-fw fa-search text-white"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>


    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-12 m-auto">
                <h1 class="h1">Notice</h1>
                	  <hr>
                	<!-- <div>
	                	<form action="" method="get" class="modal-content modal-body border-0 p-0">
			                <div class="input-group mb-2">
			                    <input type="text" class="form-control" id="inputModalSearch" name="q" placeholder="Search ...">
			                    <button type="submit" class="input-group-text bg-success text-light">
			                        <i class="fa fa-fw fa-search text-white"></i>
			                    </button>
			                </div>
			            </form>
                	</div> -->
                	<a href="<%=request.getContextPath()%>/theme/admin/adminNoticeForm.jsp" class="btn btn-dark">글쓰기</a>
	            	<table class="table">
	            		<thead>
		            		<tr>
		            			<th>공지번호</th>
		            			<th>공지제목</th>
		            			<th>수정일</th>
		            			<th>생성일</th>
		            			<th>수정</th>
		            			<th>삭제</th>
		            		</tr>
	            		</thead>
	            		<tbody>
	            		<%
	            			for(Notice n : list) {
	            		%>
			            		<tr>
			            			<td><%=n.getNoticeNo()%></td>
			            			<td>
			            				<a href="<%=request.getContextPath()%>/theme/admin/adminNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>">
			            					<%=n.getNoticeTitle()%>
			            				</a>
			            			</td>
			            			<td><%=n.getCreateDate()%></td>
			            			<td><%=n.getUpdateDate()%></td>
			            			<td>
			            				<a href="<%=request.getContextPath()%>/theme/admin/adminUpdateNotice.jsp?noticeNo=<%=n.getNoticeNo()%>" class="btn btn-dark">수정</a>
			            			</td>
			            			<td>
			            				<a href="<%=request.getContextPath()%>/theme/admin/adminDeleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>" class="btn">삭제</a>
			            			</td>
			            		</tr>
	            		<%
	            			}
	            		%>
	            		</tbody>
	            	</table>
	            	<!-- 페이징 -->
	            	<div class="row">
                    <ul class="pagination pagination-lg justify-content-center">
	            	<%
	            		if(currentPage > 1){
	            	%>
		            		 <li class="page-item">
	                            <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminNoticeList.jsp?currentPage=<%=currentPage-1%>">pre</a>
	                         </li>	
	            	<%
	            		}
                    	
                    	// 숫자페이징
                    	for(int i = startPage; i <= endPage; i++){
                    		if(i == currentPage){
		            %>
		            			<li class="page-item disabled">
		            				 <a class="page-link active rounded-0 mr-3 shadow-sm border-top-0 border-left-0" href="<%=request.getContextPath()%>/theme/admin/adminNoticeList.jsp?currentPage=<%=i%>"><%=i%></a>
		            			</li>
	            	<%
                    		} else {
                	%>
		            			<li class="page-item">
		            				 <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminNoticeList.jsp?currentPage=<%=i%>"><%=i%></a>
		            			</li>
	            	<%			
                    		}
                    	}
                    	
	            		if(currentPage < lastPage){
	            	%>
	                        <li class="page-item">
	                            <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminNoticeList.jsp?currentPage=<%=currentPage+1%>">next</a>
	                        </li>
                    <%
	            		}
	            	%>
                    </ul>
                </div>
	            	
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->
<%@ include file="adminFooter.jsp"%>