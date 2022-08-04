<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<%	
		// 막기
		if(session.getAttribute("id") != null){
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
	%>
	<div>
		<form action="<%=request.getContextPath()%>/customerLoginAction.jsp" method="post" id="customerForm">
			<fieldset>
				<legend>쇼핑몰 고객 로그인</legend>
				<table border="1">
					<tr>
						<td>ID</td>
						<td>
							<input type="text" name="customerId" id="customerId">
						</td>
					</tr>
					<tr>
						<td>PW</td>
						<td>
							<input type="password" name="customerPass" id="customerPass">
						</td>
					</tr>
				</table>
				<button type="button" id="customerBtn">고객 로그인</button>
			</fieldset>
		</form>
	</div>
	<!-- 쇼핑몰 고객 로그인 끝 -->
	<div>
		<form action="<%=request.getContextPath()%>/employeeLoginAction.jsp" method="post" id="employeeForm">
			<fieldset>
				<legend>쇼핑몰 스텝 로그인</legend>
				<table border="1">
					<tr>
						<td>ID</td>
						<td>
							<input type="text" name="employeeId" id="employeeId">
						</td>
					</tr>
					<tr>
						<td>PW</td>
						<td>
							<input type="password" name="employeePass" id="employeePass">
						</td>
					</tr>
				</table>
				<button type="button" id="employeeBtn">스텝 로그인</button>
			</fieldset>
		</form>
	</div>
	<!-- 쇼핑몰 스탭 로그인 끝 -->
</body>
<script>
	// 함수만드는 법
	// 1. let test = function(){}
	// 2. function test(){}
	
	// 고객 빈칸검사
	$('#customerBtn').click(function(){
		if($('#customerId').val() == ''){
			alert('고객아이디를 입력하세요');
		} else if($('#customerPass').val() == '') {
			alert('고객패스워드를 입력하세요');
		} else {
			$('#customerForm').submit();
		}
	});
	// 스텝 빈칸검사
	$('#employeeBtn').click(function(){
		if($('#employeeId').val() == ''){
			alert('고객아이디를 입력하세요');
		} else if($('#employeePass').val() == '') {
			alert('고객패스워드를 입력하세요');
		} else {
			$('#employeeForm').submit();
		}
	});
</script>
</html>