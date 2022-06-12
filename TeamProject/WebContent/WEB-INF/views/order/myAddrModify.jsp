<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String addr = request.getParameter("my_deli_addr");

String postcode = addr.substring(1,6);
String addr1 = addr.substring(8,addr.lastIndexOf(","));
String addr2 = addr.substring(addr.lastIndexOf(",")+2);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="js/member.js"></script>
<style type="text/css">
th{
width:40%;
}
</style>
</head>
<div align="center">

	<form action="myAddrModify.do" method="post">
		<table>
			<tr>
				<th>배송지 별명</th>
				<td><input type="text" name="deli_nick"
					value="<%=request.getParameter("my_deli_nick")%>" required></td>
			</tr>
			<tr>
				<th>받으실 분</th>
				<td><input type="text" name="deli_name"
					 value="<%=request.getParameter("my_deli_name")%>" required></td>
			</tr>
			<tr>
				<th>받으실 곳</th>
				<td><input type="text" name="deli_postcode" id="sample4_postcode" value="<%=postcode%>" placeholder="우편번호" size="5"  required>
				<input type="button" id="daumPostCode" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" ><br>
				<input type="text" name="deli_addr1" id="sample4_roadAddress" value="<%=addr1%>" placeholder="도로명주소" size="30"  required><br>
				<input type="text" name="deli_addr2" id="sample4_detailAddress" value="<%=addr2%>" placeholder="상세주소"  required><br>
				<span id="guide" style="color: #999; display: none"></span>
				<input type="hidden" id="sample4_jibunAddress" placeholder="지번주소">
				<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
				<input type="hidden" id="sample4_engAddress" name="engAddr" placeholder="영문주소"  size="60" >
				</td>
			</tr>
			<tr>
				<th>휴대폰 번호</th>
				<td><input type="text" name="deli_phone" 
					value="<%=request.getParameter("my_deli_phone")%>" required></td>
			</tr>
			<tr>
				<th>배달<br>참고메세지</th>
				<td><input type="text" name="deli_msg" value="<%=request.getParameter("my_deli_msg")%>"></td>
			</tr>
			<tr>
				<th>공동현관<br>비밀번호</th>
				<td><input type="text" name="deli_pwd" size="35" value="<%=request.getParameter("my_deli_pwd")%>" placeholder="예) #1234*/ 열쇠버튼+abcd+OK버튼"></td>
			</tr>
		</table>
		<button type="button" onclick="history.back()" class="table-btn">이전</button>
		<input type="hidden" name="my_deli_addr_seq" value="<%=request.getParameter("my_deli_addr_seq")%>">
		<input type="submit" value="수정" class="confirm-btn">
	</form>
</div>
</body>
</html>