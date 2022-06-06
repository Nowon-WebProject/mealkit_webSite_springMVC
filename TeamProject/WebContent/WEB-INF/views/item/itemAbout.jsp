<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 회원가입</title>
<link href="css/styles.css" rel="stylesheet" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
$(document).ready(
		function() {
			var check = "${ilist[0].item_name}";
			if(check == ""){
				alert("유효하지 않은 페이지입니다.");
				history.back();
			}
		});
	$(document).ready(
			function() {
				
				var price = $('#price').val();
				var cnt = $('.cnt').val();

				var total_price = price * cnt;
				$('#total_price').text(
						total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g,
								','));
			});

	$(document).ready(
			function() {
				$('.bi-dash-circle').click(
						function() {
							$('.cnt').focus();
							var price = $('#price').val();
							var cnt = $('.cnt').val();
							var total_price = price * cnt;
							$('#total_price').text(
									total_price.toString().replace(
											/\B(?=(\d{3})+(?!\d))/g, ','));
						});
			});
	$(document).ready(
			function() {
				$('.bi-plus-circle').click(
						function() {
							var price = $('#price').val();
							var cnt = $('.cnt').val();
							var total_price = price * cnt;
							$('#total_price').text(
									total_price.toString().replace(
											/\B(?=(\d{3})+(?!\d))/g, ','));
						});
			});
	
	
	function count(type,item_quantity,item_num){
		 var inputValue = parseInt(document.getElementById(item_num).value,10);
		 
		 if(type=="minus"){
			 if(inputValue != 1){
		 		var result = inputValue -1;
				 $('input[id='+item_num+']').attr('value',result);
			 }										
		 }else{
			 if(inputValue < item_quantity){
		 		var result = inputValue +1;
				 $('input[id='+item_num+']').attr('value',result);
			 }
		 }
		 
	}
</script>
<style>
input[type='number']{
    width: 42px;
} 


.login-container {
	width: 500px;
	background-color: #fff;
	padding: 70px 20px;
	box-sizing: border-box;
}

.login--title {
	width: 100%;
	text-align: center;
	font-size: 50px;
}

.form-input {
	width: 100%;
	padding: 10px 20px;
	font-size: 20px;
	outline: none;
	margin: 10px 0;
	border: 1px solid #efefef;
	box-sizing: border-box;
}

.form-input:focus {
	box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1);
	border: none;
}

.form-input--title {
	width: 100%;
	display: block;
	margin: 5px 0;
	box-sizing: border-box;
}

.form-btn {
	border: 0;
	display: block;
	width: 100%;
	font-size: 16px;
	height: 40px;
	background-color: #fd7e14;
	color: #fff;
	box-sizing: border-box;
	margin: 5px 0;
	cursor: pointer;
}

.form-btn:hover {
	background-color: #FF9900;
	box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.5);
}

.Menu {
 	display: flex; 
	justify-content: space-evenly;
	background-color: #fff;
	width: 60%;
	align: center;
	margin-left: auto;
	margin-right: auto;
	border:2px solid gray;
}

.Menu a {
	color: black;
	font-size: 32px;
	padding: 5px 5px;
	text-decoration: none;
}

.Fixed {
	position: fixed;
	top: 0px;
	left: 50%;
	transform: translate(-50%, 0); @media ( max-width :480px) { .Menu a {
	font-size: 20px;
}

.back{
	border: 0;
	width: 100px;
	font-size: 16px;
	height: 30px;
	background-color: #fd7e14;
	color: #fff;
	box-sizing: border-box;
	margin: 5px 0;
	cursor: pointer;
}

</style>

<script>
	$(document).ready(function() {
		var Offset = $('.Menu').offset();
		$(window).scroll(function() {
			if ($(document).scrollTop() > Offset.top) {
				$('.Menu').addClass('Fixed');
			} else {
				$('.Menu').removeClass('Fixed');
			}
		});
	});
	
	
	function loginCheck() {
		var userid = "${userid}";
		if (userid == "") {
			alert("로그인 후 이용 가능합니다.");
		} else {
			alert("장바구니에 담았습니다.");
		}
	}
</script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<br>
	<br>
	<br>
	<div style="width: 60%; margin-left: auto; margin-right: auto;"
		align="center">
		<div style="width: 60%; float: left;">
		                        <c:choose>
						<c:when test="${ilist[0].item_pictureUrl1 == null}">
							<img width="70%" height="70%" src="images/item/no_image1.jpg">
                            </c:when>
                            <c:otherwise>
							<img width="70%" height="70%" src="images/item/${ilist[0].item_pictureUrl1}">
                            </c:otherwise>
                            </c:choose>
		</div>
		<div style="width: 40%; float: left;" align="left">
			<form action="cartInsert.do" method="post">
				<p>[${ilist[0].item_category}]</p>
				<p>
					<strong><h2>${ilist[0].item_name}</h2></strong>
				</p>
				<p style="color:gray">
					${ilist[0].item_content}
				</p>
				 <p>
											<c:choose>
												<c:when test="${ilist[0].item_starsAvg == 5}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
												</c:when>
												<c:when test="${ilist[0].item_starsAvg >= 4.5}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-half"></i>
												</c:when>
												<c:when test="${ilist[0].item_starsAvg >= 4.0}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${ilist[0].item_starsAvg >= 3.5}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-half"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${ilist[0].item_starsAvg >= 3.0}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${ilist[0].item_starsAvg >= 2.5}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-half"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${ilist[0].item_starsAvg >= 2.0}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${ilist[0].item_starsAvg >= 1.5}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star-half"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${ilist[0].item_starsAvg >= 1.0}">
													<i style="color: orange;" class="bi-star-fill"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:when test="${ilist[0].item_starsAvg >= 0.5}">
													<i style="color: orange;" class="bi-star-half"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:when>
												<c:otherwise>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
													<i style="color: orange;" class="bi-star"></i>
												</c:otherwise>
											</c:choose></p>
				<hr>
				<c:choose>
					<c:when test="${ilist[0].item_discount == 0.00 }">
					<del><p><fmt:formatNumber value="${ilist[0].item_price}"/>원</p></del>
		                                    &nbsp;
                                    	</c:when>
					<c:otherwise>
						<del>
							<fmt:formatNumber value="${ilist[0].item_price}" />
							원
						</del>
						<br>
				<p><h3><fmt:formatNumber value="${ilist[0].item_price -(ilist[0].item_price * ilist[0].item_discount)}"/>원</h3></p>
                                    	</c:otherwise>
				</c:choose>
				<p style="color:green">
					[구매 혜택 / 적립포인트 (개당) +
					<fmt:formatNumber value="${(ilist[0].item_price -(ilist[0].item_price * ilist[0].item_discount))*0.05}" pattern="#,#00"/>p]
				</p>
				<hr>
				<p>${ilist[0].item_total}인분</p>
				<p>조리시간 ${ilist[0].item_time}분</p>
				<hr>
				<% String userid = (String) session.getAttribute("userid");  %>
                <c:set var="userid" value="<%=userid%>"/>
                <input type="hidden" name="userid" value="${userid}">
				<input type="hidden" name="item_quantity" value="${ilist[0].item_quantity}">
				<input type="hidden" name="item_num" value="${ilist[0].item_num}">
				<input type="hidden" name="item_pictureUrl1" value="${ilist[0].item_pictureUrl1}">
				<input type="hidden" name="item_name" value="${ilist[0].item_name}">
				<fmt:parseNumber var="item_price" integerOnly="true" value="${ilist[0].item_price -(ilist[0].item_price * ilist[0].item_discount)}" />
												<input type="hidden" name="item_price" value="${item_price}">
				<c:choose>
					<c:when test="${ilist[0].item_quantity != 0}">
						<p>
							수량 : 
							<i class="bi-dash-circle" onclick="count('minus',${ilist[0].item_quantity},${ilist[0].item_num})"></i>
							<input type="number" class="cnt" id="${ilist[0].item_num}" name="item_cnt" value="1" readonly>
							<i class="bi-plus-circle" onclick="count('plus',${ilist[0].item_quantity},${ilist[0].item_num})"></i>
							<span style="color:gray;font-size:8pt">남은 수량(${ilist[0].item_quantity})</span>
						</p>
						<p>누적 판매량 ${ilist[0].item_sales} (취소, 환불건 제외)</p>
						
						<p>
							총 합계 금액 <span id="total_price"></span>원
						</p>
						
						<input type="submit" class="form-btn" value="장바구니" id="cart" onClick="loginCheck()">
					</c:when>
					<c:otherwise>
					<br>
					<br>
					<br>
						<input type="button" class="form-btn" value="품절되어 구매가 불가능합니다."
							id="cart">
					</c:otherwise>
				</c:choose>
				<br>
				<br>
				<br>
				<br>
			</form>
			<!-- 가격 자동 계산용 -->
			<input type="hidden" value="${ilist[0].item_price}" id="price">
		</div>
	</div>
	
	<div class="Menu">
		<a href="#info">상세정보</a> <a href="#review">후기</a> <a href="#qna">문의</a>
	</div>
	
	<div id="info"
		align="center">
		<c:choose>
		<c:when test="${ilist[0].item_pictureUrl2 == null}">
			<img src="images/item/no_image2.jpg">
		</c:when>
		<c:otherwise>
			<img src="images/item/${ilist[0].item_pictureUrl2}">
		</c:otherwise>
		</c:choose>
	</div>

	<div id="review"
		style="width: 60%; margin-left: auto; margin-right: auto;"
		align="center">
		<br> <br> <br> <br> <br>
		<div align="left">
			<h1>후기</h1>
		</div>
		<hr>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br>

	</div>

	<div id="qna"
		style="width: 60%; margin-left: auto; margin-right: auto;"
		align="center">
		<br> <br> <br> <br> <br> <br>
		<div align="left">
			<h1>문의</h1>
		</div>
		<hr>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br> a<br>
		a<br> a<br> a<br> a<br> a<br> a<br>
	</div>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</body>
</html>