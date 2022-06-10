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
	<div id="wrap" style="width: 700px" align="center">
		<h1>상품 삭제-관리자 페이지</h1>
		<form action="itemDeleteDo" method="post" name="frm">
			<table>
				<tr>
					<td>
						<c:choose>
							<c:when test="${empty item.item_pictureUrl1}">
								<img src="images/item/noimage.gif">
							</c:when>
							<c:otherwise>
								<img src="images/item/${item.item_pictureUrl1}">
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${empty item.item_pictureUrl2}">
								<img src="images/item/noimage.gif">
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
			</table><br>
			<input type="hidden" name="item_num" value="${item.item_num}">
			<input type="submit" value="삭제">
			<input type="button" value="목록" onclick="location.href='itemListManagePage'">
		</form>
	</div>
</body>
</html>