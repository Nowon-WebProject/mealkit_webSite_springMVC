<%@page import="kr.co.EZHOME.dto.PageDTO"%>
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
<script type="text/javascript" src="js/item.js"></script>
<body>
	<%
		PageDTO pageDTO = (PageDTO)request.getAttribute("page");
		int number = pageDTO.getStartRow();
		int startPage = pageDTO.getStartPage();
		int endPage = pageDTO.getEndPage();
		int pageSize = pageDTO.getPageSize();
		int pageCount = pageDTO.getPageCount();
	%>
	<div id="wrap" style="width: 800px" align="center">
<!-- 		<h3>후기</h3> -->
		<table class="list">
			<tr>
				<td colspan="7" style="border: white; text-align: right;">
					<c:set var="order" value="${order }"></c:set>
					<c:choose>
						<c:when test="${order == 1}">
							<select onchange="window.open(value, '_self');">
								<option value="itemAbout.do?order=1&item_num=${ilist[0].item_num}&viewNumber=2" selected>최근등록순</option>
								<option value="itemAbout.do?order=2&item_num=${ilist[0].item_num}&viewNumber=2">도움많은순</option>
								<option value="itemAbout.do?order=3&item_num=${ilist[0].item_num}&viewNumber=2">조회많은순</option>
							</select>
						</c:when>
						<c:when test="${order == 2}">
							<select onchange="window.open(value, '_self');">
								<option value="itemAbout.do?order=1&item_num=${ilist[0].item_num}&viewNumber=2">최근등록순</option>
								<option value="itemAbout.do?order=2&item_num=${ilist[0].item_num}&viewNumber=2" selected>도움많은순</option>
								<option value="itemAbout.do?order=3&item_num=${ilist[0].item_num}&viewNumber=2">조회많은순</option>
							</select>
						</c:when>
						<c:when test="${order == 3}">
							<select onchange="window.open(value, '_self');">
								<option value="itemAbout.do?order=1&item_num=${ilist[0].item_num}&viewNumber=2">최근등록순</option>
								<option value="itemAbout.do?order=2&item_num=${ilist[0].item_num}&viewNumber=2">도움많은순</option>
								<option value="itemAbout.do?order=3&item_num=${ilist[0].item_num}&viewNumber=2" selected>조회많은순</option>
							</select>
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>번호</td>
				<td class="title">제목</td>
				<td>회원</td>
				<td>작성일</td>
				<td>도움</td>
				<td>조회</td>
				<td>평점</td>
			</tr>
			<c:forEach var="post" items="${postscripts}">
				<tr>
					<td><%=number++ %></td>
					<td class="title" onclick="javascript:displayContent('js_detail${post.post_num}', '${post.post_num}')">${post.post_subject}</td>
					<td>${post.post_writer}</td>
					<td>${post.post_date}</td>
					<td>${post.post_help}</td>
					<td>${post.post_hits}</td>
					<td>
					<!-- 별 그림 출처: https://hwasin.tistory.com/9 -->
						<c:set var="stars" value="${post.post_stars}"/>
						<c:choose>
							<c:when test="${stars == 5}">
								<i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i>
							</c:when>
							<c:when test="${stars >= 4.5}">
								<i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-half"></i>
							</c:when>
							<c:when test="${stars >= 4.0}">
								<i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star"></i>
							</c:when>
							<c:when test="${stars >= 3.5}">
								<i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-half"></i><i style="color: orange;" class="bi-star"></i>
							</c:when>
							<c:when test="${stars >= 3.0}">
								<i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i>
							</c:when>
							<c:when test="${stars >= 2.5}">
								<i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-half"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i>
							</c:when>
							<c:when test="${stars >= 2.0}">
								<i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i>
							</c:when>
							<c:when test="${stars >= 1.5}">
								<i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star-half"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i>
							</c:when>
							<c:when test="${stars >= 1.0}">
								<i style="color: orange;" class="bi-star-fill"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i>
							</c:when>
							<c:when test="${stars >= 0.5}">
								<i style="color: orange;" class="bi-star-half"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i>
							</c:when>
							<c:otherwise>
								<i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i><i style="color: orange;" class="bi-star"></i>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr id="js_detail${post.post_num}" style="display: none;">
					<td colspan="7">
						<div style="width: 75%; margin: 0 auto;">${post.post_content}</div>
						<input type="button" value="도움됐어요" onclick="javascript:helpful('${post.post_num}', '${param.item_num }', '${userid }')">
						<br>
						<input type="button" value="지우기" onclick="javascript:deleteOK('${post.post_num}', '${post.post_writer}', '${userid}', ${param.item_num }, ${admin})">
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="7" id="js_detail_write" style="display: none;">
					<form action="postWriteDo" method="post" name="postWriteForm" enctype="multipart/form-data">
						<table>
							<tr>
								<th>제목:</th>
								<td><input type="text" name="post_subject" size="40" maxlength="25"></td>
							</tr>
							<tr>
								<th>평점:</th>
								<td>
									<select name="post_stars">
										<option value="0">0</option>
										<option value="0.5">0.5</option>
										<option value="1.0">1</option>
										<option value="1.5">1.5</option>
										<option value="2.0">2</option>
										<option value="2.5">2.5</option>
										<option value="3.0">3</option>
										<option value="3.5">3.5</option>
										<option value="4.0">4</option>
										<option value="4.5">4.5</option>
										<option value="5.0" selected>5</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>내용:</th>
								<td><textarea name="post_content"></textarea></td>
							</tr>
							<tr>
								<th>사진:</th>
								<td><input type="file" name="file"></td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="submit" value="작성하기" onclick="return checkUserid()">&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="reset" value="다시 쓰기">
									<input type="hidden" name="post_writer" value="${userid }">
									<input type="hidden" name="item_num" value="${param.item_num }">
								</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="7" style="border: white; text-align: right;">
					<a href="javascript:displayWrite('js_detail_write')">후기 쓰기</a>
				</td>
			</tr>
		</table>
		<br> <br>
		<%				
			// 아래는 페이지 표시 과정
			if (startPage > 10) {
		%>
		<a href="itemAbout.do?pageNum=<%=startPage - 10 %>&item_num=${ilist[0].item_num}&viewNumber=2">[이전]</a>
		<%
			}
			for (int i = startPage; i <= endPage; i++) {
		%>
		<a href="itemAbout.do?pageNum=<%=i %>&item_num=${ilist[0].item_num}&viewNumber=2">[<%=i %>]
		</a>
		<%
			}
			if (endPage < pageCount) {
		%>
		<a href="itemAbout.do?pageNum=<%=startPage + 10 %>&item_num=${ilist[0].item_num}&viewNumber=2">[다음]</a>
		<%
			}
		%>
		<br> <br>
	</div>
</body>
</html>