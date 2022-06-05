<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" >
	var message = "<c:out value='${message}'/>";
	alert(message);
	window.location.href = "/TeamProject/login";
</script>
</head>
<body>
</body>
</html>