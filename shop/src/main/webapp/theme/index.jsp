<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
	<%
       	if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	}
    %>

    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1"><%=session.getAttribute("id")%>님 반갑습니다</h1>
                <%
                	if(request.getParameter("errorMsg") != null){
				%>
						<span style="color:red"><%=request.getParameter("errorMsg")%></span>
           		<%		
                	}
                %>   
                 <p><%=session.getAttribute("user")%></p>
                   <hr>
                 <p><%=session.getAttribute("name")%></p>
                   <hr>
                 <a href="<%=request.getContextPath()%>/theme/removeAccount.jsp" class="btn">회원탈퇴</a>
                 <%
			       	if("employee".equals((String)session.getAttribute("user"))){
	       		 %>
	       		 		<a href="<%=request.getContextPath()%>/theme/employeeIndex.jsp" class="btn">관리자관리페이지</a>
	       		 <%
			       	}
			     %>
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->
<%@ include file="footer.jsp"%>