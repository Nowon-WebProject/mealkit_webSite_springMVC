<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/libs/jquery-3.6.0.min.js"></script>
</head>
<body>
	<script type="text/javascript">
		var message = "<c:out value='${message}'/>";
		var phone = "<c:out value='${param.phone}'/>";
		if (message == "휴대폰 번호 인증이 완료되었습니다") {
			opener.frm.phoneValid.value = true;
			opener.frm.checkedPhone.value = phone;
			$(".phone", opener.document).attr("disabled", true);
		}
		alert(message);
		self.close();
	</script>
	
	
</body>
</html>