<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Notice"%>
<%@ page import="service.NoticeService"%>
<%@ include file="adminHeader.jsp"%>
	<%
		// 값받기
		String noticeNo = request.getParameter("noticeNo");
	
		// noticeNo이 없다면 실행시키지 않기
		if(noticeNo == null){
			response.sendRedirect(request.getContextPath() + "/theme/admin/adminNoticeList.jsp?errorMsg=wrong path");
			return;
		}
		
		// 막기
		if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
       		// 관리자가 아닌경우 막기
       		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
       	}
	
		// notice 상세보기 할 메서드 실행하기
		// 파라미터로 넘길 paramNotice 필요
		Notice paramNotice = new Notice();
		// paramNotice setter
		paramNotice.setNoticeNo(Integer.parseInt(noticeNo));
		// 디버깅
		System.out.println("adminNoticeOne.jsp notice : " + paramNotice.toString());
		
		// 리턴받을 notice
		Notice notice = new NoticeService().getNoticeOneByNoticeNo(paramNotice);
    %>

    <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <!-- col end -->
                <div class="col-lg-12 mt-5 text-center">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">공지수정</h1>
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
                            <form action="<%=request.getContextPath()%>/theme/admin/adminUpdateNoticeAction.jsp" method="post" id="form">
	                            <table class="table">
				            		<tr>
				            			<th>공지번호</th>
				            			<td>
				            				<input type="text" name="noticeNo" id="noticeNo" value="<%=notice.getNoticeNo()%>" class="form-control" readonly="readonly">
				            			</td>
				            		</tr>
				            		<tr>
				            			<th>생성일</th>
				            			<td>
				            				<input type="text" name="createDate" id="createDate" value="<%=notice.getCreateDate()%>" class="form-control" readonly="readonly">
				            			</td>
									</tr>
									<tr>
										<th>수정일</th>
										<td>
											<input type="text" name="updateDate" id="updateDate" value="<%=notice.getUpdateDate()%>" class="form-control" readonly="readonly">	
										</td>
				            		</tr>
				            		<tr>
				            			<th>공지제목</th>
				            			<td>
				            				<input type="text" name="noticeTitle" id="noticeTitle" value="<%=notice.getNoticeTitle()%>" class="form-control">
				            			</td>
				            		</tr>
				            		<tr>
				            			<th>공지내용</th>
				            			<td>
				            				<textarea type="text" name="noticeContent" id="noticeContent" class="form-control"><%=notice.getNoticeContent()%></textarea>
				            			</td>
				            		</tr>					            		
				            	</table> 
				            	<button type="button" class="btn btn-dark" id="btn">공지수정</button>
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