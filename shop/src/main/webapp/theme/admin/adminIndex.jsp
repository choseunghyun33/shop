<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="adminHeader.jsp"%>
	<%
		// 유효성 검정 코드
       	if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
       		// 관리자가 아닌경우 막기
       		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
    		return;
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
                 				<a href="<%=request.getContextPath()%>/theme/admin/adminEmployeeList.jsp" class="btn">사원관리</a>
                 			</td>
                 		</tr>
                 		<tr>
                 			<td>
                 				<a href="<%=request.getContextPath()%>/theme/admin/adminGoodsList.jsp" class="btn">상품관리</a><!-- 상품목록/등록/수정(품절)/삭제(장바구니,주문이 없는 경우) -->
                 			</td>
                 		</tr>
                 		<tr>
                 			<td>
                 				<a href="<%=request.getContextPath()%>/theme/admin/adminOrdersList.jsp" class="btn">주문관리</a><!-- 주문목록/수정 -->
                 			</td>
                 		</tr>
                 		<tr>
                 			<td>
                 				<a href="<%=request.getContextPath()%>/theme/admin/adminCustomerList.jsp" class="btn">고객관리</a><!-- 고객목록/강제탈퇴/비밀번호수정(전달구현X) -->
                 			</td>
                 		</tr>
                 		<tr>
                 			<td>
                 				<a href="<%=request.getContextPath()%>/theme/admin/adminNoticeList.jsp" class="btn">공지관리</a><!-- 공지 CRUD -->
                 			</td>
                 		</tr>
                 		<tr>
                 			<td>
                 				<a href="<%=request.getContextPath()%>/theme/admin/adminStatistics.jsp" class="btn">통계</a>
                 			</td>
                 		</tr>
                 	</tbody>
                 </table>
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->
<%@ include file="adminFooter.jsp"%>