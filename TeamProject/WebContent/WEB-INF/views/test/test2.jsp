<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 회원가입</title>
<link href="css/styles.css" rel="stylesheet" />
</head>
<body>
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
<script type="text/javascript">
	var year = "20231129";
	var date = new Date();
	alert(date.getFullYear()-year.slice(0,4));
	alert(year.slice(0,4));
</script>
<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</body>
</html>