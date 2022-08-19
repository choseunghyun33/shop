<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%@ page import="vo.Cart"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ include file="header.jsp"%>
<%
	// 세션안에 있는 카트를 가져와서 보기
	Cart cart = (Cart)session.getAttribute("cart");
	//메서드를 위한 객체생성
	GoodsService goodsService = new GoodsService();
	
	// 부족한 값 가져오기
	Map<String, Object> map = goodsService.getGoodsAndImgOne(cart.getGoodsNo());
	// 디버깅
	System.out.println("buyList.jsp map : " + map.toString());
	
	// 원래 가지고 있던 주소 가져오기
	CustomerService customerService = new CustomerService();
	
	String customerAddr = customerService.getCustomerAddrById(cart.getCustomerId());
	
%>

    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-12 m-auto">
                <h1 class="h1">주문/결제</h1>
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
		            			<th>상품번호</th>
		            			<th>상품명</th>
		            			<th>수량</th>
		            			<th>가격</th>
		            		</tr>
	            		</thead>
	            		<tbody>
	            			<tr>
		            			<td><%=cart.getGoodsNo()%></td>
		            			<td><%=map.get("goodsName")%></td>
		            			<td><%=cart.getCartQuantity()%></td>
		            			<td><%=map.get("goodsPrice")%>원</td>
		            		</tr>
	            		</tbody>
	            	</table>
  					 <hr>
  					<form action="<%=request.getContextPath()%>/theme/buyAction.jsp" method="post" id="form">
  						<input type="hidden" name="orderPrice" value="<%=map.get("goodsPrice")%>"> 
	  					<table class="table">	
	  						<tr>
	  							<th>주소</th>
	  							<td>
	  								<div class="row">
	  									<div class="col-lg-10">
										<input type="text" name="orderAddr" id="orderAddr" value="<%=customerAddr%>" readonly="readonly" class="form-control">
										</div>
										<div class="col-lg-2">
											<button type="button" id="addrBtn" class="btn btn-dark">주소검색</button>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th>상세주소</th>
								<td>
									<input type="text" name="orderDetailAddr" id="orderDetailAddr" class="form-control">
								</td>
							</tr>
						</table>
						<button type="button" class="btn btn-dark" id="btn">주문</button>
					</form>
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->

<script>
	$('#btn').click(function(){
		if($('#orderAddr').val() == ''){
			alert('주소검색을 해주세요');
		} else if($('#orderDetailAddr').val() == ''){
			alert('상세주소를 기입해주세요')
		} else {
			$('#form').submit();
		}
	});
</script>

<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script>
	$('#addrBtn').click(function(){
		sample2_execDaumPostcode();
	});
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    // document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                // document.getElementById('sample2_postcode').value = data.zonecode;
                // document.getElementById("sample2_address").value = addr;
                
                // $('#addr').val(data.zonecode + ' ' + addr);
                document.getElementById('orderAddr').value = data.zonecode + ' ' + addr;
                
                // 커서를 상세주소 필드로 이동한다.
                // document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
<%@ include file="footer.jsp"%>