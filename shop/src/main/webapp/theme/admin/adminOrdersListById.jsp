<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.OrdersService"%>
<%@ page import="vo.Orders"%>
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
		
		// 값 받기
		String customerId = request.getParameter("customerId");
		
		// 페이징
		int currentPage = 1; // 현재페이지
		final int ROW_PER_PAGE = 10; // 묶음

		if(request.getParameter("currentPage") != null){
			// 받아오는 페이지가 있다면 현재페이지변수에 담기
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 메서드를 위한 객체생성
		OrdersService ordersService = new OrdersService();
		
		// 마지막페이지 구하는 메서드
		int lastPage = ordersService.lastPageById(ROW_PER_PAGE, customerId);
		
		// 숫자페이징
		int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1; // 페이지 시작
		int endPage = startPage + ROW_PER_PAGE - 1; // 페이지 끝
		// endPage 와 lastPage 비교
		endPage = Math.min(endPage, lastPage);
		
		// 리스트
		List<Map<String, Object>> list = ordersService.getOrdersListByCustomer(customerId, ROW_PER_PAGE, currentPage);
    %>

    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-12 m-auto">
                <h1 class="h1"><%=customerId%>고객님 주문관리</h1>
                <%
                	if(request.getParameter("errorMsg") != null){
				%>
						<span style="color:red"><%=request.getParameter("errorMsg")%></span>
           		<%		
                	}
                %>  
                	 <hr>
	            	<table class="table">
	            		<thead>
		            		<tr>
		            			<th>주문번호</th>
		            			<th>상품번호</th>
		            			<th>상품명</th>
		            			<th>주문수량</th>
		            			<th>주문가격</th>
		            			<th>배송지</th>
		            			<th>주문상태</th>
		            			<th>주문일자</th>
		            			<th>수정일자</th>
		            		</tr>
	            		</thead>
	            		<tbody>
		            		<%
		            			for(Map<String, Object> m : list){
		            		%>
				            		<tr>
				            			<td>
				            				<a href="<%=request.getContextPath()%>/theme/admin/adminOrdersListByorderNo.jsp?orderNo=<%=m.get("orderNo")%>">
				            					<%=m.get("orderNo")%>
				            				</a>
				            			</td>
				            			<td><%=m.get("goodsNo")%></td>
				            			<td><%=m.get("goodsName")%></td>
				            			<td><%=m.get("orderQuantity")%></td>
				            			<td><%=m.get("orderPrice")%></td>
				            			<td><%=m.get("orderAddr")%></td>
				            			<td>
				            				<form action="<%=request.getContextPath()%>/theme/admin/updateOrderState.jsp" method="post">
				            					<input type="hidden" name="orderNo" value="<%=m.get("orderNo")%>">
				            					<input type="hidden" name="path" value="adminOrdersListById.jsp?customerId=<%=customerId%>">
					            				<select name="orderState">
					            					<option value="<%=m.get("orderState")%>"><%=m.get("orderState")%></option>
					            					<option value="결제완료">결제완료</option>
					            					<option value="상품준비중">상품준비중</option>
					            					<option value="배송준비중">배송준비중</option>
					            					<option value="배송중">배송중</option>
					            					<option value="배송완료">배송완료</option>
					            					<option value="취소">취소</option>
					            				</select>
					            				<button type="submit" class="btn">변경</button>
				            				</form>
				            			</td>
				            			<td><%=m.get("createDate")%></td>
				            			<td><%=m.get("updateDate")%></td>
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
	                            <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminOrdersListById.jsp?currentPage=<%=currentPage-1%>">pre</a>
	                         </li>	
	            	<%
	            		}
                    	
                    	// 숫자페이징
                    	for(int i = startPage; i <= endPage; i++){
                    		if(i == currentPage){
		            %>
		            			<li class="page-item disabled">
		            				 <a class="page-link active rounded-0 mr-3 shadow-sm border-top-0 border-left-0" href="<%=request.getContextPath()%>/theme/admin/adminOrdersListById.jsp?currentPage=<%=i%>"><%=i%></a>
		            			</li>
	            	<%
                    		} else {
                	%>
		            			<li class="page-item">
		            				 <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminOrdersListById.jsp?currentPage=<%=i%>"><%=i%></a>
		            			</li>
	            	<%			
                    		}
                    	}
                    	
	            		if(currentPage < lastPage){
	            	%>
	                        <li class="page-item">
	                            <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminOrdersListById.jsp?currentPage=<%=currentPage+1%>">next</a>
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