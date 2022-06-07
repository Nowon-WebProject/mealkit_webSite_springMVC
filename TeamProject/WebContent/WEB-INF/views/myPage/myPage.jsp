<%@page import="kr.co.EZHOME.dto.UserDTO"%>
<%@page import="kr.co.EZHOME.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 마이페이지</title>
<link href="css/styles.css" rel="stylesheet" />
<style>
body{
	clear:both;
}
.mypage{
	text-align:center:
}
</style>
</head>
<body>
<%
	String name=(String)session.getAttribute("name");
	
%>
<%-- <jsp:include page="nav.jsp"></jsp:include>
<jsp:include page="side.jsp"></jsp:include> --%>

	<div class="mypage">
	<br>
	<script>
	 alert("<%=name%>님 안녕하세요!");
	</script>
	<br>
	<br>
	<jsp:include page="modifyOK.jsp"></jsp:include>
	</div>
<%-- <jsp:include page="footer.jsp"></jsp:include> --%>
</body>
</html>