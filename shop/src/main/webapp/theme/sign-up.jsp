<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="h-100" lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Sign up</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link href="css/style.css" rel="stylesheet">
    
</head>

<body class="h-100">
    
    <!--*******************
        Preloader start
    ********************-->
    <div id="preloader">
        <div class="loader">
            <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
            </svg>
        </div>
    </div>
    <!--*******************
        Preloader end
    ********************-->
	<%
		// 막기
		if(session.getAttribute("id") != null){
			response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=wrong Path");
			return;
		}
	%>

    <div class="login-form-bg h-100">
        <div class="container h-100">
            <div class="row justify-content-center h-100">
                <div class="col-xl-6">
                    <div class="form-input-content">
                        <div class="card login-form mb-0">
                            <div class="card-body pt-5">
                                
                                <h4>고객 회원가입</h4>
        						<%
				                	if(request.getParameter("errorMsg") != null){
								%>
										<span style="color:red"><%=request.getParameter("errorMsg")%></span>
				           		<%		
				                	}
				                %>
                                <!-- 고객 회원가입 -->
                                <%
                                	String customerCkId = "";
                                	if(request.getParameter("customerCkId") != null){
                                		customerCkId = request.getParameter("customerCkId");
                                	}
                                %>
                                <form class="mt-5 mb-5 login-input" method="post" action="<%=request.getContextPath()%>/theme/sign-upAction.jsp" id="customerForm">
                                	<input type="hidden" name="user" value="customer">
                                    <div class="form-group">
                                        <input type="text" class="form-control"  placeholder="Name" id="customerName" name="name" required>
                                    </div>
                                    <div class="form-group">
                                    	<div class="row">
	                                    	<div class="col-sm-8">
	                                        	<input type="text" class="form-control"  placeholder="Id Check" id="customerCkId" name="customerCkId" value="<%=customerCkId%>" required>
	                                        </div>
	                                        <div class="col-sm-4">
	                                        	<button type="button" id="customerIdBtn" class="btn">아이디 중복검사</button>
	                                        </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control"  placeholder="Id" id="customerId" name="id" value="<%=customerCkId%>" readonly="readonly" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="password" class="form-control" placeholder="Password" id="customerPass" name="pass" required>
                                    </div>
                                    <div class="form-group">
                                    	<div class="row">
	                                    	<div class="col-sm-9">
                                        		<input type="text" class="form-control"  placeholder="Address" id="customerAddress" name="customerAddress" required>
                                    		</div>
                                    		<div class="col-sm-3">
                                    			<button type="button" id="addrBtn" class="btn">주소검색</button>
                                    		</div>
                                    	</div>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control"  placeholder="Detail Address" id="customerDetailAddress" name="customerDetailAddress" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="Phone" id="customerTelephone" name="customerTelephone" required>
                                    </div>
                                    <button id="customerBtn" class="btn login-form__btn submit w-100">고객 회원가입</button>
                                </form>
                                    <p class="mt-5 login-form__footer">Have account <a href="loginForm.jsp" class="text-primary">Sign in </a> now</p>
                            		<p class="mt-5 login-form__footer"><a href="<%=request.getContextPath()%>/theme/shop.jsp" class="text-primary">Shop </a> now</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6">
                    <div class="form-input-content">
                        <div class="card login-form mb-0">
                            <div class="card-body pt-5">
                                
                                <h4>STAFF 회원가입</h4>
       							<%
				                	if(request.getParameter("errorMsg") != null){
								%>
										<span style="color:red"><%=request.getParameter("errorMsg")%></span>
				           		<%		
				                	}
				                %>
                                <!-- 직원 회원가입 -->
                                <%
                                	String employeeCkId = "";
                                	if(request.getParameter("employeeCkId") != null){
                                		employeeCkId = request.getParameter("employeeCkId");
                                	}
                                %>
                                <form class="mt-5 mb-5 login-input"  method="post" action="<%=request.getContextPath()%>/theme/sign-upAction.jsp" id="employeeForm">
                                    <input type="hidden" name="user" value="employee">
                                    <div class="form-group">
                                        <input type="text" class="form-control"  placeholder="Name" id="employeeName" name="name" required>
                                    </div>
                                    <div class="form-group">
                                    	<div class="row">
	                                    	<div class="col-sm-8">
	                                        	<input type="text" class="form-control"  placeholder="Id Check" id="employeeCkId" name="employeeCkId" required>
	                                        </div>
	                                        <div class="col-sm-4">
	                                        	<button type="button" id="employeeIdBtn" class="btn">아이디 중복검사</button>
	                                        </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control"  placeholder="Id" id="employeeId" name="id" value="<%=employeeCkId%>" readonly="readonly" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="password" class="form-control" placeholder="Password" id="employeePass" name="pass" required>
                                    </div>
                                      <hr>
                                    <p class="mt-5 login-form__footer">직원만 가입이 가능합니다</p>
                                	<p class="mt-5 login-form__footer">직원이 아니시라면 왼쪽에 '고객 회원가입'으로 가입 부탁드립니다</p>
                                      <br>
                                      <hr>
                                      <br>
                                    <button id="employeeBtn" class="btn login-form__btn submit w-100">STAFF 회원가입</button>
                                </form>
                                    <p class="mt-5 login-form__footer">Have account <a href="loginForm.jsp" class="text-primary">Sign in </a> now</p>
                            		<p class="mt-5 login-form__footer"><a href="<%=request.getContextPath()%>/theme/shop.jsp" class="text-primary">Shop </a> now</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    

    

    <!--**********************************
        Scripts
    ***********************************-->
    <script src="plugins/common/common.min.js"></script>
    <script src="js/custom.min.js"></script>
    <script src="js/settings.js"></script>
    <script src="js/gleek.js"></script>
    <script src="js/styleSwitcher.js"></script>
</body>
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
                document.getElementById('customerAddress').value = data.zonecode + ' ' + addr;
                
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

<script>
	// 고객 아이디 중복검사 빈칸검사
	$('#customerIdBtn').click(function(){
		if($('#customerCkId').val().length < 4){
			alert('고객아이디는 4자 이상 기입해주세요');
		} else {
			$.ajax({
				url : '/shop/signController',
				type : 'post',
				data : {customerCkId : $('#customerCkId').val()},
				success : function(json){
					// alert(json);
					if(json == 'customerCkId ok'){
						alert('사용가능한 아이디입니다');
						$('#customerId').val($('#customerCkId').val());
						$('#employeeId').val('');
						$('#employeeCkId').val('');
					} else {
						alert('이미 사용중이거나 탈퇴한 아이디입니다');
						$('#customerId').val('');
						$('#employeeId').val('');
						$('#employeeCkId').val('');
					}
				}
			});
		}
	});

	$('#customerBtn').click(function(){
		if($('#customerName').val().length < 2){
			alert('고객이름은 2자 이상 기입해주세요');
		} else if($('#customerId').val().length < 4){
			alert('고객아이디 중복검사를 해주세요');
		} else if($('#customerPass').val().length < 4){
			alert('고객비밀번호는 4자 이상 기입해주세요');
		} else if($('#customerAddress').val() == ''){
			alert('고객주소칸이 빈칸입니다')
		} else if($('#customerDetailAddress').val() == ''){
			alert('고객상세주소칸이 빈칸입니다')
		} else if($('#customerTelephone').val() == ''){
			alert('고객연락처칸이 빈칸입니다')
		} else {
			$('#customerForm').submit();
		}
	});
	
	// 직원 아이디 중복검사 빈칸검사
	$('#employeeIdBtn').click(function(){
		if($('#employeeCkId').val().length < 4){
			alert('직원아이디는 4자 이상 기입해주세요');
		} else {
			$.ajax({
				url : "/shop/signController",
				type : "post",
				data : {employeeCkId : $('#employeeCkId').val()},
				success : function(json){
					if(json == 'employeeCkId ok'){
						alert('사용가능한 아이디입니다');
						$('#employeeId').val($('#employeeCkId').val());
						$('#customerId').val('');
						$('#customerCkId').val('');
					} else {
						alert('이미 사용중이거나 탈퇴한 아이디입니다');
						$('#employeeCkId').val('');
						$('#customerId').val('');
						$('#customerCkId').val('');
					}
				}
			});
		}
	});

	$('#employeeBtn').click(function(){
		if($('#employeeName').val().length < 2){
			alert('직원이름은 2자 이상 기입해주세요');
		} else if($('#employeeId').val().length < 4){
			alert('직원아이디 중복검사를 해주세요');
		} else if($('#employeePass').val().length < 4){
			alert('직원비밀번호는 4자 이상 기입해주세요');
		} else {
			$('#employeeForm').submit();
		}
	});
</script>
</html>