<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 관리자페이지</title>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
</head>
<body>
	<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/sideManage.jsp"></jsp:include>
	<section>
		<div style="width: 60%; margin-left: auto; margin-right: auto;">
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
							<c:when test="${empty item.item_pictureUrl1}">
								<img src="images/item/no_image1.jpg">
							</c:when>
							<c:otherwise>
								<img src="images/item/${item.item_pictureUrl1}">
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${empty item.item_pictureUrl2}">
								<img src="images/item/no_image1.jpg">
							</c:when>
							<c:otherwise>
								<img src="images/item/${item.item_pictureUrl2}">
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<table>
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
						</table>
					</td>
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
		</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>