<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	alert("후기글 삭제가 완료되었습니다");
	
	window.location.href = "itemAbout.do?&item_num=${param.item_num}&viewNumber=2";
</script>
</body>
</html>