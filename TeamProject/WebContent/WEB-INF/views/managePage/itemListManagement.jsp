<%@page import="kr.co.EZHOME.dto.ItemDTO"%>
<%@page import="kr.co.EZHOME.dto.PageDTO"%>
<%@page import="kr.co.EZHOME.dao.ItemDAO"%>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
</head>
<body>
	<%
		PageDTO pageBean = (PageDTO) request.getAttribute("page");
		int startPage = pageBean.getStartPage();
		int endPage = pageBean.getEndPage();
		int pageSize = pageBean.getPageSize();
		int pageCount = pageBean.getPageCount();
	%>
	<div id="wrap" style="width: 900px" align="center">
		<h1>상품 목록-관리자 페이지</h1>
		<table class="list">
			<tr>
				<td colspan="15" style="border: white; text-align: right"><a
					href="itemWriteDo">상품 등록</a></td>
			</tr>
			<tr>
				<td>대표 사진</td>
				<td>상품 번호</td>
				<td>카테고리</td>
				<td>상품명</td>
				<td>가격</td>
				<td>재고</td>
				<td>날짜</td>
				<td>인분</td>
				<td>조리 시간</td>
				<td>메인</td>
				<%-- 여기에서는 빠질 수도 있음 --%>
				<td>판매량</td>
				<td>할인율</td>
				<td>평점</td>
				<td>수정</td>
				<td>삭제</td>
			</tr>
			<c:forEach var="item" items="${items }">
				<tr>
					<td><c:choose>
							<c:when test="${empty item.item_pictureUrl1}">
								<img id="imgList" src="images/item/noimage.gif">
							</c:when>
							<c:otherwise>
								<img id="imgList" src="images/item/${item.item_pictureUrl1}">
							</c:otherwise>
						</c:choose></td>
					<td>${item.item_num}</td>
					<td>${item.item_category}</td>
					<td>${item.item_name}</td>
					<td>${item.item_price}원</td>
					<td>${item.item_quantity}</td>
					<td>${item.item_date}</td>
					<td>${item.item_total}</td>
					<td>${item.item_time}</td>
					<td>${item.item_main}</td>
					<td>${item.item_sales}</td>
					<td>${item.item_discount}</td>
					<td>${item.item_starsAvg}</td>
					<td><a href="itemUpdateDo?item_num=${item.item_num}">상품 수정</a></td>
					<td><a href="itemDeleteDo?item_num=${item.item_num}">상품 삭제</a></td>
				</tr>
			</c:forEach>
			<tr>
			</tr>
			<tr>
				<td colspan="15" style="border: white; text-align: right"><a
					href="deleteAll">모든 상품 삭제</a></td>
			</tr>
		</table>
		<br>
		<br>
		<%
			if (startPage > 10) {
		%>
		<a
			href="itemListManagePage?pageNum=<%=startPage - 10%>&pageSize=<%=pageSize%>">[이전]</a>
		<%
			}
			for (int i = startPage; i <= endPage; i++) {
		%>
		<a href="itemListManagePage?pageNum=<%=i%>&pageSize=<%=pageSize%>">[<%=i%>]
		</a>
		<%
			}
			if (endPage < pageCount) {
		%>
		<a
			href="itemListManagePage?pageNum=<%=startPage + 10%>&pageSize=<%=pageSize%>">[다음]</a>
		<%
			}
		%>
		<br>
		<br>
		<c:set var="pageSize" value="<%=pageSize%>"></c:set>
		<c:choose>
			<c:when test="${pageSize == 5}">
				<form action="itemListManagePage">
					<select name="pageSize">
						<option value="5" selected>5</option>
						<option value="10">10</option>
						<option value="15">15</option>
						<option value="20">20</option>
					</select>
					<button type="submit">페이지씩 보기</button>
				</form>
			</c:when>
			<c:when test="${pageSize == 10}">
				<form action="itemListManagePage">
					<select name="pageSize">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="15">15</option>
						<option value="20">20</option>
					</select>
					<button type="submit">페이지씩 보기</button>
				</form>
			</c:when>
			<c:when test="${pageSize == 15}">
				<form action="itemListManagePage">
					<select name="pageSize">
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="15" selected>15</option>
						<option value="20">20</option>
					</select>
					<button type="submit">페이지씩 보기</button>
				</form>
			</c:when>
			<c:when test="${pageSize == 20}">
				<form action="itemListManagePage">
					<select name="pageSize">
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="15">15</option>
						<option value="20" selected>20</option>
					</select>
					<button type="submit">페이지씩 보기</button>
				</form>
			</c:when>
		</c:choose>
	</div>
</body>
</html>