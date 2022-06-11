<%@page import="kr.co.EZHOME.dto.ItemDTO"%>
<%@page import="kr.co.EZHOME.dto.PageDTO"%>
<%@page import="kr.co.EZHOME.dao.ItemDAO"%>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 관리자페이지</title>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
<link rel="stylesheet" type="text/css" href="css/style.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style type="text/css">
.back-btn {
	color:white !important;
	background-color : tomato !important;
	width:170px !important;
}
</style>
<script type="text/javascript">
$(document).ready(
		function() {
			var admin = <%=(Integer)session.getAttribute("admin")%>
			if(admin != 1){
			alert("접근 권한이 없습니다.");
			location.href="index";
			}
		});
function deleteAll(){
	var result = confirm("정말 모든 상품을 삭제하시겠습니까?")
	
	if(result == true){
		alert("모든 상품이 삭제되었습니다.")
	location.href='deleteAll'		
	}else{
		alert("취소되었습니다.")
	}
	
}
</script>
</head>
<body>
	<%
		PageDTO pageBean = (PageDTO) request.getAttribute("page");
		int startPage = pageBean.getStartPage();
		int endPage = pageBean.getEndPage();
		int pageSize = pageBean.getPageSize();
		int pageCount = pageBean.getPageCount();
		int pageNum = pageBean.getPageNum();
		if (pageNum == 0){
			pageNum = 1;
		}
		
		
	%>
<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/sideManage.jsp"></jsp:include>
	<section>
	<div style="width: 60%; margin-left: auto; margin-right: auto;">
	<div align="left">
			<h2>상품 목록 - 관리자페이지</h2>
			<br>
			<hr>
			<div style="float:right">
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
					<button type="submit" class="page" >개씩 보기</button>
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
					<button type="submit" class="page" >개씩 보기</button>
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
					<button type="submit" class="page" >개씩 보기</button>
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
					<button type="submit" class="page" >개씩 보기</button>
				</form>
			</c:when>
		</c:choose>
		</div><br><br>
			<button class="confirm-btn" onclick="location.href='itemWriteDo'" style="float:right">상품등록</button>
			</div>
			
		<%
		String check = (request.getAttribute("items").toString());
		if (!check.equals("[]")) {
		%>	
		<table class="ezen">
		<thead>
			<tr>
				<th>대표 사진</th>
				<th>번호</th>
				<th>카테고리<br>
				상품명
				<th>가격</th>
				<th>재고</th>
				<th>몇인분<br>
				조리 시간</th>
				<th>메인</th>
				<%-- 여기에서는 빠질 수도 있음 --%>
				<th>판매량</th>
				<th>할인율</th>
				<th>평점</th>
				<th>수정<br>
				삭제</th>
			</tr>
		</thead>
			<c:forEach var="item" items="${items}">
				<tr>
					<td>
					<a href="itemAbout.do?item_num=${item.item_num}">
					<c:choose>
							<c:when test="${item.item_pictureUrl1 eq null}">
								<img id="imgList" src="images/item/no_image1.jpg">
							</c:when>
							<c:otherwise>
								<img id="imgList" src="images/item/${item.item_pictureUrl1}">
							</c:otherwise>
						</c:choose></a></td>
					<td style="text-align:center">${item.item_num}</td>
					<td>[${item.item_category}]<br>
					${item.item_name}</td>
					<td>
					<c:choose>
					<c:when test="${item.item_discount == 0.00 }">
					<fmt:formatNumber value="${item.item_price}" />원
					</c:when>
					<c:otherwise>
					<del><fmt:formatNumber value="${item.item_price}" />원</del><br>
					<fmt:formatNumber value="${item.item_price-(item.item_price*item.item_discount)}" />원
					</c:otherwise>
					</c:choose>
					</td>
					<td style="text-align:center">${item.item_quantity}</td>
					<td style="text-align:center">${item.item_total}인분<br>
					${item.item_time}분</td>
					<td style="text-align:center">${item.item_main}</td>
					<td style="text-align:center">${item.item_sales}</td>
					<td style="text-align:center"><fmt:formatNumber value="${item.item_discount * 100}"/>%</td>
					<td style="text-align:center">${item.item_starsAvg}</td>
					<td style="text-align:center">
					<button type="button" onclick="location.href='itemUpdateDo?item_num=${item.item_num}'" class="confirm-btn">수정</button><br>
					<button type="button" onclick="location.href='itemDeleteDo?item_num=${item.item_num}'" class="table-btn">삭제</button>
					</td>
				</tr>
			</c:forEach>
			<tr>
		</table>
		<div align="right">
			<button type="button" onclick="deleteAll()" class="back-btn">전체 상품 삭제</button>
		</div>
		<%}else{ %>
		<br>
		<br>
		<div align="center">
			<i style="font-size:200px;color:orange" class="bi bi-pencil-square"></i>
			<div style="font-size:30px;color:gray">등록된 상품이 없습니다.</div>
			</div>
		<%} %>
		<br>
		<br>
	 <div align="center">
        <h4>
		<%
			// 아래는 페이지 표시 과정

			if (startPage > 10) {
		%>
		<a href="itemListManagePage?pageNum=<%=startPage - 10%>&pageSize=<%=pageSize%>"  style="color:black;"><i class="bi-chevron-compact-left"></i></a>
		<%
			}
			for (int i = startPage; i <= endPage; i++) {
				if(pageNum == i){
					%>
		<a href="itemListManagePage?pageNum=<%=i%>&pageSize=<%=pageSize%>" style="color:white;background-color:gray;border-radius:75px;text-decoration-line: none;">　<%=i %>　</a>
		<%
				}else{
					%>
		<a href="itemListManagePage?pageNum=<%=i%>&pageSize=<%=pageSize%>" style="color:black;text-decoration-line: none;">　<%=i %>　</a>
					
					<%
				}
			}
			if (endPage < pageCount) {
		%>
		<a href="itemListManagePage?pageNum=<%=startPage + 10%>&pageSize=<%=pageSize%>" style="color:black;"><i class="bi-chevron-compact-right"></i></a>
		<%
			}
		%>
		</h4>
		</div>
		<br>
	</div>
	</section>
		<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>