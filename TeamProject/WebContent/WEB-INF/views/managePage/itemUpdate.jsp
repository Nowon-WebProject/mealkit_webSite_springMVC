<%@page import="kr.co.EZHOME.dto.ItemDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 관리자페이지</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
<link rel="stylesheet" type="text/css" href="css/style.css">
<script type="text/javascript" src="js/item.js"></script>
<script type="text/javascript">
$(document).ready(
		function() {
			var admin = <%=(Integer)session.getAttribute("admin")%>
			if(admin != 1){
			alert("접근 권한이 없습니다.");
			location.href="index";
			}
		});
   $("#select").change(function () {
	$("#form1").hide();
	$('#form' + $(this).find('option:selected').attr('id')).show();
});
</script>
<style type="text/css">
table{
text-align:center !important;
}
th{
background-color:orange;
padding:20px;
}
</style>
</head>
<body>
<%
	ItemDTO itemDTO = (ItemDTO) request.getAttribute("item");
	int discount = (int)(itemDTO.getItem_discount() * 100);
%>
<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/sideManage.jsp"></jsp:include>
	<section>
	<div style="width: 60%; margin-left: auto; margin-right: auto;">
	<div align="left">
			<h2>상품 수정 - 관리자페이지</h2>
			<br>
			<hr>
			</div>
		<form action="itemUpdateDo" method="post" enctype="multipart/form-data" name="frm">
			<input type="hidden" name="item_num" value="${item.item_num}">
			<input type="hidden" name="nonmakeImg1" value="${item.item_pictureUrl1}">
			<input type="hidden" name="nonmakeImg2" value="${item.item_pictureUrl2}">
			
			<div align="center">
			<table class="ezen">
			<thead>
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
					<select name="item_category" id="select">
						<option value="new" id="1">새로입력</option>
						<c:forEach var="category" items="${categoryList}" >
       					<option value="${category.item_category}">${category.item_category}</option>
         				</c:forEach>
					</select>   
				<div id="form1">
					<input type="text" name="newCategory" size="10" placeholder="카테고리">
				</div>
<script type="text/javascript">
   $("#select").change(function () {
	$("#form1").hide();
	$('#form' + $(this).find('option:selected').attr('id')).show();
});
</script>
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
					<th>할인율</th>
					<td><input type="text" size="3" name="item_discount" value="<%=discount %>">%</td>
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
				</thead>
			</table><br>
			</div>
			
			
			<div align="center">
			<input type="submit" value="수정" onclick="return itemCheck()" class="back-btn">
			<input type="button" value="목록" onclick="location.href='itemListManagePage.do'" class="back-btn">
			</div>
		</form>
	</div>
	<br>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>