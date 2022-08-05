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
            <div class="col-lg-12 m-auto">
                <h1 class="h1">Notice</h1>
                	<div>
	                	<form action="" method="get" class="modal-content modal-body border-0 p-0">
			                <div class="input-group mb-2">
			                    <input type="text" class="form-control" id="inputModalSearch" name="q" placeholder="Search ...">
			                    <button type="submit" class="input-group-text bg-success text-light">
			                        <i class="fa fa-fw fa-search text-white"></i>
			                    </button>
			                </div>
			            </form>
	                	<%
	                		if(session.getAttribute("id") != null && "employee".equals((String)session.getAttribute("user"))){
	           			%>
	                			<a href="<%=request.getContextPath()%>/insertNotice.jsp" class="btn">글쓰기</a>	
	           			<%	
	                		}
	                	%>
                	</div>
	            	<table class="table">
	            		<thead>
		            		<tr>
		            			<th>NO</th>
		            			<th>TITLE</th>
		            			<th>DATE</th>
		            		</tr>
	            		</thead>
	            		<tbody>
		            		<tr>
		            			<td></td>
		            			<td></td>
		            			<td></td>
		            		</tr>
	            		</tbody>
	            	</table>
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->
<%@ include file="footer.jsp"%>