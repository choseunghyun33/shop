<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%@ page import="vo.Goods"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ include file="adminHeader.jsp"%>
<%
	// 값 받기
	String goodsNo = request.getParameter("goodsNo");
	// 디버깅
	System.out.println("adminGoodsOne.jsp goodsNo : " + goodsNo);
	
	if(goodsNo == null){
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
		return;
	} else if(session.getAttribute("id") == null){
   		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
   		return;
   	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
   		// 관리자가 아닌경우 막기
   		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
   		return;
   	}
	 
	// 메서드를 위한 객체생성
	GoodsService goodsService = new GoodsService();
	
	// 상세페이지 메서드
	Map<String, Object> map = goodsService.getGoodsAndImgOne(Integer.parseInt(goodsNo));
	// 디버깅
	System.out.println("adminGoodsOne.jsp map : " + map.toString());
%>

    <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <div class="col-lg-5 mt-5">
                    <div class="card">
                        <img class="card-img img-fluid" src="<%=request.getContextPath()%>/theme/upload/<%=map.get("filename")%>" alt="Card image cap" id="product-detail">
                    </div>
                </div>
                <!-- col end -->
                <div class="col-lg-7 mt-5">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">상품수정</h1>
                            	<%
				                	if(request.getParameter("errorMsg") != null){
								%>
										<span style="color:red"><%=request.getParameter("errorMsg")%></span>
				           		<%		
				                	}
				                %>  
                            	<hr>
                            	<form action="<%=request.getContextPath()%>/theme/admin/adminUpdateGoodsAction.jsp" method="post" id="form">
	                           		<table class="table">
					            		<tr>
					            			<th>상품번호</th>
					            			<td>
					            				<input type="text" value="<%=map.get("goodsNo")%>" name="goodsNo" class="form-control" readonly="readonly">
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>상품명</th>
					            			<td>
					            				<input type="text" value="<%=map.get("goodsName")%>" name="goodsName" id="goodsName" class="form-control">
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>상품가격</th>
					            			<td>
					            				<input type="text" value="<%=map.get("goodsPrice")%>" name="goodsPrice" id="goodsPrice" class="form-control">
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>상품등록날짜</th>
					            			<td>
					            				<input type="text" value="<%=map.get("createDate")%>" name="createDate" class="form-control" readonly="readonly">
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>상품수정날짜</th>
					            			<td>
					            				<input type="text" value="<%=map.get("updateDate")%>" name="updateDate" class="form-control" readonly="readonly">
					            			</td>
					            		</tr>
										<tr>
											<th>품절여부</th>
											<td>
												<select name="soldOut" class="form-control">
					            						<%
					            							if("Y".equals(map.get("soldOut"))) {
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
											</td>
										</tr>					            		
				            		</table> 
				            	<button type="button" class="btn btn-dark" id="btn">상품수정</button>
				            </form>
				        <br>
				        <br>
		            <h1 class="h2">상품 이미지수정</h1>
                     	<hr>
				            <form action="<%=request.getContextPath()%>/theme/admin/adminUpdateGoodsImgAction.jsp" method="post" enctype="multipart/form-data" id="imgForm">
	                           		<input type="hidden" name="goodsNo" value="<%=map.get("goodsNo")%>">
	                           		<table class="table">
					            		<tr>
					            			<th>이미지</th>
					            			<td>
		            							<input type="file" name="imgFile" id="imgFile" class="form-control">
					            			</td>
					            		</tr>
				            		</table> 
				            	<button type="button" class="btn btn-dark" id="imgBtn">상품 이미지수정</button>
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
			} else if($('#soldOut').val() == 'defualt'){
				alert('품절여부를 선택해주세요');
			} else {
				$('#form').submit();
			}
    	});
	    
	    $('#imgBtn').click(function(){
	    	if($('#imgFile').val().length < 1){
				alert('상품파일을 등록해주세요');
			} else {
				$('#imgForm').submit();
			}
	    });
    </script>
<%@ include file="adminFooter.jsp"%>