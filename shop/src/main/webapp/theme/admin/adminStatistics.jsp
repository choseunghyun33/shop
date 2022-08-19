<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%@ page import="java.util.*"%>
<%@ include file="adminHeader.jsp"%>
<%
	//유효성 검정 코드
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
		return;
	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
		// 관리자가 아닌경우 막기
		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
	}	
%>
<script>
	$(document).ready(function(){
		
		let x = ["누적판매수", "누적조회수"];
		let y = [];
		
		// dept
		$.ajax({
			url : '/shop/StatisticsController/getCount',
			type : 'post',
			success : function(json){
				$(json).each(function(index, item){
					y.push(item.sum);
					y.push(item.hit);
				});
				
				
				var ctx = document.getElementById("singelBarChart1");
			    ctx.height = 150;
			    var myChart = new Chart(ctx, {
			        type: 'bar',
			        data: {
			            labels: x,
			            datasets: [
			                {
			                    label: "누적 합계",
			                    data: y,
			                    borderColor: "rgba(117, 113, 249, 0.9)",
			                    borderWidth: "0",
			                    backgroundColor: "rgba(117, 113, 249, 0.5)"
			                }
			            ]
			        },
			        options: {
			            scales: {
			                yAxes: [{
			                    ticks: {
			                        beginAtZero: true
			                    }
			                }]
			            }
			        }
			    });
			
			}
		}); // 우선순위가 없다.
	}); // body를 읽고 나서 실행시켜주세요
</script>
<!-- 분리하면 servlet / 중계기술(forword - 겹친다, 덮어쓴다(request - 세션과 같이 저장할 수 있다 차이점 이 jsp가 끝나면 저장된것이 사라진다 또 forword 하지 않는 이상, response)) / jsp -->

<!-- 태그 -->

	<!-- for / if : java -- 대체기술 : 커스텀태그(JSTL & EL) -- jsp(전용뷰가 아님 서블릿이랑 같은 것) 사용  -->

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



    <!-- Start Content -->
    <div class="container py-5">
        <div class="row">
			<!-- 사이드바 -->
            <div class="col-lg-2">
                <h1 class="h2 pb-4">통계</h1>
                <ul class="list-unstyled templatemo-accordion">
                    <li class="pb-3">
                        <a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
                            판매수<i class="fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
                        <ul class="collapse show list-unstyled pl-3">
                            <li><a class="text-decoration-none" href="#">총 누적판매수</a></li>
                            <li><a class="text-decoration-none" href="#">년도별 판매수</a></li>
                            <li><a class="text-decoration-none" href="#">월별 판매수</a></li>
                        </ul>
                    </li>
                   	<li class="pb-3">
                        <a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
                            조회수<i class="fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
                        <ul class="collapse show list-unstyled pl-3">
                            <li><a class="text-decoration-none" href="#">총 조회수</a></li>
                            <li><a class="text-decoration-none" href="#">년도별 조회수</a></li>
                            <li><a class="text-decoration-none" href="#">월별 조회수</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- end 사이드바 -->
            

			<!-- chart -->	
			<div class="col-lg-10">
				<div class="card">
                     <div class="card-body">
                         <h4 class="card-title">총 누적판매수 / 누적조회수</h4>
                         <canvas id="singelBarChart1" width="500" height="250"></canvas>
                     </div>
                </div>
			</div>	
		</div>		
    </div>
    <!-- End Content -->
<%@ include file="adminFooter.jsp"%>