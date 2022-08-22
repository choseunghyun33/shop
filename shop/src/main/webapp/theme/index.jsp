<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.CounterService"%>
<%@ include file="header.jsp"%>
	<%
       	if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	}
	
		// 방문자 수 구하기
		// 총방문자
		int totalCounter = new CounterService().getTotalCount();
		// 오늘방문자
		int todayCounter = new CounterService().getTodayCount();
		// 현재방문자
		int currentCounter = (Integer)(application.getAttribute("currentCounter"));
		
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
			     <p>총 방문자 수 : <%=totalCounter%></p>
			       <hr>
			     <p>오늘 방문자 수 : <%=todayCounter%></p>
			       <hr>
			     <p>현재 방문자 수 : <%=currentCounter%></p>
			       <hr>
                 <%
			       	if("employee".equals((String)session.getAttribute("user"))){
	       		 %>
	       		 		<a href="<%=request.getContextPath()%>/theme/admin/adminIndex.jsp" class="btn btn-dark">관리자페이지</a>
	       		 <%
			       	} else {
		       	 %>
		       	 		<a href="<%=request.getContextPath()%>/theme/ordersList.jsp" class="btn btn-dark">주문리스트</a>
		       	 <%		
			       	}
			     %>
			       <hr> 
                 <a href="<%=request.getContextPath()%>/theme/removeAccount.jsp" class="btn">회원탈퇴</a>
               
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->
<%@ include file="footer.jsp"%>