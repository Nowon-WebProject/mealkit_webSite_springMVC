<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var message = '${message}';
	
	alert(message);
	window.location.href = "itemAbout.do?&item_num=${param.item_num}&viewNumber=2";
</script>
</head>
<body>
	
</body>
</html>