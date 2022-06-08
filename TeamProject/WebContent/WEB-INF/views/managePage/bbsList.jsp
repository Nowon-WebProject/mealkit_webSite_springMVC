<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.EZHOME.dto.BbsDTO"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

</style>
<script type="text/javascript" src="js/sunwoo.js"></script>
</head>
<body>

	<%
	Vector<BbsDTO> vec=(Vector<BbsDTO>)request.getAttribute("vec");
	int start = (int)request.getAttribute("start");
	int end = (int)request.getAttribute("end");
	int all = (int)request.getAttribute("all");
	String pageNum = (String)request.getAttribute("page");
	String[] arr=(String[])request.getAttribute("arr");
%>
	<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/sideManage.jsp"></jsp:include>
	<section style="width: 60%; margin-left: auto; margin-right: auto;">
			<h2>공지사항 관리</h2>
			<br>
			<hr>
			<br>
	
		<table class="ezen">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<vec.size();i++){
    		BbsDTO bdto=vec.get(i);		
    %>
				<tr>
					<td><%=bdto.getBbsid() %></td>
					<td><a href="javascript:method('<%=bdto.getBbsid()%>')"><%=bdto.getBbstitle() %></a></td>
					<td><%=bdto.getUserid() %></td>
					<td><%=bdto.getBbsdate() %></td>
					<td><%=bdto.getBbscount() %></td>
				</tr>
				<%} %>

			</tbody>
		</table>
	<br>
	<div align="center">
		<form action="bbsList.do" method="post">
			<% if((start / 10) != 0){%>
			<span><button type="submit" name="page"
					value="<%=start - 10 %>">이전</button></span>
			<%} %>
			<% for(int i=start;i<=end;i++){%>
			<span><input type="submit" value="<%=i %>" name="page"></span>
			<%} %>
			<% if(all > end){%>
			<span><button type="submit" name="page"
					value="<%=start + 10 %>">다음</button></span>
			<%} %>
			<br> <br> <select name="size">
				<option value="10" <%=arr[0] %>>10</option>
				<option value="15" <%=arr[1] %>>15</option>
				<option value="20" <%=arr[2] %>>20</option>
			</select> <input type="hidden" value="<%=pageNum%>" name="page"> <input
				type="submit" value="페이지씩 보기">
		</form>
	</div>
	
	<div align="right">
		<h2>
			<a href="bbsWrite">글쓰기</a>
		</h2>
	</div>
	<br>
	<br>
	<br>
	<br>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</div>
</body>
</html>