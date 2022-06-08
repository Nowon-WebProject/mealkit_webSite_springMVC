<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/sunwoo.js"></script>
</head>
<body>
	<div id="wrap">
	<section>
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<br>
	<br>
	<br>
	<br>
	<br>
	<%
		
	%>

	<div align="center">
		<h2>관리자 페이지</h2>
		<br>
		<br>
		 <form action="memberSearch.do" method="post"> 
		<input type="submit" value="회원관리">
		<input type="submit" formaction="bbsList.do" value="공지사항관리">
		 </form>
		<br> <br>
		<button onclick="location.href='itemWriteGo.do'">제품등록</button>
		<br> <br>
		<button onclick="location.href='refundManage.do?pageSize=10&pageNum=1&category=userid&keyword='">취소환불 관리</button>
		<br> <br>
		<button onclick="location.href='orderManage.do?pageSize=10&pageNum=1&category=userid&keyword='">배송상태 관리</button>
	</div>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>