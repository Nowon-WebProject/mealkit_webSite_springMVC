<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="js/member.js"></script>
<style type="text/css">
input{
border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px
}

button{
border: 0;
}
</style>
	
</head>
<div align="center" id="manage">
<br>
	나의 배송지
	<hr>
	<%
		if ((int) session.getAttribute("myaddrcnt") != 0) {
	%>
	<table width="100%">
		<c:forEach var="addr" items="${malist}" begin="0" end="4" step="1" varStatus="i">
			<tr align="left">
				<td width="80%"><i style="font-size: 20px; color: orange"
					class="bi-geo-alt-fill"></i><strong>배송지 명</strong> : ${addr.my_deli_nick}</td>
				<td width="10%">
				<form action="myAddrModify" method="get">
				<input type="hidden" name="my_deli_addr_seq" value="${addr.my_deli_addr_seq}">
				<input type="hidden" name="my_deli_nick" value="${addr.my_deli_nick}">
				<input type="hidden" name="my_deli_name" value="${addr.my_deli_name}">
				<input type="hidden" name="my_deli_addr" value="${addr.my_deli_addr}">
				<input type="hidden" name="my_deli_phone" value="${addr.my_deli_phone}">
				<input type="hidden" name="my_deli_msg" value="${addr.my_deli_msg}">
				<input type="hidden" name="my_deli_pwd" value="${addr.my_deli_pwd}">
				<input class="table-btn" type="submit" value="수정">
				</form>
				</td>
				<td width="10%">
				<form action="myAddrDelete.do" method="post">
				<input type="hidden" name="my_deli_addr_seq" value="${addr.my_deli_addr_seq}">
				<input class="table-btn" type="submit" value="삭제">
				</form>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left" width="85%">
				${addr.my_deli_name}<br>
				${addr.my_deli_addr}
				<td width="15%">
				<button class="confirm-btn" type="button" onclick="selectMyAddr(${i.index})">선택</button>
				</td>
			</tr>
			<script type="text/javascript">
function selectMyAddr(i){
	window.parent.selectMyAddr(i);
}

</script>
				</c:forEach>
	</table>
	<hr>
	나의 배송지는 5개까지 관리가 가능합니다.
	<hr>
	<%
	} else {
		%>
		<div align="center">
			<i style="font-size:200px;color:orange" class="bi-geo-alt-fill"></i>
			<div style="font-size:30px;color:gray">저장된 배송지가 없습니다.</div>
		</div>
	<hr>
	<%
	}
	%>
	<button type="button" onclick="location.href='/TeamProject/myAddrInsert'" class="table-btn">+ 배송지 추가하기</button>
</div>
<input type="hidden" id="name_0" value="${malist[0].my_deli_name}"><br>
<input type="hidden" id="addr_0" value="${malist[0].my_deli_addr}">
<input type="hidden" id="phone_0" value="${malist[0].my_deli_phone}">
<input type="hidden" id="msg_0" value="${malist[0].my_deli_msg}">
<input type="hidden" id="pwd_0" value="${malist[0].my_deli_pwd}">
<input type="hidden" id="name_1" value="${malist[1].my_deli_name}"><br>
<input type="hidden" id="addr_1" value="${malist[1].my_deli_addr}">
<input type="hidden" id="phone_1" value="${malist[1].my_deli_phone}">
<input type="hidden" id="msg_1" value="${malist[1].my_deli_msg}">
<input type="hidden" id="pwd_1" value="${malist[1].my_deli_pwd}">
<input type="hidden" id="name_2" value="${malist[2].my_deli_name}"><br>
<input type="hidden" id="addr_2" value="${malist[2].my_deli_addr}">
<input type="hidden" id="phone_2" value="${malist[2].my_deli_phone}">
<input type="hidden" id="msg_2" value="${malist[2].my_deli_msg}">
<input type="hidden" id="pwd_2" value="${malist[2].my_deli_pwd}">
<input type="hidden" id="name_3" value="${malist[3].my_deli_name}"><br>
<input type="hidden" id="addr_3" value="${malist[3].my_deli_addr}">
<input type="hidden" id="phone_3" value="${malist[3].my_deli_phone}">
<input type="hidden" id="msg_3" value="${malist[3].my_deli_msg}">
<input type="hidden" id="pwd_3" value="${malist[3].my_deli_pwd}">
<input type="hidden" id="name_4" value="${malist[4].my_deli_name}"><br>
<input type="hidden" id="addr_4" value="${malist[4].my_deli_addr}">
<input type="hidden" id="phone_4" value="${malist[4].my_deli_phone}">
<input type="hidden" id="msg_4" value="${malist[4].my_deli_msg}">
<input type="hidden" id="pwd_4" value="${malist[4].my_deli_pwd}">
</body>
</html>