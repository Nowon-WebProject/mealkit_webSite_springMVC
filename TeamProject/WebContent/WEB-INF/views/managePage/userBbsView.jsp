<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="kr.co.EZHOME.dto.BbsDTO" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 공지사항</title>
<script type="text/javascript" src="js/sunwoo.js"></script>
<style>
</style>
</head>
<body>
<div id="wrap">
<%
	Vector<BbsDTO> vec=(Vector<BbsDTO>)request.getAttribute("vec");
	BbsDTO bdto = new BbsDTO();
	bdto=vec.get(0);
	String file = (String) request.getAttribute("file");
%>
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
<section style="width: 60%; margin-left: auto; margin-right: auto;">
	<div align="center">
			<br>
			<br>
			<h2>공지사항</h2>
			<button class="back-btn" onclick="history.back()" style="float:right">이전</button>
			<br>
			<hr>
    </div>
    <p style="align:left; margin-left: 20px;"> 조회수 : <%=bdto.getBbscount() %></p>
	<div class="cart">
	<table class="ezen">
    <thead>
        <tr>
            <th>공지사항</th>
        </tr>
    </thead> 
    <tbody>	
			<tr>
			<td><%=bdto.getBbstitle() %></td>
			</tr>
			<tr>
			<td style="vertical-align:top"height="400px">
			<%if(file != ""){%>
			<img src="images/board/${file }" style = "heigth:auto;"></img><br>
			<%} %>
			<%=bdto.getBbscontent() %>
			</td>
			</tr>
    </tbody>
    </table>
    </div>
    </section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</div>
</body>
</html>