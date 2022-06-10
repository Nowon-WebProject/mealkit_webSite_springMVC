<%@page import="kr.co.EZHOME.dto.ItemDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 관리자페이지</title>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
<script type="text/javascript" src="js/item.js"></script>
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
</head>
<body>
	<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/sideManage.jsp"></jsp:include>
	<section>
		<div style="width: 60%; margin-left: auto; margin-right: auto;">
			<h2>상품 등록 - 관리자 페이지</h2>
			<br>
			<hr>
			<br>
		<form action="itemWriteDo" method="post" enctype="multipart/form-data" name="frm">
			<table class="ezen">
			<thead>
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
					<td><input type="text" name="item_name" size="20"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="item_content"></textarea></td>
				</tr>
				<tr>
					<th>가격</th>
					<td><input type="text" size="7" name="item_price">원</td>
				</tr>
				<tr>
					<th>재고</th>
					<td><input type="text" size="5" name="item_quantity">개</td>
				</tr>
				<tr>
					<th>인분</th>
					<td><input type="text" size="3" name="item_total">(숫자만 입력하세요)</td>
				</tr>
				<tr>
					<th>조리시간</th>
					<td><input type="text" size="3" name="item_time">분</td>
				</tr>
				<tr>
					<th>메인 카테고리</th>
					<td><input type="text" size="20" name="item_main"></td>
				</tr>
				<tr>
					<th>할인율</th>
					<td><input type="text" size="3" name="item_discount">%</td>
				</tr>
				<tr>
					<th>대표 사진</th>
					<td><input type="file" name="uploadfiles" multiple><br>
						(주의 사항: 이미지를 넣으려고 할 때만 선택하세요.)
					</td>
				</tr>
				<tr>
					<th>상세 사진</th>
					<td><input type="file" name="uploadfiles" multiple><br>
						(주의 사항: 이미지를 넣으려고 할 때만 선택하세요.)
					</td>
				</tr>
				</thead>
			</table><br>
			<div align="center">
			<input type="submit" value="등록" onclick="return itemCheck()" class="back-btn">
			<input type="reset" value="다시 작성" class="back-btn">
			<input type="button" value="목록" onclick="location.href='itemListManagePage'" class="back-btn">
			</div>
		</form>
		<br>
		</div>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>