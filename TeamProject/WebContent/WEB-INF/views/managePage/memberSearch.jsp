<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.co.EZHOME.dto.UserDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	if ("${message}" === "수정되었습니다") {
		alert("${message}");
	}
	if ("${message}" === "삭제되었습니다") {
		alert("${message}");
	}
	if ("${message}" === "오류 확인") {
		alert("${message}");
	}
</script>
</head>
<body>
<%
		Vector<UserDTO> vec = (Vector<UserDTO>) request.getAttribute("vec");
		String[] arr=(String[])request.getAttribute("arr");
	%>
	<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/sideManage.jsp"></jsp:include>
	<section>
<div style="width: 60%; margin-left: auto; margin-right: auto;">
			<h2>회원관리</h2>
			<br>
			<hr>
			<br>
			<div align="center">
	<form action="memberFind.do" method="post">
	<select name="type">
				<option value="userid" <%=arr[0]%>>아이디</option>
				<option value="name" <%=arr[1]%>>이름</option>
				<option value="phone" <%=arr[2]%>>전화번호</option>
			</select> <input type="text" name="key"> <input type="submit"
				value="검색">
	</form>
	</div>
	<br>
    <form action="memberOnepick.do" method="post">
	<table class="ezen">
	<thead>
	<tr>
		<th width="10%">아이디<br>
		비밀번호</th>
		<th width="10%">이름</th>
		<th width="10%">생년월일</th>
		<th>이메일<br>전화번호</th>
		<th>가입일</th>
		<th>주소</th>
		<th>포인트</th>
		<th width="5%">권한</th>
		<th width="5%">관리</th>
	</tr>
	</thead>
	<tbody>
    <%
				for (int i = 0; i < vec.size(); i++) {
					UserDTO udto = vec.get(i);
			%>
			
			<tr>
				<td><%=udto.getUserid()%><br>
				<%=udto.getPwd()%></td>
				<td><%=udto.getName()%></td>
				<td><%=udto.getBirth()%></td>
				<td><%=udto.getEmail()%><br>
				<%=udto.getPhone()%></td>
				<td><%=udto.getRegistDate()%></td>
				<td><%=udto.getAddr()%></td>
				<td><%=udto.getPoint()%></td>
				<td><%=udto.getAdmin()%></td>
				<td><button type="submit" name="update" value="<%=udto.getUserid()%>" class="table-btn">수정</button>
				<button type="submit" name="delete" value="<%=udto.getUserid()%>" formaction="memberDelete.do" method="post" class="table-btn">삭제</button></td>
			</tr>
			<%} %>
	</tbody>
	</table>
	</form>
	<br>
	<br>
</div>
	<br>
	<br>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>