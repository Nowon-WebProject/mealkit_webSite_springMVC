<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="kr.co.EZHOME.domain.DataStatus" %>
<!DOCTYPE html>
<!-- id 중복 확인 페이지 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/member.js?test=1"></script>
</head>
<body>
<h2>아이디 중복 확인</h2>

<form action="idCheck.do" method="get" name="frm">

	아이디<input type="text" name="userid" value="${param.userid}">
	    <input type="submit" value="중복 체크"><br>
	
	<c:if test="${result == DataStatus.Invalid_InputValue}">
		<script type="text/javascript">
			opener.document.frm.userid.value="";
		</script>
		아이디는 4글자 이상이어야만 합니다.
	</c:if>

	<c:if test="${result == DataStatus.Exist }">
		<script type="text/javascript">
			opener.document.frm.userid.value="";
		</script>
		${param.userid}는 이미 사용 중인 아이디입니다.
	</c:if>
		
	<c:if test="${result == DataStatus.Not_Exist }">
		${param.userid}는 사용 가능한 아이디입니다.
		<input type="button" value="사용" onclick="idok('${param.userid}')">
	</c:if>

</form>

</body>
</html>