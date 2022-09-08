x<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <title>Zay</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="assets/img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/templatemo.css">
    <link rel="stylesheet" href="assets/css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="assets/css/fontawesome.min.css">
    
    <!-- Custom Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
<!--
    
TemplateMo 559 Zay Shop

https://templatemo.com/tm-559-zay-shop

-->
<style>
#myimg img {
	width : 255px;
	height : 260px;
	text-align : center;
}
#cartListImg {
	width : 100px;
	height : 100px;
}
</style>
</head>

<body>
    <!-- Start Top Nav -->
    <nav class="navbar navbar-expand-lg bg-dark navbar-light d-none d-lg-block" id="templatemo_nav_top">
        <div class="container text-light">
            <div class="w-100 d-flex justify-content-between">
                <div>
                    <i class="fa fa-envelope mx-2"></i>
                    <a class="navbar-sm-brand text-light text-decoration-none" href="mailto:iloveohau@naver.com">iloveohau@naver.com</a>
                </div>
            </div>
        </div>
    </nav>
    <!-- Close Top Nav -->


    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light shadow">
        <div class="container d-flex justify-content-between align-items-center">

            <a class="navbar-brand text-success logo h1 align-self-center" href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp">
                Zay
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#templatemo_main_nav" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between" id="templatemo_main_nav">
                <div class="flex-fill">
                    <ul class="nav navbar-nav d-flex justify-content-between mx-lg-auto">
                     	<%
                        	if(session.getAttribute("id") != null){
                        %>
		                        <li class="nav-item">
		                            <a class="nav-link" href="<%=request.getContextPath()%>/theme/index.jsp">Home</a>
		                        </li>
                        <%
                        	} 
                        %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp">Shop</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/theme/review.jsp">Review</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/theme/notice.jsp">Notice</a>
                        </li>
                        <%
                        	if(session.getAttribute("id") != null){
                        %>
		                        <li class="nav-item">
		                            <a class="nav-link" href="<%=request.getContextPath()%>/theme/logout.jsp">Logout</a>
		                        </li>
                        <%
                        	} else {
                        %>
                        		 <li class="nav-item">
		                            <a class="nav-link" href="<%=request.getContextPath()%>/theme/loginForm.jsp">Login</a>
		                        </li>
                        <%
                        	}
                        %>
                    </ul>
                </div>
                <div class="navbar align-self-center d-flex">
                    <!-- <div class="d-lg-none flex-sm-fill mt-3 mb-4 col-7 col-sm-auto pr-3">
                        <div class="input-group">
                            <input type="text" class="form-control" id="inputMobileSearch" placeholder="Search ...">
                            <div class="input-group-text">
                                <i class="fa fa-fw fa-search"></i>
                            </div>
                        </div>
                    </div>
                    <a class="nav-icon d-none d-lg-inline" href="#" data-bs-toggle="modal" data-bs-target="#templatemo_search">
                        <i class="fa fa-fw fa-search text-dark mr-2"></i>
                    </a> -->
                    <%
                    	// id null 아니고 customer일경우만 보이기
                    	if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))){
                    %>
		                    <a class="nav-icon position-relative text-decoration-none" href="<%=request.getContextPath()%>/theme/cartList.jsp">
		                        <i class="fa fa-fw fa-cart-arrow-down text-dark mr-1"></i>
		                        <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark"><!-- 장바구니에 담긴 개수 --></span>
		                    </a>
	                <%
	                	}
                    %>
                    <a class="nav-icon position-relative text-decoration-none" href="<%=request.getContextPath()%>/theme/index.jsp">
                        <i class="fa fa-fw fa-user text-dark mr-3"></i>
                        <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark"></span>
                    </a>
                </div>
            </div>

        </div>
    </nav>
    <!-- Close Header -->