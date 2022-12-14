<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%@ page import="vo.Goods"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ include file="adminHeader.jsp"%>
	<%
       	if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
       		// 관리자가 아닌경우 막기
       		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
    		return;
       	}
	
		// 페이징
		int currentPage = 1; // 현재페이지
		final int ROW_PER_PAGE = 10; // 묶음

		if(request.getParameter("currentPage") != null){
			// 받아오는 페이지가 있다면 현재페이지변수에 담기
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 메서드를 위한 객체생성
		GoodsService goodsService = new GoodsService();
		
		// 마지막페이지 구하는 메서드
		int lastPage = goodsService.lastPage(ROW_PER_PAGE);
		
		// 숫자페이징
		int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1; // 페이지 시작
		int endPage = startPage + ROW_PER_PAGE - 1; // 페이지 끝
		// endPage 와 lastPage 비교
		endPage = Math.min(endPage, lastPage);
		
		// 리스트
		List<Goods> list = goodsService.getGoodsListByPage(ROW_PER_PAGE, currentPage);
    %>

    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-12 m-auto">
                <h1 class="h1">상품관리</h1>
                  <hr>
                <a href="<%=request.getContextPath()%>/theme/admin/adminGoodsForm.jsp" class="btn btn-dark">상품등록</a>	
                <%
                	if(request.getParameter("errorMsg") != null){
				%>
						<span style="color:red"><%=request.getParameter("errorMsg")%></span>
           		<%		
                	}
                %>  
	            	<table class="table">
	            		<thead>
		            		<tr>
		            			<th>상품번호</th>
		            			<th>상품명</th>
		            			<th>상품가격</th>
		            			<th>상품등록날짜</th>
		            			<th>상품수정날짜</th>
		            			<th>상품품절여부</th>
		            		</tr>
	            		</thead>
	            		<tbody>
		            		<%
		            			for(Goods g : list){
		            		%>
				            		<tr>
				            			<td><%=g.getGoodsNo()%></td>
				            			<td>
				            				<a href="<%=request.getContextPath()%>/theme/admin/adminGoodsOne.jsp?goodsNo=<%=g.getGoodsNo()%>">
				            					<%=g.getGoodsName()%>
				            				</a>
				            			</td>
				            			<td><%=g.getGoodsPrice()%></td>
				            			<td><%=g.getCreateDate()%></td>
				            			<td><%=g.getUpdateDate()%></td>
				            			<td>
				            				<form action="<%=request.getContextPath()%>/theme/admin/updateSoldOut.jsp" method="post">
				            					<input type="hidden" name="goodsNo" value="<%=g.getGoodsNo()%>">
				            					<select name="soldOut">
				            						<%
				            							if("Y".equals(g.getSoldOut())) {
				            						%>
						            						<option value="Y">Y</option>
						            						<option value="N">N</option>
				            						<%
				            							} else {
				            						%>
						            						<option value="N">N</option>
					            							<option value="Y">Y</option>
				            						<%
				            							}
				            						%>
				            					</select>
				            					<button type="submit" class="btn btn-dark">품절변경</button> 
				            				</form>
				            			</td>
				            		</tr>
			            	<%
		            			}
		            		%>
	            		</tbody>
	            	</table>
            	<div class="row">
                    <ul class="pagination pagination-lg justify-content-center">
	            	<%
	            		if(currentPage > 1){
	            	%>
		            		 <li class="page-item">
	                            <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminGoodsList.jsp?currentPage=<%=currentPage-1%>">pre</a>
	                         </li>	
	            	<%
	            		}
                    	
                    	// 숫자페이징
                    	for(int i = startPage; i <= endPage; i++){
                    		if(i == currentPage){
		            %>
		            			<li class="page-item disabled">
		            				 <a class="page-link active rounded-0 mr-3 shadow-sm border-top-0 border-left-0" href="<%=request.getContextPath()%>/theme/admin/adminGoodsList.jsp?currentPage=<%=i%>"><%=i%></a>
		            			</li>
	            	<%
                    		} else {
                	%>
		            			<li class="page-item">
		            				 <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminGoodsList.jsp?currentPage=<%=i%>"><%=i%></a>
		            			</li>
	            	<%			
                    		}
                    	}
                    	
	            		if(currentPage < lastPage){
	            	%>
	                        <li class="page-item">
	                            <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminGoodsList.jsp?currentPage=<%=currentPage+1%>">next</a>
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