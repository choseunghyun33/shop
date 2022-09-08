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
%>

    <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <!-- col end -->
                <div class="col-lg-12 mt-5 text-center">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">리뷰등록</h1>
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
                            	<form action="<%=request.getContextPath()%>/theme/addReviewAction.jsp" method="post" id="form">
                            		<input type="hidden" name="orderNo" value="<%=orderNo%>">
		                            <table class="table">
		                            	<tr>
		                            		<th>상품명</th>
		                            		<td><%=request.getParameter("goodsName")%></td>
		                            	</tr>
					            		<tr>
					            			<th>별점</th>
					            			<td>
					            				<select name="star" class="form-control">
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
					            			<th>리뷰내용</th>
					            			<td>
					            				<textarea rows="10" cols="5" name="reviewContent" id="reviewContent" class="form-control"></textarea>
					            			</td>
					            		</tr>
					            	</table> 
					            	<button type="button" class="btn btn-dark" id="btn">리뷰등록</button>
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
			if($('#reviewContent').val().length < 5){
				alert('리뷰내용을 5자이상 기입해주세요');
			} else {
				$('#form').submit();
			}
		});
	</script>
<%@ include file="footer.jsp"%>