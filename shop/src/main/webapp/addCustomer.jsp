<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- id ck form -->
	<form action="<%=request.getContextPath()%>/idCheckAction.jsp" method="post">
		<div>
			ID 체크
			<input type="text" name="ckid">
			<button type="submit">아이디 중복 검사</button>
		</div>
	</form>
	<!-- 고객가입 form -->
	<%
		String ckId = "";
		if(request.getParameter("ckId") != null){
			ckId = request.getParameter("ckId");
		}
	%>
	<form action="<%=request.getContextPath()%>/idCheckAction.jsp" method="post">
		<div>
			<table border="1">
				<tr>
					<td>customerId</td>
					<td>
						<input type="text" name="customerId" id="customerId" readonly="readonly" value="<%=ckId%>">
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>