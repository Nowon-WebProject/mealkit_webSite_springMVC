<%@page import="kr.co.EZHOME.beans.TestBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 
<script type="text/javascript">
	var testBean2 = "<c:out value='${TestBean}'/>";
	var a = testBean2.getA();
	var b = testBean2.getB();
</script>
 -->
</head>
<body>

	<%
		TestBean testBean = (TestBean) request.getAttribute("TestBean");
		int a = testBean.getA();
		int b = testBean.getB();
	%>
	a =
	<%=a%>
	b =
	<%=b%>

</body>
</html>