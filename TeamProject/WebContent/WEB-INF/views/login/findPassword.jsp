<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table{
		margin:auto;

	}
	.title{
		margin: auto;
		text-align: center;
		font-size: 6px;
		font-color: gray;
	}
	
	section {
		width:1000px;
		margin-left:auto; 
        margin-right:auto;
        margin-bottom: 10px;
	}
</style>
<script type="text/javascript" src="js/libs/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="js/member.js?test=10"></script>
</head>
<body>
	<div id="Wrap">
		<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
			<section>
				<div align="center"><b><font size="6" color="gray">비밀 번호 찾기</font></b></div>
				<hr>
				<form action="findPassword.do" method="post" name="frm">
					<table>
						<tr>
							<td>
								이름<br>
								<input type="text" name="name">
							</td>
						<tr>
						<tr>
							<td>
								아이디 <br>
								<input type="text" name="userid">
							</td>
						<tr>
						<tr>
							<td>
								휴대폰 번호 <br>
								<input type='tel' class="phone" name='phone' maxlength="13"/>
								<!-- findId의 경우 phonCheck에 매개변수 1을 넘긴다 -->				
								<input type="button" value="인증번호 받기" onclick="return phoneCheck(1)">
								<input type="hidden" id="phoneValid" name="phoneValid" value="false" size="20">
								<input type="hidden" name="checkedPhone">
							</td>
						<tr>
						<tr>
							<td colspan="2">
								<input type="submit" value="비밀번호 찾기" onclick="return findPassword()">
							</td>
						</tr>
					</table>
				</form>
			</section>
		<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>