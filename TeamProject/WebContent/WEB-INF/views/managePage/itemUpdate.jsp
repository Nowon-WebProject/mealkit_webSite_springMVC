<%@page import="kr.co.EZHOME.dto.ItemDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
<script type="text/javascript" src="js/item.js"></script>
</head>
<body>
<%
	ItemDTO itemDTO = (ItemDTO) request.getAttribute("item");
	int discount = (int)(itemDTO.getItem_discount() * 100);
%>
	<div id="wrap" style="width: 400px" align="center">
		<h1>상품 수정-관리자 페이지</h1>
		<form action="itemUpdateDo" method="post" enctype="multipart/form-data" name="frm">
			<input type="hidden" name="item_num" value="${item.item_num}">
			<input type="hidden" name="nonmakeImg1" value="${item.item_pictureUrl1}">
			<input type="hidden" name="nonmakeImg2" value="${item.item_pictureUrl2}">
			<table>
				<tr>
					<th>대표 사진</th>
					<td>
						<c:choose>
							<c:when test="${empty item.item_pictureUrl1}">
								<img id="imgUpdate" src="images/item/noimage.gif">
							</c:when>
							<c:otherwise>
								<img id="imgUpdate" src="images/item/${item.item_pictureUrl1}">
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>상세 사진</th>
					<td>
						<c:choose>
							<c:when test="${empty item.item_pictureUrl2}">
								<img id="imgUpdate" src="images/item/noimage.gif">
							</c:when>
							<c:otherwise>
								<img id="imgUpdate" src="images/item/${item.item_pictureUrl2}">
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>
						<c:choose>
							<c:when test="${item.item_category == '한식'}">
							<select name="item_category">
								<option value="한식" selected>한식</option>
								<option value="양식">양식</option>
								<option value="중식">중식</option>
								<option value="일식">일식</option>
								<option value="샐러드">샐러드</option>
							</select>
							</c:when>
							<c:when test="${item.item_category == '양식'}">
							<select name="item_category">
								<option value="한식">한식</option>
								<option value="양식" selected>양식</option>
								<option value="중식">중식</option>
								<option value="일식">일식</option>
								<option value="샐러드">샐러드</option>
							</select>
							</c:when>
							<c:when test="${item.item_category == '중식'}">
							<select name="item_category">
								<option value="한식">한식</option>
								<option value="양식">양식</option>
								<option value="중식" selected>중식</option>
								<option value="일식">일식</option>
								<option value="샐러드">샐러드</option>
							</select>
							</c:when>
							<c:when test="${item.item_category == '일식'}">
							<select name="item_category">
								<option value="한식">한식</option>
								<option value="양식">양식</option>
								<option value="중식">중식</option>
								<option value="일식" selected>일식</option>
								<option value="샐러드">샐러드</option>
							</select>
							</c:when>
							<c:when test="${item.item_category == '샐러드'}">
							<select name="item_category">
								<option value="한식">한식</option>
								<option value="양식">양식</option>
								<option value="중식">중식</option>
								<option value="일식">일식</option>
								<option value="샐러드" selected>샐러드</option>
							</select>
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input type="text" name="item_name" size="20" value="${item.item_name}"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="item_content">${item.item_content}</textarea></td>
				</tr>
				<tr>
					<th>가격</th>
					<td><input type="text" size="7" name="item_price" value="${item.item_price}">원</td>
					<!-- 문자열로 보내짐 -->
				</tr>
				<tr>
					<th>재고</th>
					<td><input type="text" size="5" name="item_quantity" value="${item.item_quantity}">개</td>
				</tr>
				<tr>
					<th>인분</th>
					<td><input type="text" size="3" name="item_total" value="${item.item_total}">(숫자만 입력하세요)</td>
				</tr>
				<tr>
					<th>조리시간</th>
					<td><input type="text" size="3" name="item_time" value="${item.item_time}">분</td>
				</tr>
				<tr>
					<th>메인 카테고리</th>
					<td><input type="text" size="20" name="item_main" value="${item.item_main}"></td>
				</tr>
				<tr>
					<th>판매량</th>
					<td><input type="text" size="3" name="item_sales" value="${item.item_sales}">개</td>
				</tr>
				<tr>
					<th>할인율</th>
					<td><input type="text" size="3" name="item_discount" value="<%=discount %>">%</td>
				</tr>
				<tr>
					<th>평점의 평균</th>
					<td><input type="text" size="3" name="item_starsAvg" value="${item.item_starsAvg}"></td>
					<td><input type="hidden" name="item_date" value="${item.item_date }"></td>
				</tr>
				<tr>
					<th>대표 사진</th>
					<td>
						<input type="file" name="uploadfiles"><br>
						(주의 사항: 이미지를 바꾸려고 할 때만 선택하세요.)									
					</td>
				</tr>
				<tr>
					<th>상세 사진</th>
					<td>
						<input type="file" name="uploadfiles"><br>
						(주의 사항: 이미지를 바꾸려고 할 때만 선택하세요.)									
					</td>
				</tr>
			</table><br>
			<input type="submit" value="수정" onclick="return itemCheck()">
			<input type="button" value="목록" onclick="location.href='itemListManagePage.do'">
		</form>
	</div>
</body>
</html>