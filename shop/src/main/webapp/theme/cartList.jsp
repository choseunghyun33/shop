<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%@ page import="vo.Cart"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="service.CustomerService"%>
<%@ page import="service.CartService"%>
<%@ include file="header.jsp"%>
<%
	// 막기
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
		return;
	} else if(session.getAttribute("id") != null && "employee".equals((String)session.getAttribute("user"))) {
		// 손님이 아닌경우 막기
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
		return;
	}

	// 세션에 있는 아이디 받기
	Cart cart = new Cart();
	cart.setCustomerId((String)session.getAttribute("id"));
	
	// 카트 가져오기
	CartService cartService = new CartService();

	// list에 담기
	List<Map<String, Object>> list = cartService.getCartById(cart);
%>

    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-12 m-auto">
                <h1 class="h1">Cart</h1>
                <%
                	if(request.getParameter("errorMsg") != null){
				%>
						<span style="color:red"><%=request.getParameter("errorMsg")%></span>
           		<%		
                	}
                %>  
                	 <hr>
                <form action="<%=request.getContextPath()%>/theme/cartAction.jsp" method="post">
	            	<table class="table text-center">
	            		<thead>
		            		<tr>
		            			<th>선택</th>
		            			<th>상품사진</th>
		            			<th>상품명</th>
		            			<th>수량</th>
		            			<th>가격</th>
		            			<th>총가격</th>
		            		</tr>
	            		</thead>
	            		<tbody>
	            			<%
	            				for(Map<String, Object> m : list) {
	            			%>
			            			<tr>
			            				<td>
			            					<input type="checkbox" name="goodsNo" value="<%=m.get("goodsNo")%>">
			            				</td>
			            				<td>
			            					<img src="<%=request.getContextPath()%>/theme/upload/<%=m.get("filename")%>" id="listImg">
			            				</td>
			            				<td><%=m.get("goodsName")%></td>
			            				<td>
			            					<select name="cartQuantity" id="cartQuantity">
			            						<option value="<%=m.get("cartQuantity")%>"><%=m.get("cartQuantity")%></option>
			            						<%
			            							for(int i = 1; i <= 10; i++){
			            						%>
			            								<option value="<%=i%>"><%=i%></option>
			            						<%		
			            							}
			            						%>
			            					</select>
										</td>
			            				<td><%=m.get("goodsPrice")%>원</td>
			            				<td>
											<%=Integer.parseInt(m.get("goodsPrice").toString()) * Integer.parseInt(m.get("cartQuantity").toString())%>원
										</td>
				            		</tr>
		            		<%
	            				}
	            			%>
	            		</tbody>
	            	</table>
	            	<button type="submit" name="submit" value="order" class="btn btn-dark">주문</button>
					<button type="submit" name="submit" value="modify" class="btn">수량변경</button>
	            	<button type="submit" name="submit" value="remove" class="btn">삭제</button>
            	</form>
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->
<%@ include file="footer.jsp"%>