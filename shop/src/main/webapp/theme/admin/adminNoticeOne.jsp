<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Notice"%>
<%@ page import="service.NoticeService"%>
<%@ include file="adminHeader.jsp"%>
	<%
		// 값받기
		String noticeNo = request.getParameter("noticeNo");
	

		// 막기
		// noticeNo이 없다면 실행시키지 않기
		if(noticeNo == null){
			response.sendRedirect(request.getContextPath() + "/theme/admin/adminNoticeList.jsp?errorMsg=wrong path");
			return;
		} else if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
       		// 관리자가 아닌경우 막기
       		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
       		return;
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
                            <h1 class="h2">공지상세보기</h1>
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
                            <table class="table">
			            		<tr>
			            			<th>공지번호</th>
			            			<td>
			            				<%=notice.getNoticeNo()%>
			            			</td>
			            		</tr>
			            		<tr>
			            			<th>생성일</th>
									<td>
										<%=notice.getCreateDate()%>
									</td>
								</tr>
								<tr>
									<th>수정일</th>
									<td>
										<%=notice.getUpdateDate()%>
									</td>
			            		</tr>
			            		<tr>
			            			<th>공지제목</th>
			            			<td>
			            				<%=notice.getNoticeTitle()%>
			            			</td>
			            		</tr>
			            		<tr>
			            			<th>공지내용</th>
			            			<td>
			            				<%=notice.getNoticeContent()%>
			            			</td>
			            		</tr>					            		
			            	</table> 
			            	<a href="<%=request.getContextPath()%>/theme/admin/adminUpdateNotice.jsp?noticeNo=<%=notice.getNoticeNo()%>" class="btn btn-dark">수정</a>
			            	<a href="<%=request.getContextPath()%>/theme/admin/adminDeleteNotice.jsp?noticeNo=<%=notice.getNoticeNo()%>" class="btn">삭제</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Close Content -->
<%@ include file="adminFooter.jsp"%>