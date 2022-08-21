<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%@ page import="java.util.*"%>
<%@ include file="header.jsp"%>
<%
	// listVer 값받기
	String listVer = "orderVer";
	if(request.getParameter("listVer") != null){
		listVer = request.getParameter("listVer");
	}
	

	// Controller : java class <- Serlvet
	int rowPerPage = 20;
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	GoodsService goodsService = new GoodsService();
	
	// 페이징
	// lastPage
	int	lastPage = goodsService.lastPage(rowPerPage);
	
	// startPage , endPage
	// 숫자페이징
	int startPage = ((currentPage - 1) / rowPerPage) * rowPerPage + 1; // 페이지 시작
	int endPage = startPage + rowPerPage - 1; // 페이지 끝
	// endPage 와 lastPage 비교
	endPage = Math.min(endPage, lastPage);
	
	// list - 모델값
	List<Map<String, Object>> list = goodsService.getCustomerGoodsListByPage(rowPerPage, currentPage, listVer);
%>
<!-- 분리하면 servlet / 중계기술(forword - 겹친다, 덮어쓴다(request - 세션과 같이 저장할 수 있다 차이점 이 jsp가 끝나면 저장된것이 사라진다 또 forword 하지 않는 이상, response)) / jsp -->

<!-- 태그 -->

	<!-- for / if : java -- 대체기술 : 커스텀태그(JSTL & EL) -- jsp(전용뷰가 아님 서블릿이랑 같은 것) 사용  -->

    <!-- Modal -->
    <div class="modal fade bg-white" id="templatemo_search" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="w-100 pt-1 mb-5 text-right">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" method="get" class="modal-content modal-body border-0 p-0">
                <div class="input-group mb-2">
                    <input type="text" class="form-control" id="inputModalSearch" name="q" placeholder="Search ...">
                    <button type="submit" class="input-group-text bg-success text-light">
                        <i class="fa fa-fw fa-search text-white"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>



    <!-- Start Content -->
    <div class="container py-5">
        <div class="row">
			<!-- 사이드바 -->
            <div class="col-lg-2">
                <h1 class="h2 pb-4">Categories</h1>
                <ul class="list-unstyled templatemo-accordion">
                    <li class="pb-3">
                        <a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
                            Gender
                            <i class="fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
                        <ul class="collapse show list-unstyled pl-3">
                            <li><a class="text-decoration-none" href="#">Men</a></li>
                            <li><a class="text-decoration-none" href="#">Women</a></li>
                        </ul>
                    </li>
                    <li class="pb-3">
                        <a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
                            Sale
                            <i class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
                        <ul id="collapseTwo" class="collapse list-unstyled pl-3">
                            <li><a class="text-decoration-none" href="#">Sport</a></li>
                            <li><a class="text-decoration-none" href="#">Luxury</a></li>
                        </ul>
                    </li>
                    <li class="pb-3">
                        <a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
                            Product
                            <i class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
                        <ul id="collapseThree" class="collapse list-unstyled pl-3">
                            <li><a class="text-decoration-none" href="#">Bag</a></li>
                            <li><a class="text-decoration-none" href="#">Sweather</a></li>
                            <li><a class="text-decoration-none" href="#">Sunglass</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- end 사이드바 -->
            
            
			<!-- 상단 바 -->            
            <div class="col-lg-10" id="myimg">
                <div class="row">
                    <div class="col-md-8">
                        <ul class="list-inline shop-top-menu pb-3 pt-1">
                            <li class="list-inline-item">
                                <a class="h4 text-dark text-decoration-none mr-3" href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp?listVer=viewCountVer">인기순</a>
                            </li>
                            <li class="list-inline-item">
                                <a class="h4 text-dark text-decoration-none mr-3" href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp?listVer=orderVer">판매량순</a>
                            </li>
                            <li class="list-inline-item">
                                <a class="h4 text-dark text-decoration-none" href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp?listVer=lowPriceVer">낮은가격순</a>
                            </li>
                            <li class="list-inline-item">
                                <a class="h4 text-dark text-decoration-none" href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp?listVer=highPriceVer">높은가격순</a>
                            </li>
                            <li class="list-inline-item">
                                <a class="h4 text-dark text-decoration-none" href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp?listVer=createDateVer">최신순</a>
                            </li>
                            <li class="list-inline-item">
                            	<form action="<%=request.getContextPath()%>/theme/updateRowPerPage.jsp" method="post">
	                            	<select name="rowPerPage">
	                            	<%
	                            		if(rowPerPage == 20){
	                            	%>
		                            		<option value="20">20개씩 보기</option>
		                            		<option value="40">40개씩 보기</option>
	                            	<%
	                            		} else {
	                            	%> 	
		                            		<option value="20">20개씩 보기</option>
		                            		<option value="40" selected="selected">40개씩 보기</option>
	                            	<%
	                            		}
	                            	%>
	                            	</select>
	                            	<button type="submit" class="btn btn-dark">변경</button>
                            	</form>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 pb-4">
                        <div class="d-flex">
                            <select class="form-control">
                                <option>Featured</option>
                                <option>A to Z</option>
                                <option>Item</option>
                            </select>
                        </div>
                    </div>
                </div>
			<!-- end 상단 바 -->    

			<!-- list -->	
				<div class="row">
				<%
					int j = 1;
				
					for(Map<String, Object> m : list) {
				%>
	                    <div class="col-md-3">
	                        <div class="card mb-4 product-wap rounded-0">
	                            <div class="card rounded-0">
	                                <img class="card-img rounded-0 img-fluid" src="<%=request.getContextPath()%>/theme/upload/<%=m.get("fileName")%>">
	                                <div class="card-img-overlay rounded-0 product-overlay d-flex align-items-center justify-content-center">
	                                    <ul class="list-unstyled">
	                                        <!-- <li><a class="btn btn-success text-white" href="#"><i class="far fa-heart"></i></a></li> -->
	                                        <li><a class="btn btn-success text-white mt-2" href="<%=request.getContextPath()%>/theme/customerGoodsOne.jsp?goodsNo=<%=m.get("goodsNo")%>"><i class="far fa-eye"></i></a></li>
	                                       	<%
	                                       		if(m.get("soldOut").equals("N")) {
	                                       	%>
	                                       			 <li><a class="btn btn-success text-white mt-2" href="<%=request.getContextPath()%>/theme/addCartAction.jsp?goodsNo=<%=m.get("goodsNo")%>&cartQuantity=1&submit=addtocart"><i class="fas fa-cart-plus"></i></a></li>
	                                   		<%
	                                       		}
	                                       	%>
	                                    </ul>
	                                </div>
	                            </div>
	                            <div class="card-body">
	                                <a href="<%=request.getContextPath()%>/theme/customerGoodsOne.jsp?goodsNo=<%=m.get("goodsNo")%>" class="h3 text-decoration-none"><%=m.get("goodsName")%></a>
	                                <ul class="list-unstyled d-flex justify-content-center mb-1">
	                                    <li>
	                                        <i class="text-warning fa fa-star"></i>
	                                        <i class="text-warning fa fa-star"></i>
	                                        <i class="text-warning fa fa-star"></i>
	                                        <i class="text-warning fa fa-star-half"></i>
	                                        <i class="text-muted fa fa-star"></i>
	                                    </li>
	                                </ul>
	                                <p class="text-center mb-0"><%=m.get("goodsPrice")%>원</p>
	                            </div>
	                        </div>
	                    </div>

			<%	
					if(j % 4 == 0){
			%>
						</div><div class="row">
			<%	
					}
					j++;
				}
			%>

	 </div>
              	<!-- 페이징 -->  
                <div class="row">
                    <ul class="pagination pagination-lg justify-content-center">
	            	<%
	            		if(currentPage > 1){
	            	%>
		            		 <li class="page-item">
	                            <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">pre</a>
	                         </li>	
	            	<%
	            		}
                    	
                    	// 숫자페이징
                    	for(int i = startPage; i <= endPage; i++){
                    		if(i == currentPage){
		            %>
		            			<li class="page-item disabled">
		            				 <a class="page-link active rounded-0 mr-3 shadow-sm border-top-0 border-left-0" href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp?currentPage=<%=i%>&rowPerPage=<%=rowPerPage%>"><%=i%></a>
		            			</li>
	            	<%
                    		} else {
                	%>
		            			<li class="page-item">
		            				 <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp?currentPage=<%=i%>&rowPerPage=<%=rowPerPage%>"><%=i%></a>
		            			</li>
	            	<%			
                    		}
                    	}
                    	
	            		if(currentPage < lastPage){
	            	%>
	                        <li class="page-item">
	                            <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">next</a>
	                        </li>
                    <%
	            		}
	            	%>
                    </ul>
                </div>

        	</div>
   		 </div>
    </div>
    <!-- End Content -->

    <!-- Start Brands -->
    <section class="bg-light py-5">
        <div class="container my-4">
            <div class="row text-center py-3">
                <div class="col-lg-6 m-auto">
                    <h1 class="h1">Our Brands</h1>
                </div>
                <div class="col-lg-9 m-auto tempaltemo-carousel">
                    <div class="row d-flex flex-row">
                        <!--Controls-->
                        <div class="col-1 align-self-center">
                            <a class="h1" href="#multi-item-example" role="button" data-bs-slide="prev">
                                <i class="text-light fas fa-chevron-left"></i>
                            </a>
                        </div>
                        <!--End Controls-->

                        <!--Carousel Wrapper-->
                        <div class="col">
                            <div class="carousel slide carousel-multi-item pt-2 pt-md-0" id="multi-item-example" data-bs-ride="carousel">
                                <!--Slides-->
                                <div class="carousel-inner product-links-wap" role="listbox">

                                    <!--First slide-->
                                    <div class="carousel-item active">
                                        <div class="row">
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_01.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_02.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_03.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_04.png" alt="Brand Logo"></a>
                                            </div>
                                        </div>
                                    </div>
                                    <!--End First slide-->

                                    <!--Second slide-->
                                    <div class="carousel-item">
                                        <div class="row">
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_01.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_02.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_03.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_04.png" alt="Brand Logo"></a>
                                            </div>
                                        </div>
                                    </div>
                                    <!--End Second slide-->

                                    <!--Third slide-->
                                    <div class="carousel-item">
                                        <div class="row">
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_01.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_02.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_03.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="assets/img/brand_04.png" alt="Brand Logo"></a>
                                            </div>
                                        </div>
                                    </div>
                                    <!--End Third slide-->

                                </div>
                                <!--End Slides-->
                            </div>
                        </div>
                        <!--End Carousel Wrapper-->

                        <!--Controls-->
                        <div class="col-1 align-self-center">
                            <a class="h1" href="#multi-item-example" role="button" data-bs-slide="next">
                                <i class="text-light fas fa-chevron-right"></i>
                            </a>
                        </div>
                        <!--End Controls-->
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--End Brands-->
<%@ include file="footer.jsp"%>