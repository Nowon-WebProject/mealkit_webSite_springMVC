<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 장바구니</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(
		function() {
			var message = "${message}";
			if(message.length > 30 ){
				alert(message);
			}
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
<style type="text/css">
input[type='number']{
    width: 42px;
} 

.table-btn {
	width: 50px !important;
}

</style>
</head>
<body>
	<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<section>
		<div style="width: 1200px; margin-left: auto; margin-right: auto;">
	<%
		if ((int) session.getAttribute("cartCnt") != 0) {
	%>
			<hr>
			<h2><i class="bi-cart-check-fill"></i> 장바구니</h2>
			<button class="back-btn" onclick="history.back()" style="float:right">이전</button>
			<br>
			<br>
			<div align="right">
				<span style="color: black"><strong>01 장바구니 <i class="bi-caret-right-fill"></i></strong></span> 
				<span style="color: gray">02 주문서작성/결제 <i class="bi-caret-right"></i></span> 
				<span style="color: gray"> 03 주문완료 </span>
			</div>
			<div align="center">
			<table class="ezen">
			<thead>
				<tr align="center">
					<th style="width: 75px">
						<!-- 이미지  -->
					</th>
					<th>상품정보</th>
					<th>판매금액</th>
					<th>수량</th>
					<th>합 금액</th>
					<th></th>
				</tr>
				</thead>
				<c:set var="result" value="0" />
				<c:forEach var="cart" items="${clist}">
					<tr align="center">
						<td>
							<c:choose>
							<c:when test="${cart.item_pictureUrl1 == null}">
						<a href="itemAbout.do?item_num=${cart.item_num}">
						<img alt="이미지" src="images/item/no_image1.jpg" width="75px" height="75px">
						</a>
                            </c:when>
                            <c:otherwise>
						<a href="itemAbout.do?item_num=${cart.item_num}">
						<img alt="이미지" src="images/item/${cart.item_pictureUrl1}" width="75px" height="75px">
						</a>
                            </c:otherwise>
                            </c:choose>
						</td>
						<td>${cart.item_name}</td>
						<td><fmt:formatNumber value="${cart.item_price}" pattern="#,##0" />원</td>
						<td>
							<form action="cartCntModify.do" method="post">
								<input type="hidden" name="cart_seq" value="${cart.cart_seq}">
                			    <i style="cursor:pointer; user-select: none;" class="bi-dash-circle" onclick="count('minus',${cart.item_quantity},${cart.cart_seq})"></i>
								<input type="number" id="${cart.cart_seq}" name="item_cnt" value="${cart.item_cnt}" readonly>
								<i style="cursor:pointer; user-select: none;" class="bi-plus-circle" onclick="count('plus',${cart.item_quantity},${cart.cart_seq})"></i>
								<input type="submit" value="변경" class="table-btn">
							</form>
						</td>
						<td><fmt:formatNumber value="${cart.item_price*cart.item_cnt}" pattern="#,##0" />원</td>
						<c:set var="result" value="${result+(cart.item_price*cart.item_cnt)}" />
						<td>
							<form action="cartDelete.do" method="post">
								<input type="hidden" name="cart_seq" value="${cart.cart_seq}">
								<input type="hidden" name="check" value="0">
								<input type="submit" value="삭제" class="back-btn">
							</form>
						</td>
					</tr>
				</c:forEach>
			</table>
			</div>
			<br>
			<div align="center">
				<form action="cartDelete.do" method="post" align="right">
					<input type="hidden" name="userid" value="<%=session.getAttribute("userid")%>">
					<input type="hidden" name="check" value="1">
					<input type="submit" value="전체 삭제" class="back-btn">
				</form>
				<Strong><fmt:formatNumber value="${result}" pattern="#,##0" /></Strong>원 입니다.
				<form action="order.do" method="post">
					<input type="hidden" name="userid" value="<%=session.getAttribute("userid")%>">
					<input type="submit" class="form-btn" value="구매하기" onclick="check()">
				</form>
				<hr>
				${message}
			</div>
		</div>
	<%
	
		} else {
	%>
	<br>
	<br>
	<br>
	<br>
	<br>
		<div align="center">
			<i style="font-size:200px;color:orange" class="bi-cart-x-fill"></i>
			<div style="font-size:30px;color:gray">장바구니가 비어있습니다.</div>
			</div>
	<%
		}
	%>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>