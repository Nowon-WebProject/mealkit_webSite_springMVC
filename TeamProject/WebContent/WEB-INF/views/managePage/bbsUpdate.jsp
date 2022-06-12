<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="kr.co.EZHOME.dto.BbsDTO" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 관리자페이지</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(
		function() {
			var admin = <%=(Integer)session.getAttribute("admin")%>
			if(admin != 1){
			alert("접근 권한이 없습니다.");
			location.href="index";
			}
		});
</script>
</head>
<body>
<%
	Vector<BbsDTO> vec=(Vector<BbsDTO>)request.getAttribute("vec");
	BbsDTO bdto = new BbsDTO();
	bdto=vec.get(0);
%>
<div id="wrap">
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/sideManage.jsp"></jsp:include>
<section style="width: 60%; margin-left: auto; margin-right: auto;">
	<div align="center">
			<br>
			<br>
			<h2>공지사항</h2>
			<button class="back-btn" onclick="history.back()" style="float:right">이전</button>
			<br>
			<hr>
    </div>
    <form action="bbsUpdate.do" method="post" encType="multipart/form-data">
	<div align="center">
	<table class="ezen">
    <thead>
        <tr>
            <th>공지사항 수정</th>
        </tr>
    </thead> 
    <tbody>	
			<tr>
			<td><input type="text" name="bbstitle" value="<%=bdto.getBbstitle() %>" maxlength="50" style="width:100%;"></td>
			</tr>
			<tr>
			<td><textarea name="bbscontent" maxlength="2048" style="width:100%; height:350px;"><%=bdto.getBbscontent()%></textarea></td>
			</tr>
    </tbody>
    </table>
    </div>
    <br>
    <br>
    	<input type="file" name="mediaFile"><br>
    <br>
    <br>
    <div align="right">
    <div style="width:100px">
    <input type="hidden" name="bbsid" value="<%=bdto.getBbsid()%>">
    <input type="submit" value="수정" class="back-btn">
    </div>
    </div>
    </form>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</div>
</body>
</html>