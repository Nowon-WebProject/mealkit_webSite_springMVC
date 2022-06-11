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
<link rel="stylesheet" type="text/css" href="css/style.css">
<script type="text/javascript" src="js/item.js"></script>
<style type="text/css">
.mw {
	position: fixed;
	_position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
	z-index: 1
}

.mw .bg {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	opacity: .5;
	filter: alpha(opacity = 50)
}

.mw .fg {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 1000px;
	height: 500px;
	padding: 20px;
	border: 3px solid #ccc;
	background: #fff;
	transform: translateX(-50%) translateY(-50%);
}
</style>
</head>
<body>
	<%
		PageDTO pageDTO = (PageDTO)request.getAttribute("page");
		int number = pageDTO.getStartRow();
		int startPage = pageDTO.getStartPage();
		int endPage = pageDTO.getEndPage();
		int pageSize = pageDTO.getPageSize();
		int pageCount = pageDTO.getPageCount();
		int pageNum = pageDTO.getPageNum();
		if(pageNum == 0){
			pageNum = 1;
		}
		
		String check = (request.getAttribute("postscripts").toString());
		if (!check.equals("[]")) {
	%>
	<div align="right">
	※ 제목을 클릭하시면 후기를 자세히 볼 수 있습니다.
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
	</div>
			<table class="ezen">
			<thead>
			<tr>
				<th>번호</th>
				<th class="title">제목</th>
				<th>회원</th>
				<th>작성일</th>
				<th>도움</th>
				<th>조회</th>
				<th>평점</th>
			</tr>
			</thead>
			<c:forEach var="post" items="${postscripts}">
				<tr>
					<td width="5%" align="center"><%=number++ %></td>
					<td class="title" onclick="javascript:displayContent('js_detail${post.post_num}', '${post.post_num}')">${post.post_subject}</td>
					<td width="10%" align="center">${post.post_writer}</td>
					<td width="10%" align="center">${post.post_date}</td>
					<td width="5%" align="center">${post.post_help}</td>
					<td width="5%" align="center">${post.post_hits}</td>
					<td width="10%" align="center">
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
					<iframe id="frame" name="manage" src="postScriptContent?post_num=${post.post_num}" frameborder="0" scrolling="no" width="100%" height="500px"></iframe>
					<div style="float:right">
						<a href="javascript:helpful('${post.post_num}', '${param.item_num }', '${userid }')" style="width:90px; height:50px; background-color:#1E90FF; border-radius:5px;color:white;text-decoration:none"><i class="bi-hand-thumbs-up-fill"></i>도움됐어요</a>
						<input type="button" value="지우기" onclick="javascript:deleteOK('${post.post_num}', '${post.post_writer}', '${userid}', ${param.item_num }, ${admin})" class="page">
					</div>
					</td>
				</tr>
			</c:forEach>
				</table>
		<div>
		<p><button type="button" onClick="document.getElementById('mw_temp').style.display='block'"class="back-btn"  style="width:100px; height:25px; background-color:#FF6347; border-radius:5px;color:white;text-decoration:none;float:right">후기 작성</button></p>
		<div id="mw_temp" class="mw">
 	 	  <div class="bg"><!--이란에는 내용을 넣지 마십시오.--></div>
			<div class="fg">
			<div style="float:right">
					<i style="font-size:30px; cursor:pointer; user-select: none" class="bi-x-lg"onclick="document.getElementById('mw_temp').style.display='none'"></i>
					</div>
			<h2>후기 작성</h2>
				<form action="postWriteDo" method="post" name="postWriteForm" enctype="multipart/form-data">
					<table class="ezen" style="width:100%">
								<tr>
									<td>제목 <input type="text" name="post_subject" size="40" maxlength="25" required></td>
								</tr>
								<tr>
									<td>평점 <select name="post_stars">
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
									<td>사진 첨부 <input type="file" name="file"></td>
								</tr>
							</table>
							<br>
								<textarea name="post_content" rows="10"	cols="120" required style="resize: none;"></textarea>
							<div style="float:right">
							<input type="submit" value="작성하기" onclick="return checkUserid()" class="back-btn">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value="다시 쓰기" class="back-btn">&nbsp;&nbsp;&nbsp;
							<input type="hidden" name="post_writer" value="${userid }">
							<input type="hidden" name="item_num" value="${param.item_num }">
							</div>
				</form>
					</div>
			</div>
		</div>
	
    	<div align="center">
        <h4>
		<%
			// 아래는 페이지 표시 과정

			if (startPage > 10) {
		%>
		<a href="itemAbout.do?pageNum=<%=startPage - 10 %>&item_num=${ilist[0].item_num}&viewNumber=2""  style="color:black;"><i class="bi-chevron-compact-left"></i></a>
		<%
			}
			for (int i = startPage; i <= endPage; i++) {
				if(pageNum == i){
					%>
		<a href="itemAbout.do?pageNum=<%=i %>&item_num=${ilist[0].item_num}&viewNumber=2" style="color:white;background-color:gray;border-radius:75px;text-decoration-line: none;">　<%=i %>　</a>
		<%
				}else{
					%>
		<a href="itemAbout.do?pageNum=<%=i %>&item_num=${ilist[0].item_num}&viewNumber=2" style="color:black;text-decoration-line: none;">　<%=i %>　</a>
					
					<%
				}
			}
			if (endPage < pageCount) {
		%>
		<a href="itemAbout.do?pageNum=<%=startPage + 10 %>&item_num=${ilist[0].item_num}&viewNumber=2" style="color:black;"><i class="bi-chevron-compact-right"></i></a>
		<%
			}
		%>
		</h4>
		</div>
				<%}else{%>
			<br>
			<br>
			<br>
			<div align="center">
			<i style="font-size:200px;color:orange" class="bi-chat-dots"></i>
			<div style="font-size:30px;color:gray">후기가 없습니다.</div>
			</div>
			<br>
			<div align="center">
				<p><button type="button" onClick="document.getElementById('mw_temp').style.display='block'"class="back-btn"  style="width:300px; height:100px; background-color:#FF6347; border-radius:5px;color:white;text-decoration:none; font-size:20pt">첫번째 후기를<br>작성해주세요!</button></p>
			</div>
		<div id="mw_temp" class="mw">
 	 	  <div class="bg"><!--이란에는 내용을 넣지 마십시오.--></div>
			<div class="fg">
			<div style="float:right">
					<i style="font-size:30px; cursor:pointer; user-select: none" class="bi-x-lg"onclick="document.getElementById('mw_temp').style.display='none'"></i>
					</div>
			<h2>후기 작성</h2>
				<form action="postWriteDo" method="post" name="postWriteForm" enctype="multipart/form-data">
					<table class="ezen" style="width:100%">
								<tr>
									<td>제목 <input type="text" name="post_subject" size="40" maxlength="25" required></td>
								</tr>
								<tr>
									<td>평점 <select name="post_stars">
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
									<td>사진 첨부 <input type="file" name="file"></td>
								</tr>
							</table>
							<br>
								<textarea name="post_content" rows="10"	cols="120" required style="resize: none;"></textarea>
							<div style="float:right">
							<input type="submit" value="작성하기" onclick="return checkUserid()" class="back-btn">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value="다시 쓰기" class="back-btn">&nbsp;&nbsp;&nbsp;
							<input type="hidden" name="post_writer" value="${userid }">
							<input type="hidden" name="item_num" value="${param.item_num }">
							</div>
				</form>
					</div>
			</div>
		<%} %>

</body>
</html>