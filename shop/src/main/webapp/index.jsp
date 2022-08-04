<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>
	<%	
		// 막기
		if(session.getAttribute("id") == null){
			response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
			return;
		}
	%>
	<%=session.getAttribute("user")%><!-- customer / employee -->
	<br>
	<%=session.getAttribute("id")%><!-- id -->
	<br>
	<%=session.getAttribute("name")%><!-- name -->
	
	<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
</body>
</html>