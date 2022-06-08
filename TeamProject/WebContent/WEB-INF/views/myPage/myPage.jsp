<%@page import="kr.co.EZHOME.dto.UserDTO"%>
<%@page import="kr.co.EZHOME.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String name = (String) session.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 마이페이지</title>
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/member.js"></script>
<style>
body{
	clear:both;
	}
/*
.mypage{
	text-align:center:
} */


#wrap {
	min-height: 100vh;
	position: relative;
	width: 100%;
}

footer {
	width: 100%;
	height: 110px; /* 내용물에 따라 알맞는 값 설정 */
	bottom: 0px;
	position: absolute;
}

section {
	padding-bottom: 110px;
}
</style>
<script>
	alert("<%=name%>님 안녕하세요!");
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
		<jsp:include page="/WEB-INF/views/ui/side.jsp"></jsp:include>
		<section align="center"
			style="width: 60%; margin-left: auto; margin-right: auto;">
		</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>