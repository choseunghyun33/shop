<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="adminHeader.jsp"%>
	<%
       	if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
       		// 관리자가 아닌경우 막기
       		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
       		return;
       	}
		
		// 값받기
		String customerId = request.getParameter("customerId");
		// 디버깅
		System.out.println("adminUpdateCustomer.jsp customerId : " + customerId);
    %>

    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-left pt-3">
            <div class="col-lg-12 m-auto">
                <h1 class="h1">고객 비밀번호 수정</h1>
               	 <hr>
               	<form action="<%=request.getContextPath()%>/theme/admin/adminUpdateCustomerAction.jsp" method="post" id="form">
		           	<table class="table">
		           		<tr>
		           			<th>고객아이디</th>
		           			<td>
		           				<input type="text" name="customerId" id="customerId" value="<%=customerId%>" class="form-control" readonly="readonly"> 
		           			</td>
		           		</tr>
		           		<tr>
		           			<th>비밀번호 변경</th>
		           			<td>
		           				<input type="text" name="customerPass" id="customerPass" class="form-control"> 
		           			</td>
		           		</tr>
		           	</table>
		           	<button type="button" class="btn" id="btn">수정</button>
            	</form>
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->
    <script>
    	$('#btn').click(function(){
    		if($('#customerPass').val().length < 4){
    			alert('비밀번호를 4자 이상 기입해주세요');
    		} else {
    			$('#form').submit();
    		}
    	});
    </script>
<%@ include file="adminFooter.jsp"%>