<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
.refund table {
    width: 100%;
    border-top: 1px solid orange;
    border-collapse: collapse;
}

.refund th {
	background-color: orange;
    border-bottom: 1px solid #444444;
    padding: 10px;
}

.refund td {
    border-bottom: 1px solid #444444;
    padding: 10px;
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

.pageSize {
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

}
.form-btn:hover {
	background-color: #FF9900;
	box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.5);
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	$("#cbx_chkAll").click(function() {
		if($("#cbx_chkAll").is(":checked")) $("input[name=orderInfo]").prop("checked", true);
		else $("input[name=orderInfo]").prop("checked", false);
	});
	
	$("input[name=orderInfo]").click(function() {
		var total = $("input[name=orderInfo]").length;
		var checked = $("input[name=orderInfo]:checked").length;
		
		if(total != checked) $("#cbx_chkAll").prop("checked", false);
		else $("#cbx_chkAll").prop("checked", true); 
	});
});

function refundSubmitCheck(count) {
	var check = false;
	var className;
	var checkbox;
	for (var i=0; i < count; i++) {
		className = ".checkbox" + i;
		checkbox = $(className);
		if($(checkbox).is(":checked")){
			check = true;
		}

	}
	if (check == false) {
		alert("선택된 항목이 없습니다.");
	}
	return check;
}
</script>
</head>
<%
	int checkboxCount = 0;
%>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<section>
	<%
		int infoCheck = Integer.parseInt(request.getParameter("infoCheck"));

		if (infoCheck == 0) {
	%>

	<div class="refund">
		<div style="width: 60%; margin-left: auto; margin-right: auto;">
			<br> 주문번호 :
			<h2>${olist[0].order_num}</h2>
			<br> 배송 상태 :
			<h3>${olist[0].deli_status}</h3>
			<hr>
			받으실 분 : ${olist[0].deli_name} <br>
			배송지 : ${olist[0].deli_addr} <br>
			전화번호 : ${olist[0].deli_phone} <br>
			배송메세지 : ${olist[0].deli_msg}
			<br> 공동현관 비밀번호 : ${olist[0].deli_pwd}
			<br>
			<br>
			<table>
				<tr>
					<th style="width: 75px"></th>
					<th>상품명</th>
					<th>상품가격</th>
					<th>상품갯수</th>
				</tr>
				<c:forEach var="list" items="${olist}">
					<tr>
						<td><img src="images/item/${list.item_pictureUrl1}" width="75px"	height="75px"></td>
						<td>${list.item_name}</td>
						<td>${list.item_price}</td>
						<td>${list.item_cnt}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<%
		} else {
	%>
	<div class="refund">
		<div style="width: 60%; margin-left: auto; margin-right: auto;">
			<br> 주문번호 :
			<h2>${olist[0].order_num}</h2>
			<br> 배송 상태 :
			<h3>${olist[0].deli_status}</h3>
			<hr>
			결제완료 : 별도 과정 없이 즉시 취소가 가능합니다. <br>
			배송중 : 관리자의 승인이 필요합니다. <br>
			배송완료 : 관리자의 승인이 필요합니다. <br>
			<br>
			<form action="refundRequest.do" method="post" name="frm">
				<table>
					<tr>
						<th><input type="checkbox" id="cbx_chkAll"></th>
						<th style="width: 75px"></th>
						<th>상품명</th>
						<th>상품가격</th>
						<th>상품갯수</th>
						<th>환불/취소여부</th>
						<th>거절 사유</th>
					</tr>
					<c:set var="check" value="0"/>
					<c:forEach var="list" items="${olist}">
						<tr>
							<c:choose>
								<c:when test="${list.refund_status eq '미신청'}">
									<td><input type="checkbox" class="checkbox<%= checkboxCount%>" value="${list.item_num}/${list.item_name}/${list.item_price}/${list.item_cnt}/${list.deli_status}" name="orderInfo" ></td>
									<%
										checkboxCount++;
									%>
								</c:when>
								<c:otherwise>
									<td><input disabled type="checkbox" value="" name="test[]"></td>
								</c:otherwise>
							</c:choose>
							<td><img src="images/item/${list.item_pictureUrl1}" width="75px" height="75px"></td>
							<td>${list.item_name}</td>
							<td>${list.item_price}</td>
							<td>${list.item_cnt}</td>
							<td>${list.refund_status}</td>
							<td>${list.refund_reject}</td>
						</tr>
						<c:if test="${list.refund_status eq '미신청'}">
						<c:set var="check" value="${check +1}"></c:set>
						</c:if>
					</c:forEach>
				</table>
				<br>
				<br>
				<c:choose>
					<c:when test="${check ne '0'}">
				<input type="hidden" name="order_num" value="${olist[0].order_num}">
				<select name="refund_request" id="select">
					<option value="empty" id="1">직접 입력</option>				
				<c:choose>
					<c:when test="${olist[0].deli_status ne '결제완료'}">
						<option value="유통기한이 지난 상품이 왔어요.">유통기한이 지난 상품이 왔어요.</option>		
						<option value="제품에 문제가 있어요.">제품에 문제가 있어요.</option>		
						<option value="배송지를 잘 못 입력했어요.">배송지를 잘 못 입력했어요.</option>		
					</c:when>
				</c:choose>				
					<option value="단순 변심">단순 변심</option>	
				</select>
				<div id="form1">
					<input type="text" name="refund_request2" placeholder="직접 입력일 시 입력해주세요" size="40">
				</div>
				<input type="hidden" name="infoCheck" value="1">
				<input type="submit" class="form-btn" value="신청" onclick="return refundSubmitCheck('<%=checkboxCount%>')">
					</c:when>
					<c:otherwise>
					취소/환불을 신청 할 수 있는 건이 없습니다.
					</c:otherwise>
				</c:choose>
			</form>

		</div>
	</div>
	<%
		}
	%>
	
<script type="text/javascript">
    $("#select").change(function () {
		$("#form1").hide();
		$('#form' + $(this).find('option:selected').attr('id')).show();
	});
</script>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>