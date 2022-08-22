<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Notice"%>
<%@ page import="service.NoticeService"%>
<%@ include file="header.jsp"%>
	<%
		// 값받기
		String noticeNo = request.getParameter("noticeNo");
	
		// noticeNo이 없다면 실행시키지 않기
		if(noticeNo == null){
			response.sendRedirect(request.getContextPath() + "/theme/noticeList.jsp?errorMsg=wrong path");
			return;
		}
		
		// 막기
		if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	}
	
		// notice 상세보기 할 메서드 실행하기
		// 파라미터로 넘길 paramNotice 필요
		Notice paramNotice = new Notice();
		// paramNotice setter
		paramNotice.setNoticeNo(Integer.parseInt(noticeNo));
		// 디버깅
		System.out.println("noticeOne.jsp notice : " + paramNotice.toString());
		
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
			             </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Close Content -->
<%@ include file="footer.jsp"%>