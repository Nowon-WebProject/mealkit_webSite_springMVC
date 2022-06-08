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

.btn{
    position: relative;
    border: none;
    display: inline-block;
    border-radius: 15px;
    font-weight: 600;
    transition: 0.25s;
    background-color: #ff5f2e;
    color: #e1eef6;
}


</style>
</head>
<body>
<div id="wrap">
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
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
	<h2>배송 정보 변경 관리자페이지</h2>
	<hr>
		<table>
			<tr>
				<th>주문번호</th>
				<th></th>
				<th width="30%">상품명</th> <!-- ~외 ~건 -->
				<th>아이디</th>
				<th width="10%">배송 상태</th>
				<th width="40%">배송 상태 변경</th>
			</tr>
			<c:forEach var="order" items="${olist}">
				<tr>
					<td><a href="orderInfo.do?order_num=${order.order_num}&infoCheck=0">${order.order_num}</a></td>
					<td><img src="images/item/${order.item_pictureUrl1}" width="75px" height="75px">					
					<td>${order.order_name}</td>
					<td>${order.userid}</td>
					<td>${order.deli_status}</td>
					<td>
					<form action="orderManageOk.do">
					<c:choose>
						<c:when test="${order.deli_status eq '결제완료'}">
					<input type="hidden" name="order_num" value="${order.order_num}">
					<input type="hidden" name="pageSize" value="<%=pageSize%>">
					<input type="hidden" name="pageNum" value="<%=pageNum%>">
					<input type="hidden" name="category" value="<%=category%>">
					<input type="hidden" name="keyword" value="<%=keyword%>">
					<input type="submit" name="deli_status" value="결제완료" class="btn" disabled>
					<input type="submit" name="deli_status" value="배송준비">
					<input type="submit" name="deli_status" value="배송중" class="btn" disabled>
					<input type="submit" name="deli_status" value="배송완료" class="btn" disabled>
						</c:when>
						<c:when test="${order.deli_status eq '배송준비'}">
					<input type="hidden" name="order_num" value="${order.order_num}">
					<input type="hidden" name="pageSize" value="<%=pageSize%>">
					<input type="hidden" name="pageNum" value="<%=pageNum%>">
					<input type="hidden" name="category" value="<%=category%>">
					<input type="hidden" name="keyword" value="<%=keyword%>">					
					<input type="submit" name="deli_status" value="결제완료" class="btn" disabled>
					<input type="submit" name="deli_status" value="배송준비" class="btn" disabled>
					<input type="submit" name="deli_status" value="배송중">
					<input type="submit" name="deli_status" value="배송완료" class="btn" disabled>
						</c:when>
						<c:when test="${order.deli_status eq '배송중'}">
					<input type="hidden" name="order_num" value="${order.order_num}">
					<input type="hidden" name="pageSize" value="<%=pageSize%>">
					<input type="hidden" name="pageNum" value="<%=pageNum%>">
					<input type="hidden" name="category" value="<%=category%>">
					<input type="hidden" name="keyword" value="<%=keyword%>">
					<input type="submit" name="deli_status" value="결제완료" class="btn" disabled>
					<input type="submit" name="deli_status" value="배송준비" class="btn" disabled>
					<input type="submit" name="deli_status" value="배송중" class="btn" disabled>
					<input type="submit" name="deli_status" value="배송완료">
						</c:when>
						<c:when test="${order.deli_status eq '배송완료'}">
					<input type="hidden" name="order_num" value="${order.order_num}">
					<input type="hidden" name="pageSize" value="<%=pageSize%>">
					<input type="hidden" name="pageNum" value="<%=pageNum%>">
					<input type="hidden" name="category" value="<%=category%>">
					<input type="hidden" name="keyword" value="<%=keyword%>">
					<input type="submit" name="deli_status" value="결제완료" class="btn" disabled>
					<input type="submit" name="deli_status" value="배송준비" class="btn" disabled>
					<input type="submit" name="deli_status" value="배송중" class="btn" disabled>
					<input type="submit" name="deli_status" value="배송완료" class="btn" disabled>
						</c:when>
					</c:choose>
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
	<div style="font-size:30px;color:gray">주문 정보가 없습니다.</div>
	<%
		}
	%>
	</div>
	<br>
	<hr>
	<br>
		<div align="center">
        <form action="orderManage.do">
        <input type="hidden" name="pageNum" value="1">
        <input type="hidden" name="pageSize" value="<%=pageSize%>">
		<select name="category">
			<option value="order_num">주문번호</option>
			<option value="userid">아이디</option>
		</select>      
		&nbsp;
        <i class="bi-search" style="font-size:20px"></i>
		&nbsp;
        <input type="text" name="keyword" placeholder="" size="40">
        <input type="submit" value="검색">
        </form>
        </div>
		<br>
	<hr>
	<br>
	<div align="center">
        <h4>
		<%

			if (startPage > 10) {
		%>
		<a href="orderManage.do?pageNum=<%=startPage - 10 %>&pageSize=<%=pageSize%>&category=<%=category%>&keyword=<%=keyword%>" style="color:black;"><i class="bi-chevron-compact-left"></i></a>
		<%
			}
			for (int i = startPage; i <= endPage; i++) {
				if(currentPage == i){
					%>
		<a href="orderManage.do?pageNum=<%=i %>&pageSize=<%=pageSize%>&category=<%=category%>&keyword=<%=keyword%>" style="color:white;background-color:gray;border-radius:75px;text-decoration-line: none;">　<%=i %>　</a>
		<%
				}else{
					%>
		<a href="orderManage.do?pageNum=<%=i %>&pageSize=<%=pageSize%>&category=<%=category%>&keyword=<%=keyword%>" style="color:black;text-decoration-line: none;">　<%=i %>　</a>
					
					<%
				}
			}
			if (endPage < pageCount) {
		%>
		<a href="orderManage.do?pageNum=<%=startPage + 10 %>&pageSize=<%=pageSize%>&category=<%=category%>&keyword=<%=keyword%>" style="color:black;"><i class="bi-chevron-compact-right"></i></a>
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
