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
    %>

    <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <!-- col end -->
                <div class="col-lg-12 mt-5 text-center">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">공지등록</h1>
                           	<%
                           		if(request.getParameter("errorMsg") != null){
                           	%>
                           			<span style="color:red">
                           				<%=request.getParameter("errorMsg")%>
                           			</span>
                         	<%
                           		}
                           	%>
                            	<hr>
                            	<form action="<%=request.getContextPath()%>/theme/admin/addNoticeAction.jsp" method="post" id="form">
		                            <table class="table">
					            		<tr>
					            			<th>공지제목</th>
					            			<td>
					            				<input type="text" name="noticeTitle" id="noticeTitle" class="form-control">
					            			</td>
					            		</tr>
					            		<tr>
					            			<th>공지내용</th>
					            			<td>
					            				<textarea rows="10" cols="5" name="noticeContent" id="noticeContent" class="form-control"></textarea>
					            			</td>
					            		</tr>
					            	</table> 
					            	<button type="button" class="btn btn-dark" id="btn">공지등록</button>
				            	</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Close Content -->
   	<script>
		$('#btn').click(function(){
			if($('#noticeTitle').val().length < 2){
				alert('공지제목을 2자이상 기입해주세요');
			} else if($('#noticeContent').val().length < 1){
				alert('공지내용을 기입해주세요');
			} else {
				$('#form').submit();
			}
		});
	</script>
<%@ include file="adminFooter.jsp"%>