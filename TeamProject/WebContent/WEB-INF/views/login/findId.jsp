<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 아이디찾기</title>
<script type="text/javascript" src="js/libs/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="js/member.js?test=11"></script>
</head>
<body>
	<div id="Wrap">
		<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
			<section>
			<br><br><br><br><br>
			<div style="width: 30%; margin-left: auto; margin-right: auto;" align="center">
			<h2>아이디 찾기</h2>
			<br>
			<hr>
			<br>
				<form action="findId.do" method="post" name="frm">
					<table>
						<tr>
							<td>
								이름
							</td>
							<td>
								<input type="text" name="name" size="5">
							</td>
						</tr>
						<tr>
							<td>　</td>
						</tr>
						<tr>
							<td>
								휴대폰 번호 </td>
								
								<td> <input type='tel' class="phone" name='phone' maxlength="13" size="13"/>
								<!-- findId의 경우 phonCheck에 매개변수 1을 넘긴다 -->				
								<input type="button" value="인증번호 받기" onclick="return phoneCheck(1)" class="page">
								<input type="hidden" id="phoneValid" name="phoneValid" value="false" size="20">
								<input type="hidden" name="checkedPhone">
							</td>
						</tr>
					</table>
					<br><br><br>
					<button class="back-btn" onclick="history.back()" style="float:center">이전</button>
					<input type="submit" value="확인" onclick="return findId()" class="back-btn" style="float:center">
				</form>
				</div>
			</section>
		<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>