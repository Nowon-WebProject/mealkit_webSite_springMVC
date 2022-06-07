<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/ui/side.jsp"></jsp:include>
	<form>
		<div align="center"><h1>정상적으로 탈퇴되었습니다.
		<br>
		저희 「이젠, 집에서」를 이용해주셔서 감사합니다.</h1></div>
		<!-- <input type="submit" value="네" onclick=""> -->
		${deleteCheck}
	</form>
<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</body>
</html>