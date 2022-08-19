<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.EmployeeService"%>
<%@ page import="vo.Employee"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ include file="adminHeader.jsp"%>
	<%
       	if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
       		// 관리자가 아닌경우 막기
       		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
       	}
	
		// 페이징
		int currentPage = 1; // 현재페이지
		final int ROW_PER_PAGE = 10; // 묶음

		if(request.getParameter("currentPage") != null){
			// 받아오는 페이지가 있다면 현재페이지변수에 담기
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 메서드를 위한 객체생성
		EmployeeService employeeService = new EmployeeService();
		
		// 마지막페이지 구하는 메서드
		int lastPage = employeeService.lastPage(ROW_PER_PAGE);
		

		// 숫자페이징
		int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1; // 시작페이지값 ex) ROW_PER_PAGE 가 10 일경우 1, 11, 21, 31
		int endPage = startPage + ROW_PER_PAGE - 1; // 끝페이지값 ex) ROW_PER_PAGE 가 10 일경우 10, 20, 30, 40
		// endPage 는 lastPage보다 크면 안된다
		endPage = Math.min(endPage, lastPage); // 두 값의 최소값이 endPage가 된다
		
		
		// 리스트
		List<Employee> list = employeeService.getEmployeeList(ROW_PER_PAGE, currentPage);
		
		
    %>

    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-12 m-auto">
                <h1 class="h1">사원관리</h1>
                <%
                	if(request.getParameter("errorMsg") != null){
				%>
						<span style="color:red"><%=request.getParameter("errorMsg")%></span>
           		<%		
                	}
                %>  
                	 <hr>
	            	<table class="table">
	            		<thead>
		            		<tr>
		            			<th>사원아이디</th>
		            			<th>사원이름</th>
		            			<th>입사날짜</th>
		            			<th>정보수정날짜</th>
		            			<th>권한부여</th>
		            		</tr>
	            		</thead>
	            		<tbody>
		            		<%
		            			for(Employee e : list){
		            		%>
				            		<tr>
				            			<td><%=e.getEmployeeId()%></td>
				            			<td><%=e.getEmployeeName()%></td>
				            			<td><%=e.getCreateDate()%></td>
				            			<td><%=e.getUpdateDate()%></td>
				            			<td>
				            				<form action="<%=request.getContextPath()%>/theme/admin/updateActive.jsp" method="post">
				            					<input type="hidden" name="employeeId" value="<%=e.getEmployeeId()%>">
				            					<select name="active">
				            						<%
				            							if("Y".equals(e.getActive())) {
				            						%>
						            						<option value="Y">Y</option>
						            						<option value="N">N</option>
				            						<%
				            							} else {
				            						%>
						            						<option value="N">N</option>
					            							<option value="Y">Y</option>
				            						<%
				            							}
				            						%>
				            					</select>
				            					<button type="submit" class="btn btn-dark">권한변경</button> 
				            				</form>
				            			</td>
				            		</tr>
			            	<%
		            			}
		            		%>
	            		</tbody>
	            	</table>
            	<div class="row">
                    <ul class="pagination pagination-lg justify-content-center">
	            	<%
	            		if(currentPage > 1){
	            	%>
		            		 <li class="page-item">
	                            <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminEmployeeList.jsp?currentPage=<%=currentPage-1%>">pre</a>
	                         </li>	
	            	<%
	            		}
                    	
                    	// 숫자페이징
                    	for(int i = startPage; i <= endPage; i++){
                    		if(i == currentPage){
		            %>
		            			<li class="page-item disabled">
		            				 <a class="page-link active rounded-0 mr-3 shadow-sm border-top-0 border-left-0" href="<%=request.getContextPath()%>/theme/admin/adminEmployeeList.jsp?currentPage=<%=i%>"><%=i%></a>
		            			</li>
	            	<%
                    		} else {
                	%>
		            			<li class="page-item">
		            				 <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminEmployeeList.jsp?currentPage=<%=i%>"><%=i%></a>
		            			</li>
	            	<%			
                    		}
                    	}
                    	
	            		if(currentPage < lastPage){
	            	%>
	                        <li class="page-item">
	                            <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="<%=request.getContextPath()%>/theme/admin/adminEmployeeList.jsp?currentPage=<%=currentPage+1%>">next</a>
	                        </li>
                    <%
	            		}
	            	%>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->
<%@ include file="adminFooter.jsp"%>