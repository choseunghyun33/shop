<%@page import="service.ReviewService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%
   	if(session.getAttribute("id") == null){
   		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
   		return;
   	} 

	// 값받기
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
	// 리뷰 가져오기 메서드 실행
	Review review = new ReviewService().getReviewByOrderNo(orderNo);
	
	// 디버깅
	System.out.println("reviewOne.jsp getReviewByOrderNo() review : " + review);
%>

    <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <!-- col end -->
                <div class="col-lg-12 mt-5 text-center">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">리뷰 상세보기</h1>
                           	<%
                           		if(request.getParameter("errorMsg") != null){
                           	%>
                           			<span style="color:red">
                           				<%=request.getParameter("errorMsg")%>
                           			</span>
                         	<%
                           		}
                           	%>
                            	<hr>
                       		<input type="hidden" name="orderNo" value="<%=orderNo%>">
	                            <table class="table">
				            		<tr>
				            			<th>주문번호</th>
				            			<td>
				            				<%=review.getOrderNo()%>
				            			</td>
				            		</tr>
				            		<tr>
				            			<th>상품명</th>
				            			<td>
				            				<%=request.getParameter("goodsName")%>
				            			</td>
				            		</tr>
				            		<tr>
				            			<th>별점</th>
				            			<td>
				            					<%
				            						for(int i = 0; i < review.getStar(); i++){
				            					%>
				            							<i class="text-warning fa fa-star"></i>
				            					<%
				            						}
				            					%>
				            			</td>
				            		</tr>
				            		<tr>
				            			<th >리뷰내용</th>
				            			<td>
				            				<%=review.getReviewContent()%>
				            			</td>
				            		</tr>
				            		<tr>
				            			<th>생성일자</th>
				            			<td>
				            				<%=review.getCreateDate()%>
				            			</td>
				            		</tr>
				            		<tr>
				            			<th>수정일자</th>
				            			<td>
				            				<%=review.getUpdateDate()%>
				            			</td>
				            		</tr>
				            	</table> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Close Content -->
<%@ include file="footer.jsp"%>