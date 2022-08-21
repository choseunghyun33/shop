<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="h-100" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Login</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    <!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous"> -->
    <link href="css/style.css" rel="stylesheet">
    
</head>

<body class="h-100">
    
    <!--*******************
        Preloader start
    ********************-->
    <div id="preloader">
        <div class="loader">
            <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
            </svg>
        </div>
    </div>
    <!--*******************
        Preloader end
    ********************-->
	<%
		// 막기
		if(session.getAttribute("id") != null){
			response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=wrong Path");
			return;
		}
	%>
    
    <div class="login-form-bg h-100">
        <div class="container h-100">
            <div class="row justify-content-center h-100">
                <div class="col-xl-6">
                    <div class="form-input-content">
                        <div class="card login-form mb-0">
                            <div class="card-body pt-5">
                                <h4>고객 로그인</h4>
        						<%
				                	if(request.getParameter("errorMsg") != null){
								%>
										<span style="color:red"><%=request.getParameter("errorMsg")%></span>
				           		<%		
				                	}
				                %>   
                                <form class="mt-5 mb-5 login-input" action="<%=request.getContextPath()%>/theme/customerLoginAction.jsp" method="post" id="customerForm">
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="Id" name="customerId" id="customerId">
                                    </div>
                                    <div class="form-group">
                                        <input type="password" class="form-control" placeholder="Password" name="customerPass" id="customerPass">
                                    </div>
                                    <button class="btn login-form__btn w-100" type="button" id="customerBtn">고객 로그인</button>
                                </form>
                                <p class="mt-5 login-form__footer">Dont have account? <a href="sign-up.jsp" class="text-primary">Sign Up</a> now</p>
                            	<p class="mt-5 login-form__footer"><a href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp" class="text-primary">Shop </a> now</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-6">
                    <div class="form-input-content">
                        <div class="card login-form mb-0">
                            <div class="card-body pt-5">
                                <h4>STAFF 로그인</h4>
        						<%
				                	if(request.getParameter("errorMsg") != null){
								%>
										<span style="color:red"><%=request.getParameter("errorMsg")%></span>
				           		<%		
				                	}
				                %>        
                                <form class="mt-5 mb-5 login-input" action="<%=request.getContextPath()%>/theme/employeeLoginAction.jsp" method="post" id="employeeForm">
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="Id" name="employeeId" id="employeeId">
                                    </div>
                                    <div class="form-group">
                                        <input type="password" class="form-control" placeholder="Password" name="employeePass" id="employeePass">
                                    </div>
                                    <button class="btn login-form__btn w-100" type="button" id="employeeBtn">STAFF 로그인</button>
                                </form>
                                <p class="mt-5 login-form__footer">Dont have account? <a href="sign-up.jsp" class="text-primary">Sign Up</a> now</p>
                            	<p class="mt-5 login-form__footer"><a href="<%=request.getContextPath()%>/theme/customerGoodsList.jsp" class="text-primary">Shop </a> now</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    

    

    <!--**********************************
        Scripts
    ***********************************-->
    <script src="plugins/common/common.min.js"></script>
    <script src="js/custom.min.js"></script>
    <script src="js/settings.js"></script>
    <script src="js/gleek.js"></script>
    <script src="js/styleSwitcher.js"></script>
</body>
<script>
	// 함수만드는 법
	// 1. let test = function(){}
	// 2. function test(){}
	
	// 고객 빈칸검사
	$('#customerBtn').click(function(){
		if($('#customerId').val().length < 4){
			alert('고객아이디는 4자 이상 기입해주세요');
		} else if($('#customerPass').val().length < 4) {
			alert('고객비밀번호는 4자 이상 기입해주세요');
		} else {
			$('#customerForm').submit();
		}
	});
	// 스텝 빈칸검사
	$('#employeeBtn').click(function(){
		if($('#employeeId').val().length < 4){
			alert('직원아이디는 4자 이상 기입해주세요');
		} else if($('#employeePass').val().length < 4) {
			alert('직원비밀번호는 4자 이상 기입해주세요');
		} else {
			$('#employeeForm').submit();
		}
	});
</script>
</html>