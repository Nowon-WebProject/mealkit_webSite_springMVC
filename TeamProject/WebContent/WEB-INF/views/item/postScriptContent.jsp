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

.content {
  border: none;
}

.content {
  resize: none;
}

.content:focus {
  outline: none;
}

textarea{
font-size:20px;
font-family:inherit;
}
</style>
</head>
<body>
	<%
		String post_num = request.getParameter("post_num");
		PostscriptDTO postscript = (PostscriptDTO) request.getAttribute("postscript");
	%>
	<div style="width:100%;height:300px;">
	<div style="width:30%;float:left;padding-right:100px;">
			<c:set var="image" value="<%=postscript.getPost_image()%>"></c:set>
			<c:if test="${image != null}">
				<img src="images/postscript/${image}" width="400" height="400">
			</c:if>
	</div>
	<div style="float:left;width:60%">
			<textarea class="content" rows="30" cols="65" readonly><%=postscript.getPost_content()%>
			</textarea>
	</div>
	</div>
</body>
</html>