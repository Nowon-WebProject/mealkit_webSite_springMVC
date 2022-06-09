<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% String addr = (String)session.getAttribute("addr");

String postcode = addr.substring(1,6);
String addr1 = addr.substring(8,addr.lastIndexOf(","));
String addr2 = addr.substring(addr.lastIndexOf(",")+2);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 주문</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="js/member.js"></script>
<script type="text/javascript">



function setDisplay(){
    if($('input:radio[id=deli2]').is(':checked')){
        $('#divId').hide();
		$("input:text[name=deli_pwd]").val("");
    }else{
        $('#divId').show();
    }
}
function modalDisplay1(){
        $('#recent').hide();
        $('#manage').show();
}
function modalDisplay2(){
        $('#manage').hide();
        $('#recent').show();
}

$(document).ready(function(){
	  $("input:radio[name=addrCheck]").click(function(){
	    if($("input[name=addrCheck]:checked").val() == "0"){
			$("input:text[name=deli_name]").val("<%=session.getAttribute("name")%>");
			$("input:text[name=deli_name]").attr("readonly",true);
			$("input:text[name=deli_postcode]").val("<%=postcode%>");
			$("input:text[name=deli_postcode]").attr("readonly",true);
			$("input:text[name=deli_addr1]").val("<%=addr1%>");
			$("input:text[name=deli_addr1]").attr("readonly",true);
			$("input:text[name=deli_addr2]").val("<%=addr2%>");
			$("input:text[name=deli_addr2]").attr("readonly",true);
			$("input:text[name=deli_phone]").val("<%=session.getAttribute("phone")%>");
			$("input:text[name=deli_phone]").attr("readonly",true);
			$("input:text[name=deli_msg]").val("");
			$("input:text[name=deli_pwd]").val("");
			
		  const target = document.getElementById('daumPostCode');
		  target.disabled = true;
		  
			
	    } else if($("input[name=addrCheck]:checked").val() == "1"){
			$("input:text[name=deli_name]").val("");
			$("input:text[name=deli_name]").attr("readonly",false);	      
			$("input:text[name=deli_postcode]").val("");
			$("input:text[name=deli_postcode]").attr("readonly",false);	      
			$("input:text[name=deli_addr1]").val("");
			$("input:text[name=deli_addr1]").attr("readonly",false);	      
			$("input:text[name=deli_addr2]").val("");
			$("input:text[name=deli_addr2]").attr("readonly",false);	      
			$("input:text[name=deli_phone]").val("");
			$("input:text[name=deli_phone]").attr("readonly",false);	 
			$("input:text[name=deli_msg]").val("");
			$("input:text[name=deli_pwd]").val("");
		  const target = document.getElementById('daumPostCode');
		  target.disabled = false;
		  
	    }
	  });
	});
	
// 페이지 로드시 사용할 포인트, 최종금액 표시되게끔. 이게 없으면 빈칸으로 나타나고, 
// 아래에 있는 keyup 이벤트가 활성화돼야 그때 값이 들어감
$( document ).ready( function() {
	var a = $( '#a' ).val();
    var b = $( '#usePoint' ).val();

    var ab = a - b + 3000;
    $( '#ab' ).text( ab.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') );
    $( '#usePointResult' ).text( b.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') );
    } );
 
$( document ).ready( function() {
    $( '#a, #usePoint' ).keyup ( function() {
      var a = Number($( '#a' ).val());
      var b = $( '#usePoint' ).val();
		var message = "";
	      if(a<b){
	  	 	b = a;
	  	 	message = "상품 가격보다 클 수 없습니다.";
	        }
	     	if(<%=session.getAttribute("point")%>< b) {
				b =<%=session.getAttribute("point")%>;
				message = "";
			}
	     	var ab = (a - b + 3000);
			$('#ab').text(ab.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			$("#usePoint").val(b);
			$('#usePointResult').text(b.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			$('#message').text(message);
		});
	});

function allPoint() {
	$("#usePoint").val(<%=session.getAttribute("point")%>);
	$( document ).ready( function() {
		var a = Number($( '#a' ).val());
		var b = $( '#usePoint' ).val();
		var message = "";
		
		if(a<b){
			b = a;
		    message = "상품 가격보다 클 수 없어 최대치를 입력합니다.";
		}
		
		var ab = a - b + 3000;
		$( '#ab' ).text( ab.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') );
		$("#usePoint").val(b);
		$( '#usePointResult' ).text( b.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') );
 		$( '#message' ).text( message );
 		
	});
}
function selectAddr(i){
	if(i == 0){
		var addr = "${alist[0].deli_addr}";
		var postcode = addr.substr(1,5);
		var startIndex1 = addr.indexOf(")")+2;
		var endIndex1 = addr.indexOf(",");	
		var addr1 = addr.substring(startIndex1, endIndex1);
		var startIndex2 = addr.indexOf(",")+2;
		var addr2 = addr.substring(startIndex2);
		$("input:text[name=deli_name]").val("${alist[0].deli_name}");
		$("input:text[name=deli_postcode]").val(postcode);
		$("input:text[name=deli_addr1]").val(addr1);
		$("input:text[name=deli_addr2]").val(addr2);
		$("input:text[name=deli_phone]").val("${alist[0].deli_phone}");
		$("input:text[name=deli_msg]").val("${alist[0].deli_msg}");
		$("input:text[name=deli_pwd]").val("${alist[0].deli_pwd}");
	} else if(i == 1){
		var addr = "${alist[1].deli_addr}";
		var postcode = addr.substr(1,5);
		var startIndex1 = addr.indexOf(")")+2;
		var endIndex1 = addr.indexOf(",");	
		var addr1 = addr.substring(startIndex1, endIndex1);
		var startIndex2 = addr.indexOf(",")+2;
		var addr2 = addr.substring(startIndex2);
		$("input:text[name=deli_name]").val("${alist[1].deli_name}");
		$("input:text[name=deli_postcode]").val(postcode);
		$("input:text[name=deli_addr1]").val(addr1);
		$("input:text[name=deli_addr2]").val(addr2);
		$("input:text[name=deli_phone]").val("${alist[1].deli_phone}");
		$("input:text[name=deli_msg]").val("${alist[1].deli_msg}");
		$("input:text[name=deli_pwd]").val("${alist[1].deli_pwd}");
	}else if(i == 2){
		var addr = "${alist[2].deli_addr}";
		var postcode = addr.substr(1,5);
		var startIndex1 = addr.indexOf(")")+2;
		var endIndex1 = addr.indexOf(",");	
		var addr1 = addr.substring(startIndex1, endIndex1);
		var startIndex2 = addr.indexOf(",")+2;
		var addr2 = addr.substring(startIndex2);
		$("input:text[name=deli_name]").val("${alist[2].deli_name}");
		$("input:text[name=deli_postcode]").val(postcode);
		$("input:text[name=deli_addr1]").val(addr1);
		$("input:text[name=deli_addr2]").val(addr2);
		$("input:text[name=deli_phone]").val("${alist[2].deli_phone}");
		$("input:text[name=deli_msg]").val("${alist[2].deli_msg}");
		$("input:text[name=deli_pwd]").val("${alist[2].deli_pwd}");
	}else if(i == 3){
		var addr = "${alist[3].deli_addr}";
		var postcode = addr.substr(1,5);
		var startIndex1 = addr.indexOf(")")+2;
		var endIndex1 = addr.indexOf(",");	
		var addr1 = addr.substring(startIndex1, endIndex1);
		var startIndex2 = addr.indexOf(",")+2;
		var addr2 = addr.substring(startIndex2);
		$("input:text[name=deli_name]").val("${alist[3].deli_name}");
		$("input:text[name=deli_postcode]").val(postcode);
		$("input:text[name=deli_addr1]").val(addr1);
		$("input:text[name=deli_addr2]").val(addr2);
		$("input:text[name=deli_phone]").val("${alist[3].deli_phone}");
		$("input:text[name=deli_msg]").val("${alist[3].deli_msg}");
		$("input:text[name=deli_pwd]").val("${alist[3].deli_pwd}");
	}else if(i == 4){
		var addr = "${alist[4].deli_addr}";
		var postcode = addr.substr(1,5);
		var startIndex1 = addr.indexOf(")")+2;
		var endIndex1 = addr.indexOf(",");	
		var addr1 = addr.substring(startIndex1, endIndex1);
		var startIndex2 = addr.indexOf(",")+2;
		var addr2 = addr.substring(startIndex2);
		$("input:text[name=deli_name]").val("${alist[4].deli_name}");
		$("input:text[name=deli_postcode]").val(postcode);
		$("input:text[name=deli_addr1]").val(addr1);
		$("input:text[name=deli_addr2]").val(addr2);
		$("input:text[name=deli_phone]").val("${alist[4].deli_phone}");
		$("input:text[name=deli_msg]").val("${alist[4].deli_msg}");
		$("input:text[name=deli_pwd]").val("${alist[4].deli_pwd}");
	}
	modal.classList.toggle('show');
	body.style.overflow = 'auto'
}

function selectMyAddr(i){
	if(i == 0){
	var name = manage.document.getElementById('name_0').value;
	$("input:text[name=deli_name]").val(name);
	var addr = manage.document.getElementById('addr_0').value;
	var postcode = addr.substr(1,5);
	var startIndex1 = addr.indexOf(")")+2;
	var endIndex1 = addr.indexOf(",");	
	var addr1 = addr.substring(startIndex1, endIndex1);
	var startIndex2 = addr.indexOf(",")+2;
	var addr2 = addr.substring(startIndex2);
	var phone = manage.document.getElementById('phone_0').value;
	var msg = manage.document.getElementById('msg_0').value;
	var pwd = manage.document.getElementById('pwd_0').value;
	$("input:text[name=deli_postcode]").val(postcode);
	$("input:text[name=deli_addr1]").val(addr1);
	$("input:text[name=deli_addr2]").val(addr2);
	$("input:text[name=deli_phone]").val(phone);
	$("input:text[name=deli_msg]").val(msg);
	$("input:text[name=deli_pwd]").val(pwd);
	} else if(i == 1){
	var name = manage.document.getElementById('name_1').value;
	$("input:text[name=deli_name]").val(name);
	var addr = manage.document.getElementById('addr_1').value;
	var postcode = addr.substr(1,5);
	var startIndex1 = addr.indexOf(")")+2;
	var endIndex1 = addr.indexOf(",");	
	var addr1 = addr.substring(startIndex1, endIndex1);
	var startIndex2 = addr.indexOf(",")+2;
	var addr2 = addr.substring(startIndex2);
	var phone = manage.document.getElementById('phone_1').value;
	var msg = manage.document.getElementById('msg_1').value;
	var pwd = manage.document.getElementById('pwd_1').value;
	$("input:text[name=deli_postcode]").val(postcode);
	$("input:text[name=deli_addr1]").val(addr1);
	$("input:text[name=deli_addr2]").val(addr2);
	$("input:text[name=deli_phone]").val(phone);
	$("input:text[name=deli_msg]").val(msg);
	$("input:text[name=deli_pwd]").val(pwd);
	} else if(i == 2){
	var name = manage.document.getElementById('name_2').value;
	$("input:text[name=deli_name]").val(name);
	var addr = manage.document.getElementById('addr_2').value;
	var postcode = addr.substr(1,5);
	var startIndex1 = addr.indexOf(")")+2;
	var endIndex1 = addr.indexOf(",");	
	var addr1 = addr.substring(startIndex1, endIndex1);
	var startIndex2 = addr.indexOf(",")+2;
	var addr2 = addr.substring(startIndex2);
	var phone = manage.document.getElementById('phone_2').value;
	var msg = manage.document.getElementById('msg_2').value;
	var pwd = manage.document.getElementById('pwd_2').value;
	$("input:text[name=deli_postcode]").val(postcode);
	$("input:text[name=deli_addr1]").val(addr1);
	$("input:text[name=deli_addr2]").val(addr2);
	$("input:text[name=deli_phone]").val(phone);
	$("input:text[name=deli_msg]").val(msg);
	$("input:text[name=deli_pwd]").val(pwd);
	} else if(i == 3){
		var name = manage.document.getElementById('name_3').value;
		$("input:text[name=deli_name]").val(name);
		var addr = manage.document.getElementById('addr_3').value;
		var postcode = addr.substr(1,5);
		var startIndex1 = addr.indexOf(")")+2;
		var endIndex1 = addr.indexOf(",");	
		var addr1 = addr.substring(startIndex1, endIndex1);
		var startIndex2 = addr.indexOf(",")+2;
		var addr2 = addr.substring(startIndex2);
		var phone = manage.document.getElementById('phone_3').value;
		var msg = manage.document.getElementById('msg_3').value;
		var pwd = manage.document.getElementById('pwd_3').value;
		$("input:text[name=deli_postcode]").val(postcode);
		$("input:text[name=deli_addr1]").val(addr1);
		$("input:text[name=deli_addr2]").val(addr2);
		$("input:text[name=deli_phone]").val(phone);
		$("input:text[name=deli_msg]").val(msg);
		$("input:text[name=deli_pwd]").val(pwd);
	} else if(i == 4){
		var name = manage.document.getElementById('name_4').value;
		$("input:text[name=deli_name]").val(name);
		var addr = manage.document.getElementById('addr_4').value;
		var postcode = addr.substr(1,5);
		var startIndex1 = addr.indexOf(")")+2;
		var endIndex1 = addr.indexOf(",");	
		var addr1 = addr.substring(startIndex1, endIndex1);
		var startIndex2 = addr.indexOf(",")+2;
		var addr2 = addr.substring(startIndex2);
		var phone = manage.document.getElementById('phone_4').value;
		var msg = manage.document.getElementById('msg_4').value;
		var pwd = manage.document.getElementById('pwd_4').value;
		$("input:text[name=deli_postcode]").val(postcode);
		$("input:text[name=deli_addr1]").val(addr1);
		$("input:text[name=deli_addr2]").val(addr2);
		$("input:text[name=deli_phone]").val(phone);
		$("input:text[name=deli_msg]").val(msg);
		$("input:text[name=deli_pwd]").val(pwd);
	}
	modal.classList.toggle('show');
	body.style.overflow = 'auto'
}

$(document).ready(
		function() {
			var message = "${message}";
			if(message.length > 38 ){
				alert(message);
			}
		});
$(document).ready(
		function() {
			var message2 = "${message2}";
			if(message2.length > 33 ){
				alert(message2);
				  location.href="/TeamProject/cartList.do";
			}
		});
</script>
<style>
/* number값 화살표 없애기 */
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
button{
border: 0;
}

#deli_addr table{
border:1px solid orange;
text-align:left;
width:100%;
}

#deli_addr th{
background-color:orange;
border:1px solid orange;
}
#deli_addr td{
border:1px solid orange;
} 
/* CSS RESET */


a {
	text-decoration: none;
}

li {
	list-style: none;
}

.full-bg {
	height: 100%;
}


.login-container {
	width: 1000px;
	background-color: #fff;
	padding: 70px 20px;
	box-sizing: border-box;
	
}

.login--title {
	width: 100%;
	text-align: center;
	font-size: 50px;
}

.form-btn {
	display: block;
	width: 30%;
	font-size: 16px;
	height: 40px;
	background-color: #fd7e14;
	color: #fff;
	box-sizing: border-box;
	margin: 5px 0;
	cursor: pointer;
	border:0;
}

.form-btn:hover {
	background-color: #FF9900;
	box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.5);
}

.modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal.show {
	display: block;
}

.modal_body {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 600px;
	height: 800px;
	padding: 40px;
	text-align: center;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateX(-50%) translateY(-50%);
}

.table-btn {
	width: 30% !important;
}

.table-btn2 {
    display: inline-block;
	width: 100px;
	font-size: 16px;
	height: 40px;
	background-color: #f3f3ef;
	color: #000000;
	border-radius:25px;
	box-sizing: border-box;
	margin: 5px 0;
	cursor: pointer;
	border: 0;
}

.table-btn:hover {
	background-color: #f3f3ef;
	box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.5);
}

</style>
</head>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<section>
		<div style="width:60%;margin-left: auto; margin-right: auto;">
		<form action="payment.do" method="post" name="frm" id="frm">
	
		<hr>
		<!-- 장바구니 리스트 출력  -->
		<button class="back-btn" onclick="history.back()" style="float:right">이전</button>
		<h2><i class="bi-journal-check"></i> 결제정보</h2>
		<div align="center">
		<div align="right">
		<span style="color:gray">01 장바구니 <i class="bi-caret-right-fill"></i></span>
		<span style="color:black"><strong> 02 주문서작성/결제 <i class="bi-caret-right-fill"></i></strong></span>
		<span style="color:gray"> 03 주문완료 </span>
		</div>
			<table class="ezen">
			<thead>
				<tr>
					<th style="width:75px"><!-- 이미지 --></th>
					<th>상품정보</th>
					<th>판매금액</th>
					<th>수량</th>
					<th>합 금액</th>
				</tr>
			</thead>
				<c:set var="result" value="0" />
				<c:forEach var="cart" items="${clist}">
				<tbody>
					<tr>
						<td>
							<c:choose>
							<c:when test="${cart.item_pictureUrl1 == null}">
						<img alt="이미지" src="images/item/no_image1.jpg" width="75px" height="75px">
                            </c:when>
                            <c:otherwise>
						<img alt="이미지" src="images/item/${cart.item_pictureUrl1}" width="75px" height="75px">
                            </c:otherwise>
                            </c:choose>
						</td>
						<td>${cart.item_name}</td>
						<td><fmt:formatNumber value="${cart.item_price}" pattern="#,##0" />원</td>
						<td>${cart.item_cnt}</td>
						<td><fmt:formatNumber value="${cart.item_price*cart.item_cnt}" />원</td>
					</tr>
					<c:set var="result" value="${result+(cart.item_price*cart.item_cnt)}" />
					<input type="hidden" name="item_cnt[]" value="${cart.item_cnt}">
					<input type="hidden" name="item_num[]" value="${cart.item_num}">
					<input type="hidden" name="item_pictureUrl1[]" value="${cart.item_pictureUrl1}">
				</c:forEach>
					</tbody>
			</table>
<!-- 주문자 정보  -->
		</div>
			<div align="center">
				<div class="login-container">
					<div align="left">
						<h3><i class="bi-list-check"></i> 주문자 정보</h3>
						<table>
							<tr>
								<th>주문하시는 분</th>
								<td><%=session.getAttribute("name")%></td>
							</tr>
							<tr>
								<th>휴대폰 번호</th>
								<td><%=session.getAttribute("phone")%></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><%=session.getAttribute("email")%>
							</tr>
						</table>
						<br>
						<hr>
						<br>
						<!-- 배송정보 작성  -->
						<h3><i class="bi-list-check"></i> 배송정보</h3>
						<table width="500">
							<tr>
								<th>배송지 확인</th>
								<td>
								주문자정보와 동일<input type="radio" id="addrCheck1" name="addrCheck" value="0" checked>
									직접입력<input type="radio" id="addrCheck2" name="addrCheck"	value="1">
									<button type="button" class="btn-open-popup table-btn">배송지 관리</button>
									<div class="modal">
											<div class="modal_body">
									<input type="button" name="modal" id="modal1" onclick="modalDisplay1()" value="나의 배송지" class="table-btn">
									<input type="button" name="modal" id="modal2" onclick="modalDisplay2()" value="최근 배송지" class="table-btn">
											<div id="manage">
												<iframe id="frame" name="manage" src="myAddrManage.do" frameborder="0" scrolling="no"
													width="500" height="690"></iframe>
											</div>
											<div id="recent" style="display:none">
											<br>
												최근 배송지
												<hr>
												<!-- 최근 배송지  -->
												<%
													if ((int) session.getAttribute("addrcnt") != 0) {
												%>
												<table width="100%">
													<c:forEach var="addr" items="${alist}" begin="0" end="4"
														step="1" varStatus="i">
														<tr align="left">
															<td ><i style="font-size: 20px; color: orange"
																class="bi-geo-alt-fill"></i> ${addr.deli_name}</td>
														</tr>
														<tr>
															<td align="left" width="85%">${addr.deli_addr}</td>
															<td width="15%">
																<button type="button"
																	onclick="selectAddr('${i.index}')" class="confirm-btn">선택</button>
															</td>
														</tr>
														<tr>
															<td>　</td>
														</tr>
													</c:forEach>
												</table>
												<hr> 최근 배송지는 5개까지 저장됩니다.
												<%
													} else {
												%>
														<div align="center">
															<i style="font-size:200px;color:orange" class="bi-geo-alt-fill"></i>
															<div style="font-size:30px;color:gray">최근 배송지가 없습니다.</div>
														</div>
												<%
													}
												%>

												<hr>
											</div>
										</div>
									</div>
										<script>
									const body = document.querySelector('body');
									const modal = document.querySelector('.modal');
									const btnOpenPopup = document.querySelector('.btn-open-popup');

									btnOpenPopup.addEventListener('click', () => {
										
									/* 버튼 클릭시 라디오 버튼 체크 해제 */
									  document.getElementById('addrCheck1').checked = false
									  document.getElementById('addrCheck2').checked = false
									
									  modal.classList.toggle('show');
									  if (modal.classList.contains('show')) {
									    body.style.overflow = 'hidden';
									  }
									});

									modal.addEventListener('click', (event) => {
									  if (event.target === modal) {
									    modal.classList.toggle('show');

									    if (!modal.classList.contains('show')) {
									      body.style.overflow = 'auto';
									    }
									  }
									});
									</script></td>
							</tr>
							<tr>
								<th>받으실 분</th>
								<td><input type="text" id="name" class="reset1" name="deli_name" readonly value="<%=session.getAttribute("name")%>" required></td>
							</tr>
							<tr>
								<th>받으실 곳</th>
								<td><input type="text" name="deli_postcode"id="sample4_postcode" value="<%=postcode%>" placeholder="우편번호" size="5" readonly required>
								<input type="button" id="daumPostCode" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" disabled><br>
								<input type="text" name="deli_addr1" id="sample4_roadAddress"  value="<%=addr1%>" placeholder="도로명주소" size="30" readonly required><br>
								<input type="text" name="deli_addr2" id="sample4_detailAddress" value="<%=addr2%>"  placeholder="상세주소" readonly required><br>
								<span id="guide" style="color:#999;display:none"></span>
								<input type="hidden" id="sample4_jibunAddress" placeholder="지번주소">
								<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
								<input type="hidden" id="sample4_engAddress" name="engAddr" placeholder="영문주소"  size="60" >
								</td>
							</tr>
							<tr>
								<th>휴대폰 번호</th>
								<td><input type='text' class="phone" name='deli_phone' readonly value="<%=session.getAttribute("phone")%>" required maxlength="13"/></td>
							</tr>
							<tr>
								<th>배달 참고메세지</th>
								<td><input type="text" name="deli_msg"></td>
							</tr>
							
							<tr>
								<th>포인트</th>
								<td>
								<input id="a" type="hidden" value="${result}">
								<input id="usePoint" type="number" min="0" max="<%=session.getAttribute("point")%>" name="usePoint" value="0" required>
								사용가능한 포인트 : <%=session.getAttribute("point")%>p<br>
								<div style="color:red"><span id="message"></span></div>
								<input type="button" onclick="allPoint()" value="전부 사용" class="table-btn">
							</tr>
						</table>
						<br>
						
						<hr>
						<br>
						<h3><i class="bi-list-check"></i> 공동현관 출입방법</h3>
						<table>
							<tr>
								<th>출입방법</th>
								<td>공동출입문
								<input type="radio" name="deli" id="deli1" onchange="setDisplay()" checked>
								별도 출입제한 없음
								<input type="radio" name="deli" id="deli2" onchange="setDisplay()">
								<div id="divId">
									<input type="text" name="deli_pwd" size="40" placeholder="예) #1234*/ 열쇠버튼+abcd+OK버튼">
									</div>
							</tr>
						</table>
					</div>
					<br>
					<hr>
					<br>
					<div>
					<h2>최종 결제 금액</h2>
					<br>
					<br>
					상품가격 <fmt:formatNumber value="${result}"/>원 
					- 사용할 포인트 <span id="usePointResult"></span>p 
					+ 배송비 <fmt:formatNumber value="3000"/>원<br>
					<h2><strong>=<span id="ab"></span>원</strong>입니다.</h2><br>
					<fmt:parseNumber var="point" integerOnly="true" value="${result/100*5}"/>
					적립될 포인트 : <fmt:formatNumber value="${point}"/>p
					</div>
					<br>
					<input type="checkbox" required>(필수) 구매하실 상품의 결제정보를 확인하였으며, 구매진행에 동의합니다.

					<input type="hidden" name="cartcnt" value="<%=session.getAttribute("cartcnt")%>">
					<input type="hidden" name="item_name" value="${clist[0].item_name}">
					<input type="hidden" name="userid" value="<%=session.getAttribute("userid")%>">
					<input type="hidden" name="total_price" value="${result+3000}">
					<input type="hidden" name="deli_status" value="결제완료">
					<input type="hidden" name="point" value="${point}">
					<input type="submit" id="submit" class="form-btn" value="결제">
				</div>
			</div>

		</form>
	</div>	
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>

</div>
</body>
</html>

