<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="h-100" lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Sign up</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
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
                                
                                <h4>고객 회원가입</h4>
        						<%
				                	if(request.getParameter("errorMsg") != null){
								%>
										<span style="color:red"><%=request.getParameter("errorMsg")%></span>
				           		<%		
				                	}
				                %>
                                <!-- 고객 회원가입 -->
                                <%
                                	String customerCkId = "";
                                	if(request.getParameter("customerCkId") != null){
                                		customerCkId = request.getParameter("customerCkId");
                                	}
                                %>
                                <form class="mt-5 mb-5 login-input" method="post" action="<%=request.getContextPath()%>/theme/sign-upAction.jsp" id="customerForm">
                                	<input type="hidden" name="user" value="customer">
                                    <div class="form-group">
                                        <input type="text" class="form-control"  placeholder="Name" id="customerName" name="name" required>
                                    </div>
                                    <div class="form-group">
                                    	<div class="row">
	                                    	<div class="col-sm-8">
	                                        	<input type="text" class="form-control"  placeholder="Id Check" id="customerCkId" name="customerCkId" value="<%=customerCkId%>" required>
	                                        </div>
	                                        <div class="col-sm-4">
	                                        	<button type="button" id="customerIdBtn" class="btn">아이디 중복검사</button>
	                                        </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control"  placeholder="Id" id="customerId" name="id" value="<%=customerCkId%>" readonly="readonly" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="password" class="form-control" placeholder="Password" id="customerPass" name="pass" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control"  placeholder="Address" id="customerAddress" name="customerAddress" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="Phone" id="customerTelephone" name="customerTelephone" required>
                                    </div>
                                    <button id="customerBtn" class="btn login-form__btn submit w-100">고객 회원가입</button>
                                </form>
                                    <p class="mt-5 login-form__footer">Have account <a href="loginForm.jsp" class="text-primary">Sign in </a> now</p>
                            		<p class="mt-5 login-form__footer"><a href="<%=request.getContextPath()%>/theme/shop.jsp" class="text-primary">Shop </a> now</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6">
                    <div class="form-input-content">
                        <div class="card login-form mb-0">
                            <div class="card-body pt-5">
                                
                                <h4>STAFF 회원가입</h4>
       							<%
				                	if(request.getParameter("errorMsg") != null){
								%>
										<span style="color:red"><%=request.getParameter("errorMsg")%></span>
				           		<%		
				                	}
				                %>
                                <!-- 직원 회원가입 -->
                                <%
                                	String employeeCkId = "";
                                	if(request.getParameter("employeeCkId") != null){
                                		employeeCkId = request.getParameter("employeeCkId");
                                	}
                                %>
                                <form class="mt-5 mb-5 login-input"  method="post" action="<%=request.getContextPath()%>/theme/sign-upAction.jsp" id="employeeForm">
                                    <input type="hidden" name="user" value="employee">
                                    <div class="form-group">
                                        <input type="text" class="form-control"  placeholder="Name" id="employeeName" name="name" required>
                                    </div>
                                    <div class="form-group">
                                    	<div class="row">
	                                    	<div class="col-sm-8">
	                                        	<input type="text" class="form-control"  placeholder="Id Check" id="employeeCkId" name="employeeCkId" required>
	                                        </div>
	                                        <div class="col-sm-4">
	                                        	<button type="button" id="employeeIdBtn" class="btn">아이디 중복검사</button>
	                                        </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control"  placeholder="Id" id="employeeId" name="id" value="<%=employeeCkId%>" readonly="readonly" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="password" class="form-control" placeholder="Password" id="employeePass" name="pass" required>
                                    </div>
                                    <p class="mt-5 login-form__footer">직원만 가입이 가능합니다</p>
                                      <hr>
                                	<p class="mt-5 login-form__footer">직원이 아니시라면 왼쪽에 '고객 회원가입'으로 가입 부탁드립니다</p>
                                	  <hr>
                                    <button id="employeeBtn" class="btn login-form__btn submit w-100">STAFF 회원가입</button>
                                </form>
                                    <p class="mt-5 login-form__footer">Have account <a href="loginForm.jsp" class="text-primary">Sign in </a> now</p>
                            		<p class="mt-5 login-form__footer"><a href="<%=request.getContextPath()%>/theme/shop.jsp" class="text-primary">Shop </a> now</p>
                                </div>
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
	// 고객 아이디 중복검사 빈칸검사
	$('#customerIdBtn').click(function(){
		if($('#customerCkId').val().length < 4){
			alert('고객아이디는 4자 이상 기입해주세요');
		} else {
			$.ajax({
				url : '/shop/signController',
				type : 'post',
				data : {customerCkId : $('#customerCkId').val()},
				success : function(json){
					// alert(json);
					if(json == 'customerCkId ok'){
						alert('사용가능한 아이디입니다');
						$('#customerId').val($('#customerCkId').val());
						$('#employeeId').val('');
						$('#employeeCkId').val('');
					} else {
						alert('이미 사용중이거나 탈퇴한 아이디입니다');
						$('#customerId').val('');
						$('#employeeId').val('');
						$('#employeeCkId').val('');
					}
				}
			});
		}
	});

	$('#customerBtn').click(function(){
		if($('#customerName').val().length < 2){
			alert('고객이름은 2자 이상 기입해주세요');
		} else if($('#customerId').val().length < 4){
			alert('고객아이디 중복검사를 해주세요');
		} else if($('#customerPass').val().length < 4){
			alert('고객비밀번호는 4자 이상 기입해주세요');
		} else if($('#customerAddress').val() == ''){
			alert('고객주소칸이 빈칸입니다')
		} else if($('#customerTelephone').val() == ''){
			alert('고객연락처칸이 빈칸입니다')
		} else {
			$('#customerForm').submit();
		}
	});
	
	// 직원 아이디 중복검사 빈칸검사
	$('#employeeIdBtn').click(function(){
		if($('#employeeCkId').val().length < 4){
			alert('직원아이디는 4자 이상 기입해주세요');
		} else {
			$.ajax({
				url : "/shop/signController",
				type : "post",
				data : {employeeCkId : $('#employeeCkId').val()},
				success : function(json){
					if(json == 'employeeCkId ok'){
						alert('사용가능한 아이디입니다');
						$('#employeeId').val($('#employeeCkId').val());
						$('#customerId').val('');
						$('#customerCkId').val('');
					} else {
						alert('이미 사용중이거나 탈퇴한 아이디입니다');
						$('#employeeCkId').val('');
						$('#customerId').val('');
						$('#customerCkId').val('');
					}
				}
			});
		}
	});

	$('#employeeBtn').click(function(){
		if($('#employeeName').val().length < 2){
			alert('직원이름은 2자 이상 기입해주세요');
		} else if($('#employeeId').val().length < 4){
			alert('직원아이디 중복검사를 해주세요');
		} else if($('#employeePass').val().length < 4){
			alert('직원비밀번호는 4자 이상 기입해주세요');
		} else {
			$('#employeeForm').submit();
		}
	});
</script>
</html>