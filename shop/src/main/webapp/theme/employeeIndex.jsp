<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
	<%
       	if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
       		// 관리자가 아닌경우 막기
       		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
       	}
    %>
    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1"><%=session.getAttribute("id")%>님 관리자페이지</h1>
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
                 <table class="table">
                 	<thead>
                 		<tr>
                 			<th>관리항목</th>
                 		</tr>
                 	</thead>
                 	<tbody>
                 		<tr>
                 			<td>
                 				<a href="<%=request.getContextPath()%>/theme/employeeList.jsp" class="btn">사원관리</a>
                 			</td>
                 		</tr>
                 	</tbody>
                 </table>
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->
<%@ include file="footer.jsp"%>