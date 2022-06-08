<%@page import="kr.co.EZHOME.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.info table {
    width: 100%;
    border-top: 1px solid orange;
    border-collapse: collapse;
}

.info th {
	background-color: orange;
    border-bottom: 1px solid #444444;
    padding: 10px;
}

.info td {
    border-bottom: 1px solid #444444;
    padding: 10px;
}
</style>
</head>
<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
		<jsp:include page="/WEB-INF/views/ui/side.jsp"></jsp:include>
		<section>
	<div class="info">
	<div style="width: 60%; margin-left: auto; margin-right: auto;">
	<%
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
	if(!check.equals("[]")){


		
	%>
<br>
	<hr>
	<h2>나의 주문 내역</h2>
		<table>
			<tr>
				<th width="10%">주문번호/주문일자</th>
				<th width="10%"></th>
				<th width="30%">상품명</th> <!-- ~외 ~건 -->
				<th width="10%">결제 금액</th> <!-- 배송비포함 -->
				<th width="10%">배송 상태</th> <!--  기본 결제완료 -->
				<th width="5%">취소/환불</th>
			</tr>
			<c:forEach var="order" items="${olist}">
				<tr>
					<td height="100px">${order.order_date}<br><a href="orderInfo.do?order_num=${order.order_num}&infoCheck=0">${order.order_num}</a></td>
					<td><img src="images/item/${order.item_pictureUrl1}" width="75px" height="75px">
					<td>${order.order_name}</td>
					<td>&#92;<fmt:formatNumber value="${order.amount}" pattern="#,##0" /><br>
					사용포인트${order.usePoint}p</td>
					<td>${order.deli_status}</td>
					<td>
					<form action="orderInfo.do">
					<input type="hidden" name="order_num" value="${order.order_num}">
					<input type="hidden" name="infoCheck" value="1">
					<input type="submit" value="취소/환불">
					</form>
					</td>
				</tr>
				<tr>
				</tr>
			</c:forEach>
		</table>
	</div>
	</div>
	<%}else{ %>
	<div align="center">
	<i style="font-size:200px;color:orange" class="bi-file-earmark-x-fill"></i>
	<div style="font-size:30px;color:gray">결제 내역이 없습니다.</div>
	<%
		}
	%>
	</div>
	<br>
	<hr>
	<br>
	        <div align="center">
        <h4>
		<%

			if (startPage > 10) {
		%>
		<a href="orderOkList.do?pageNum=<%=startPage - 10 %>&pageSize=<%=pageSize%>" style="color:black;"><i class="bi-chevron-compact-left"></i></a>
		<%
			}
			for (int i = startPage; i <= endPage; i++) {
				if(currentPage == i){
					%>
		<a href="orderOkList.do?pageNum=<%=i %>&pageSize=<%=pageSize%>" style="color:white;background-color:gray;border-radius:75px;text-decoration-line: none;">　<%=i %>　</a>
		<%
				}else{
					%>
		<a href="orderOkList.do?pageNum=<%=i %>&pageSize=<%=pageSize%>" style="color:black;text-decoration-line: none;">　<%=i %>　</a>
					
					<%
				}
			}
			if (endPage < pageCount) {
		%>
		<a href="orderOkList.do?pageNum=<%=startPage + 10 %>&pageSize=<%=pageSize%>" style="color:black;"><i class="bi-chevron-compact-right"></i></a>
		<%
			}
		%>
		</h4>
		</div>
		</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>
