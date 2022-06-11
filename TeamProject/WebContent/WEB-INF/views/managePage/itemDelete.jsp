<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 관리자페이지</title>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(
		function() {
			var admin = <%=(Integer)session.getAttribute("admin")%>
			if(admin != 1){
			alert("접근 권한이 없습니다.");
			location.href="index";
			}
		});
</script>
<style type="text/css">
.ezen{
width:50% !important;
}
</style>
</head>
<body>
	<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/sideManage.jsp"></jsp:include>
	<section>
		<div style="width: 60%; margin-left: auto; margin-right: auto;" align="center">
			<h2>상품 삭제 - 관리자 페이지</h2>
			<br>
			<hr>
			<br>
		<form action="itemDeleteDo" method="post" name="frm">
			<table class="ezen">
				<thead>
				<tr>
					<td>
						<c:choose>
							<c:when test="${item.item_pictureUrl1 eq null}">
								<img src="images/item/no_image1.jpg">
							</c:when>
							<c:otherwise>
								<img src="images/item/${item.item_pictureUrl1}">
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${item.item_pictureUrl2 eq null}">
								<img src="images/item/no_image2.jpg">
							</c:when>
							<c:otherwise>
								<img src="images/item/${item.item_pictureUrl2}">
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</thead>
						</table>
						<table class="ezen">
						<thead>
							<tr>
								<th style="width:80px">상품명</th>
								<td>${item.item_name}</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>
									<div style="height:220px;width:100%">
										${item.item_content}
									</div>
								</td>
							</tr>
							<tr>
								<th>가격</th>
								<td>${item.item_price}원</td>
							</tr>
							<tr>
								<th>재고</th>
								<td>${item.item_quantity}</td>
							</tr>
							</thead>
			</table><br>
			<div align='center'>
			<input type="hidden" name="item_num" value="${item.item_num}">
			<input type="submit" value="삭제" class="back-btn">
			<input type="button" value="목록" onclick="location.href='itemListManagePage'" class="back-btn">
			</div>
		</form>
	</div>
	<br>
		</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>