<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%@ page import="vo.Goods"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ include file="header.jsp"%>
	<%
		// 값 받기
		int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
		// 디버깅
		System.out.println("adminGoodsOne.jsp goodsNo : " + goodsNo);
		
		// 메서드를 위한 객체생성
		GoodsService goodsService = new GoodsService();
		
		// 상세페이지 메서드
		Map<String, Object> map = goodsService.getGoodsAndImgOne(goodsNo);
		// 디버깅
		System.out.println("adminGoodsOne.jsp map : " + map.toString());
		
		// 품절일 경우 (Y/N이 아닌 품절/재고있음) 으로 나오기
		String soldOut = "";
		if("Y".equals(map.get("soldOut"))) {
			soldOut = "품절";
		} else {
			soldOut = "재고있음";
		}
		
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
                            <h1 class="h2">상품 상세보기</h1>
                            	<hr>
	                           <table class="table">
				            		<tr>
				            			<th>상품번호</th>
				            			<td><%=map.get("goodsNo")%></td>
				            		</tr>
				            		<tr>
				            			<th>상품명</th>
				            			<td><%=map.get("goodsName")%></td>
				            		</tr>
				            		<tr>
				            			<th>상품가격</th>
				            			<td><%=map.get("goodsPrice")%>원</td>
				            		</tr>
				            		<tr>
				            			<th>상품등록날짜</th>
				            			<td><%=map.get("createDate")%></td>
				            		</tr>
				            		<tr>
				            			<th>상품수정날짜</th>
				            			<td><%=map.get("updateDate")%></td>
				            		</tr>
				            		<tr>
				            			<th>상품품절여부</th>
				            			<td><%=soldOut%></td>
				            		</tr>
				            		<tr>
				            			<th>상품평</th>
				            			<td>
											<p class="py-2">
				                                <i class="fa fa-star text-warning"></i>
				                                <i class="fa fa-star text-warning"></i>
				                                <i class="fa fa-star text-warning"></i>
				                                <i class="fa fa-star text-warning"></i>
				                                <i class="fa fa-star text-secondary"></i>
				                                <span class="list-inline-item text-dark">Rating 4.8 | 36 Comments</span>
				                            </p>
										</td>
				            		</tr>
				            	</table> 
				            	<% 
				            		if(soldOut.equals("재고있음")){
				            	%>
						            	 <form action="<%=request.getContextPath()%>/theme/addCartAction.jsp" method="get">
			                                <input type="hidden" name="goodsNo" value="<%=goodsNo%>">
			                                <div class="row">
			                                    <div class="col-auto">
			                                        <ul class="list-inline pb-3">
			                                            <li class="list-inline-item text-right">
			                                                Quantity
			                                                <input type="hidden" name="cartQuantity" id="product-quanity" value="1">
			                                            </li>
			                                            <li class="list-inline-item"><span class="btn btn-success" id="btn-minus">-</span></li>
			                                            <li class="list-inline-item"><span class="badge bg-secondary" id="var-value">1</span></li>
			                                            <li class="list-inline-item"><span class="btn btn-success" id="btn-plus">+</span></li>
			                                        </ul>
			                                    </div>
			                                </div>
			                                <div class="row pb-3">
			                                    <div class="col d-grid">
			                                        <button type="submit" class="btn btn-success btn-lg" name="submit" value="buy">Buy</button>
			                                    </div>
			                                    <div class="col d-grid">
			                                        <button type="submit" class="btn btn-success btn-lg" name="submit" value="addtocart">Add To Cart</button>
			                                    </div>
			                                </div>
			                            </form>
	                           <%
				            		}
	                           %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Close Content -->
<%@ include file="footer.jsp"%>