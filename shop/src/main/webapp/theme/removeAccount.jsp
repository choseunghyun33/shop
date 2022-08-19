<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
	<%
       	if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	}
    %>
    <!-- Modal -->
    <div class="modal fade bg-white" id="templatemo_search" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="w-100 pt-1 mb-5 text-right">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" method="get" class="modal-content modal-body border-0 p-0">
                <div class="input-group mb-2">
                    <input type="text" class="form-control" id="inputModalSearch" name="q" placeholder="Search ...">
                    <button type="submit" class="input-group-text bg-success text-light">
                        <i class="fa fa-fw fa-search text-white"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>


    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">회원탈퇴</h1>
                 <p><%=session.getAttribute("user")%></p>
                   <hr>
                 <p><%=session.getAttribute("name")%></p>
                   <hr>
                 <form action="<%=request.getContextPath()%>/theme/removeAccountAction.jsp" method="post" id="form">
	                 <table class="table">
	                 	<tr>
	                 		<th>비밀번호</th>
	                 		<td>
	                 			<input type="password" name="pass" id="pass" class="form-control">
	                 		</td>
	                 	</tr>
	                 </table>
	                 <button type="button" class="btn btn-dark" id="btn">회원탈퇴</button>
                 </form>
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->
<script>
	$('#btn').click(function(){
		if($('#pass').val() < 4){
			alert('비밀번호를 4자이상 기입해주세요');
		} else {
			$('#form').submit();
		}
	});
</script>
<%@ include file="footer.jsp"%>