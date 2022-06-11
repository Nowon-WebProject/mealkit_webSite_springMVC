<%@page import="kr.co.EZHOME.dto.PostscriptDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#headline {
	font-family: sans-serif;
	font-size: 30px;
	color: rgb(56, 69, 170);
}

table {
	width: 780px;
	height: 550px;
}

td {
	border-bottom: 1px solid rgb(180, 180, 180);
}

img {
	width: 400px;
	height: 400px;
}
</style>
</head>
<body>
	<%
		String post_num = request.getParameter("post_num");						
		PostscriptDTO postscript = (PostscriptDTO)request.getAttribute("postscript");
	%>
	<table>
		<tr style="height:45px;">
			<td colspan="2" id="headline">자세히 보는 후기</td>
		</tr>
		<tr style="height:90px;">
			<td><%=postscript.getPost_content()%></td>
			<td style="width:20%; text-align:right; vertical-align: bottom;">
				조회: <%=postscript.getPost_hits()%>
				<br>
				작성일: <%=postscript.getPost_date()%>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<c:set var="image" value="<%=postscript.getPost_image()%>"></c:set>
				<c:if test="${image != null}">
					<img src="images/postscript/${image}">
				</c:if>
			</td>
		</tr>
	</table>
</body>
</html>