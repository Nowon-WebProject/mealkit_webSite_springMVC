<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.co.EZHOME.dto.UserDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.cart {
	overflow: auto;
	width: 1200px;
	height: 400px;
	margin-left: auto; margin-right: auto;
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
.cart tbody tr:nth-child(2n+1){
    background-color: 	#F8AD7B;
}
</style>

</head>
<body>
<%
		Vector<UserDTO> vec = (Vector<UserDTO>) request.getAttribute("vec");
		String[] arr=(String[])request.getAttribute("arr");
	%>
	
	<script type="text/javascript">	
		if("${message}" === "수정되었습니다"){alert("${message}");}
		if("${message}" === "삭제되었습니다"){alert("${message}");}
		if("${message}" === "오류 확인"){alert("${message}");}
	</script>
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="cart">
	<table>
    <thead>
        <tr>
            <th>이름</th>
           <th>아이디</th>
            <th>비밀번호</th>
            <th>생년월일</th>
            <th>이메일</th>
            <th>전화번호</th>
            <th>가입날자</th>
            <th>주소</th>
            <th>포인트</th>
            <th>권한</th>
            <th>관리</th>
        </tr>
    </thead>
    
    <tbody>
    <form action="memberOnepick.do" method="post">
    <%
				for (int i = 0; i < vec.size(); i++) {
					UserDTO udto = vec.get(i);
			%>
			
			<tr>
				<td><%=udto.getName()%></td>
				<td><%=udto.getUserid()%></td>
				<td><%=udto.getPwd()%></td>
				<td><%=udto.getBirth()%></td>
				<td><%=udto.getEmail()%></td>
				<td><%=udto.getPhone()%></td>
				<td><%=udto.getRegistDate()%></td>
				<td><%=udto.getAddr()%></td>
				<td><%=udto.getPoint()%></td>
				<td><%=udto.getAdmin()%></td>
				<td><button type="submit" name="update" value="<%=udto.getUserid()%>">수정</button>
				<button type="submit" name="delete" value="<%=udto.getUserid()%>" formaction="memberDelete.do" method="post">삭제</button></td>
			</tr>
			<%} %>
			</form>
    </tbody>
    </table>
    </div>
	<br>
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
	<br>
	<br>
	<br>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>

</body>
</html>