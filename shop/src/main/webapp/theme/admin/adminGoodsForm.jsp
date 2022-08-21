<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%@ page import="vo.Goods"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ include file="adminHeader.jsp"%>
	<%
       	if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
       		// 관리자가 아닌경우 막기
       		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
       	}
    %>

    <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <!-- col end -->
                <div class="col-lg-12 mt-5 text-center">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">상품등록</h1>
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
                            	<form action="<%=request.getContextPath()%>/theme/admin/addGoodsAction.jsp" method="post" enctype="multipart/form-data" id="form">
		                            <table class="table">
					            		<tr>
					            			<th>상품명</th>
					            			<td>
					            				<input type="text" name="goodsName" id="goodsName" class="form-control">
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>상품가격</th>
					            			<td>
					            				<input type="text" name="goodsPrice" id="goodsPrice" class="form-control">
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>이미지</th>
					            			<td>
					            				<input type="file" name="imgFile" id="imgFile" class="form-control">
					            			</td>
					            		</tr>
										<tr>
											<th>품절여부</th>
											<td>
												<select name="soldOut" class="form-control" id="soldOut">
													<option value="defualt">-- 선택 --</option>
			            							<option value="Y">Y</option>
				            						<option value="N">N</option>
				            					</select>
											</td>
										</tr>					            		
					            	</table> 
					            	<button type="button" class="btn btn-dark" id="btn">상품등록</button>
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
			if($('#goodsName').val().length < 2){
				alert('상품명을 2자이상 기입해주세요');
			} else if($('#goodsPrice').val().length < 1){
				alert('상품가격을 기입해주세요');
			} else if($('#imgFile').val().length < 1){
				alert('상품파일을 등록해주세요');
			} else if($('#soldOut').val() == 'defualt'){
				alert('품절여부를 선택해주세요');
			} else {
				$('#form').submit();
			}
		});
	</script>
<%@ include file="adminFooter.jsp"%>