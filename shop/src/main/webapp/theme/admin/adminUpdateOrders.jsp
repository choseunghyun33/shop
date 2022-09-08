<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.OrdersService"%>
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
    		return;
       	}
		
		// 값 받기
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));
		// 디버깅
		System.out.println("adminOrdersListByorderNo.jsp orderNo : " + orderNo);
		
		// 메서드를 위한 객체생성
		OrdersService ordersService = new OrdersService();
		
		// 상세페이지 메서드
		Map<String, Object> map = ordersService.getOrdersOne(orderNo);
		// 디버깅
		System.out.println("adminOrdersListByorderNo map : " + map.toString());
    %>

    <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <!-- col end -->
                <div class="col-lg-12 mt-5">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">주문 상세관리 수정</h1>
                            	<hr>
                            	<form action="<%=request.getContextPath()%>/theme/admin/adminUpdateOrdersAction.jsp" method="post" id="form">
		                           <table class="table">
					            		<tr>
					            			<th>주문번호</th>
					            			<td>
					            				<input type="text" class="form-control" name="orderNo" value="<%=map.get("orderNo")%>" readonly="readonly">
					            			</td>
					            			<th>주문상태</th>
					            			<td>
					            				<select name="orderState" class="form-control">
					            					<option value="<%=map.get("orderState")%>"><%=map.get("orderState")%></option>
					            					<option value="결제완료">결제완료</option>
					            					<option value="상품준비중">상품준비중</option>
					            					<option value="배송준비중">배송준비중</option>
					            					<option value="배송중">배송중</option>
					            					<option value="배송완료">배송완료</option>
					            					<option value="취소">취소</option>
					            				</select>
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>상품번호</th>
					            			<td>
					            				<input type="text" class="form-control" name="goodsNo" value="<%=map.get("goodsNo")%>" readonly="readonly">
					            			</td>
					            			<th>상품명</th>
					            			<td>
					            				<input type="text" class="form-control" name="goodsNo" value="<%=map.get("goodsName")%>" readonly="readonly">
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>주문가격</th>
					            			<td>
					            				<input type="text" class="form-control" name="orderPrice" value="<%=map.get("orderPrice")%>" id="orderPrice">
					            			</td>
					            			<th>주문수량</th>
					            			<td>
					            				<input type="text" class="form-control" name="orderQuantity" value="<%=map.get("orderQuantity")%>" id="orderQuantity">
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>고객아이디</th>
					            			<td>
					            				<input type="text" class="form-control" name="customerId" value="<%=map.get("customerId")%>" readonly="readonly">
					            			</td>
					            			<th>고객명</th>
					            			<td>
					            				<input type="text" class="form-control" name="customerName" value="<%=map.get("customerName")%>" readonly="readonly">
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>고객연락처</th>
					            			<td>
					            				<input type="text" class="form-control" name="customerTelephone" value="<%=map.get("customerTelephone")%>" readonly="readonly">
					            			</td>
					            			<th>배송지</th>
					            			<td>
					            				<input type="text" class="form-control" name="orderAddr" value="<%=map.get("orderAddr")%>" id="orderAddr">
				            				</td>
					            		</tr>
					            		<tr>
					            			<th>주문일자</th>
					            			<td>
					            				<input type="text" class="form-control" name="createDate" value="<%=map.get("createDate")%>" readonly="readonly">
					            			</td>
					            			<th>수정일자</th>
					            			<td>
					            				<input type="text" class="form-control" name="updateDate" value="<%=map.get("updateDate")%>" readonly="readonly">
					            			</td>
					            		</tr>
					            	</table> 
					            <button type="button" class="btn btn-dark" id="btn">수정</button>
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
    		if($('#orderPrice').val().length < 1){
    			alert('주문가격을 기입해주세요');
    		} else if($('#orderQuantity').val().length < 1){
    			alert('주문수량을 기입해주세요');
    		} else if($('#orderAddr').val().length < 1){
    			alert('고객주소를 기입해주세요');
    		} else {
    			$('#form').submit();
    		} 
    	});
    </script>
<%@ include file="adminFooter.jsp"%>