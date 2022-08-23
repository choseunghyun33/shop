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
                            <h1 class="h2">주문 상세관리</h1>
                            	<hr>
	                           <table class="table">
				            		<tr>
				            			<th>주문번호</th>
				            			<td><%=map.get("orderNo")%></td>
				            			<th>주문상태</th>
				            			<td><%=map.get("orderState")%></td>
				            		</tr>
				            		<tr>
				            			<th>상품번호</th>
				            			<td><%=map.get("goodsNo")%></td>
				            			<th>상품명</th>
				            			<td><%=map.get("goodsName")%></td>
				            		</tr>
				            		<tr>
				            			<th>주문가격</th>
				            			<td><%=map.get("orderPrice")%></td>
				            			<th>주문개수</th>
				            			<td><%=map.get("orderQuantity")%></td>
				            		</tr>
				            		<tr>
				            			<th>고객아이디</th>
				            			<td><%=map.get("customerId")%></td>
				            			<th>고객명</th>
				            			<td><%=map.get("customerName")%></td>
				            		</tr>
				            		<tr>
				            			<th>고객연락처</th>
				            			<td><%=map.get("customerTelephone")%></td>
				            			<th>배송지</th>
				            			<td><%=map.get("orderAddr")%></td>
				            		</tr>
				            		<tr>
				            			<th>주문일자</th>
				            			<td><%=map.get("createDate")%></td>
				            			<th>수정일자</th>
				            			<td><%=map.get("updateDate")%></td>
				            		</tr>
				            	</table> 
					            <a href="<%=request.getContextPath()%>/theme/admin/adminUpdateOrders.jsp?orderNo=<%=orderNo%>" class="btn">수정</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Close Content -->
<%@ include file="adminFooter.jsp"%>