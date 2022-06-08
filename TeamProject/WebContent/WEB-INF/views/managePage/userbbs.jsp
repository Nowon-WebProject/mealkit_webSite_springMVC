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
.cart {
	margin-left: auto;
	margin-right: auto;
	border: 1px solid orange;
}

.cart table {
	border: 1px solid orange;
	text-align: center;
	width: 100%;
}

.cart th {
	background-color: orange;
	border: 1px solid orange;
	white-space: nowrap;
}

.cart td {
	border: 1px solid orange;
	white-space: nowrap;
}

.cart tbody tr:nth-child(2n+1) {
	background-color: #F8AD7B;
}
</style>
<script type="text/javascript" src="js/sunwoo.js"></script>


</head>
<body>
<div id="wrap">
	<%
	Vector<BbsDTO> vec=(Vector<BbsDTO>)request.getAttribute("vec");
	int start = (int)request.getAttribute("start");
	int end = (int)request.getAttribute("end");
	int all = (int)request.getAttribute("all");
	String pageNum = (String)request.getAttribute("page");
	String[] arr=(String[])request.getAttribute("arr");
%>
<section>
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<div align="center">
		<br>
		<br> <b><font size="6" color="gray">공지 사항</font></b> <br>
		<br>
		<br>
	</div>
	<div class="cart">
		<table>
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
					<td><a href="javascript:method1('<%=bdto.getBbsid()%>')"><%=bdto.getBbstitle() %></a></td>
					<td><%=bdto.getUserid() %></td>
					<td><%=bdto.getBbsdate() %></td>
					<td><%=bdto.getBbscount() %></td>
				</tr>
				<%} %>

			</tbody>
		</table>
	</div>
	<br>
	<div align="center">
		<form action="/TeamProject/userBbs.do" method="post">
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
	</section>	
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</div>
</body>
</html>