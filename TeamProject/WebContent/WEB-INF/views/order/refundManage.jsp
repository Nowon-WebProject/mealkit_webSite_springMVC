<%@page import="kr.co.EZHOME.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/scripts.js"></script>
<title>이젠, 집에서 | 관리자페이지</title>
<style type="text/css">
.form-btn {
	width: 100px !important; 
	float: center !important;
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

function fnCopyToClipboard(str) {
	  // str이 복사하고자 하는 문자열
	  var tempElement = document.createElement("textarea");
	  document.body.appendChild(tempElement);
	  tempElement.value = str;
	  tempElement.select();
	  document.execCommand('copy');
	  document.body.removeChild(tempElement);
	  alert(" ["+str+"] 클립보드에 복사되었습니다.");
	}
</script>
</head>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/sideManage.jsp"></jsp:include>
	<section>
	<%
	int checkboxCount = 0;
	String keyword = request.getParameter("keyword");
	String category = request.getParameter("category");
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	int pageSize = Integer.parseInt(request.getParameter("pageSize"));
	int count = Integer.parseInt(request.getAttribute("count").toString());
	int currentPage = Integer.parseInt(request.getAttribute("currentPage").toString());
	int pageCount = Integer.parseInt(request.getAttribute("pageCount").toString());
	int endPage = Integer.parseInt(request.getAttribute("endPage").toString());
	int startPage = Integer.parseInt(request.getAttribute("startPage").toString());
			
		String check = (request.getAttribute("olist").toString());
		if (!check.equals("[]")) {
	%>
		<div style="width: 60%; margin-left: auto; margin-right: auto;">
			<h2>취소/환불 요청 목록</h2>
			<br>
			<hr>
			<br>
			<div align="center">
				<form action="refundManage.do">
					<input type="hidden" name="pageNum" value="1">
					<input type="hidden" name="pageSize" value="<%=pageSize%>">
					<select name="category">
						<option value="order_num">주문번호</option>
						<option value="userid">아이디</option>
					</select>
					&nbsp;
					<i class="bi-search" style="font-size: 20px"></i>
					&nbsp;
					<input type="text" name="keyword" placeholder="" size="40">
					<input type="submit" value="검색">
				</form>
			</div>
			<form action="refundManageOk.do">
				<br>
				<table class="ezen">
				<thead>
					<tr>
						<th><input type="checkbox" id="cbx_chkAll"></th>
						<th width="25%">주문번호<br>주문자</th>
						<th width="75px"></th>
						<th width="20%">상품명<br>상품가격</th>
						<th width="5%">수량</th>
						<th>취소/환불사유</th>
						<th>거절사유</th>
					</tr>
					</thead>
					<c:forEach var="list" items="${olist}">
						<tr>							
							<td style="text-align:center"><input type="checkbox" class="checkbox<%= checkboxCount%>" value="${list.item_num}/${list.item_cnt}/${list.order_num}" name="orderInfo"></td>
							<%
								checkboxCount++;
							%>
							<td>
							<i style="cursor:pointer" class="bi-clipboard-check" onclick="fnCopyToClipboard('${list.order_num}')"></i>
							<a href="orderInfo.do?order_num=${list.order_num}&infoCheck=0">${list.order_num}</a>
							<br>
							<i style="cursor:pointer" class="bi-clipboard-check" onclick="fnCopyToClipboard('${list.userid}')"></i>
							${list.userid}</td>
							<td><img src="images/item/${list.item_pictureUrl1}" width="75px" height="75px">
							<td>${list.item_name}<br>
							<fmt:formatNumber value="${list.item_price}"/>원
							</td>
							<td style="text-align:center">${list.item_cnt}</td>
							<td>${list.refund_request}</td>
							<td>${list.refund_reject}</td>
						</tr>
					</c:forEach>
				</table>
				<br>
				<div align="center">
				<div align="right" style="width:100px">
				<input type="hidden" name="pageSize" value="<%=pageSize%>">
				<input type="hidden" name="pageNum" value="1">
				<input type="hidden" name="category" value="<%=category%>">
				<input type="hidden" name="keyword" value="<%=keyword%>">
				<input type="submit" class="confirm-btn" name="check" value="승인" onclick="return refundSubmitCheck('<%=checkboxCount%>')">
				<input type="submit" class="confirm-btn" name="check" value="거절" onclick="return refundSubmitCheck('<%=checkboxCount%>')">
				</div>
				<br>
				거절 사유 :
				<select name="reject" id="select">
					<option value="empty" id="1">직접입력</option>
					<option value="밀키트 제품 특성 상 단순 변심으로 인한 취소/환불이 불가합니다.">밀키트 제품 특성 상 단순 변심으로 인한 취소/환불이 불가합니다.</option>
					<option value="현재 배송이 완료된 건으로 도움을 드릴 수 없습니다. 택배사로 연락 바랍니다.">현재 배송이 완료된 건으로 도움을 드릴 수 없습니다. 택배사로 연락 바랍니다.</option>
					<option value="해당 부분 확인 결과, 문제가 없는 것으로 파악되었습니다.">해당 부분 확인 결과, 문제가 없는 것으로 파악되었습니다.</option>
				</select>
				<br>
				<div id="form1">
					<input type="text" name="reject2" size="50" value="" placeholder="직접입력시 입력해주세요.">
				</div>
				</div>
			</form>
		<script type="text/javascript">
		    $("#select").change(function () {
				$("#form1").hide();
				$('#form' + $(this).find('option:selected').attr('id')).show();
			});
		</script>
	<hr>
	<%
		} else {
	%>
		<br>
	<br>
	<br>
	<div align="center">
		<i style="font-size: 200px; color: orange"
			class="bi-file-earmark-x-fill"></i>
		<div style="font-size: 30px; color: gray">취소/환불 요청이 없습니다.</div>
		<%
			}
		%>

	<div align="center">
		<h4>
			<%

				if (startPage > 10) {
			%>
			<a href="refundManage.do?pageNum=<%=startPage - 10%>&pageSize=<%=pageSize%>&category=<%=category%>&keyword=<%=keyword%>" style="color: black;"><i class="bi-chevron-compact-left"></i></a>
			<%
				}
				for (int i = startPage; i <= endPage; i++) {
					if (currentPage == i) {
			%>
			<a href="refundManage.do?pageNum=<%=i%>&pageSize=<%=pageSize%>&category=<%=category%>&keyword=<%=keyword%>" style="color: white; background-color: gray; border-radius: 75px; text-decoration-line: none;">　<%=i%>　</a>
			<%
				} else {
			%>
			<a href="refundManage.do?pageNum=<%=i%>&pageSize=<%=pageSize%>&category=<%=category%>&keyword=<%=keyword%>" style="color: black; text-decoration-line: none;">　<%=i%>　</a>
			<%
					}
				}
				if (endPage < pageCount) {
			%>
			<a href="refundManage.do?pageNum=<%=startPage + 10%>&pageSize=<%=pageSize%>&category=<%=category%>&keyword=<%=keyword%>" style="color: black;"><i class="bi-chevron-compact-right"></i></a>
			
			<%
				}
			%>
		</h4>
	</div>
		</div>
	</div>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>