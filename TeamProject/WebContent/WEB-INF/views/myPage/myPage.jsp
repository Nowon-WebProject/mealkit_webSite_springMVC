<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<!-- 마이페이지 -->
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 회원가입</title>
<link href="css/styles.css" rel="stylesheet" />
</head>
<body>
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>

	<div align="center">
	<%= session.getAttribute("name")%>님 안녕하세요<br>
	<a href ="#">회원정보 수정</a>
	</div>
<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</body>
</html>