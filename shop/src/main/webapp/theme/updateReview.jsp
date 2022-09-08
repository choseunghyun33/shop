<%@page import="service.ReviewService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%
   	if(session.getAttribute("id") == null){
   		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
   		return;
   	} else if(session.getAttribute("id") != null && "employee".equals((String)session.getAttribute("user"))) {
   		// 사용자가 아닌경우 막기
   		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
		return;
   	}

	// 값받기
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String goodsName = request.getParameter("goodsName");
	
	// 리뷰 가져오기 메서드 실행
	Review review = new ReviewService().getReviewByOrderNo(orderNo);
	
	// 디버깅
	System.out.println("updateReview.jsp getReviewByOrderNo() review : " + review);
%>

    <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <!-- col end -->
                <div class="col-lg-12 mt-5 text-center">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">리뷰수정</h1>
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
                            	<form action="<%=request.getContextPath()%>/theme/updateReviewAction.jsp" method="post" id="form">
                            		<input type="hidden" name="orderNo" value="<%=orderNo%>">
                            		<input type="hidden" name="goodsName" value="<%=goodsName%>">
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
					            				<%=goodsName%>
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>별점</th>
					            			<td>
							            		<select name="star" class="form-control">
							            			<option value="<%=review.getStar()%>"><%=review.getStar()%></option> 
					            					<%
					            						for(int i = 5; i >= 1; i--){
					            					%>
					            							<option value="<%=i%>"><%=i%></option>
					            					<%
					            						}
					            					%>
					            				</select>
					            			</td>
					            		</tr>
					            		<tr>
					            			<th >리뷰내용</th>
					            			<td>
					            				<textarea rows="10" cols="5" name="reviewContent" id="reviewContent" class="form-control"><%=review.getReviewContent()%></textarea>
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
					            	<button type="button" class="btn btn-dark" id="btn">리뷰수정</button>
				            	</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Close Content -->
   	<script>
		$('#btn').click(function(){
			if($('#reviewContent').val().length < 1){
				alert('리뷰내용을 기입해주세요');
			} else {
				$('#form').submit();
			}
		});
	</script>
<%@ include file="footer.jsp"%>