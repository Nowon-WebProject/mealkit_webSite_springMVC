<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 로그아웃 -->
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
	<%
		//session.removeAttribute("id");
		//session.removeAttribute("name");
		//session.removeAttribute("pw");
		//session.removeAttribute("email");
		//session.removeAttribute("phone");
		//session.removeAttribute("admin");
		session.invalidate(); 
		response.sendRedirect("login");
	%>
<%-- 아이디<%=session.getAttribute("id") %>
이름<%=session.getAttribute("name") %> --%>
</body>
</html>