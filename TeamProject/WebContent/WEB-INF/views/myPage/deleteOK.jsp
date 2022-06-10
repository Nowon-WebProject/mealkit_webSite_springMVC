<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 회원탈퇴</title>
<link href="css/styles.css" rel="stylesheet" />
<style>
/* CSS RESET */
* {
	padding: 0;
	border: 0;
	margin: 0;

}


a {
	text-decoration: none;
}

li {
	list-style: none;
}

.full-bg {
	height: 100%;
}

.table {
	
	height: 100%;
	display: table;
	margin: 0 auto;
}

.table-cell {
	height: 100%;
	display: table-cell;
	vertical-align: middle;
}

.login-container {
	width: 500px;
	background-color: #fff;
	padding: 70px 20px;
	box-sizing: border-box;
}

.login--title {
	width: 100%;
	text-align: center;
	font-size: 50px;
}

.form-input {
	width: 100%;
	padding: 10px 20px;
	font-size: 20px;
	outline: none;
	margin: 10px 0;
	border: 1px solid #efefef;
	box-sizing: border-box;
}

.form-input:focus {
	box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1);
	border: none;
}

.form-input--title {
	width: 100%;
	display: block;
	margin: 5px 0;
	box-sizing: border-box;
}

.form-btn {
	display: block;
	width: 100%;
	font-size: 16px;
	height: 40px;
	background-color: #fd7e14;
	color: #fff;
	box-sizing: border-box;
	margin: 5px 0;
	cursor: pointer;
}

.form-btn:hover {
	background-color: #FF9900;
	box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.5);
}

</style>
</head>
<body>
<script type="text/javascript">
if

</script>
	<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/ui/side.jsp"></jsp:include>
	<br>
	<br>
	<br>
		<section align="center"
			style="width: 60%; margin-left: auto; margin-right: auto;">
		<div class="table" align="center">
			<div class="table-cell">
				<form action="deleteOK.do" method="post" name="frm">
					<div class="login-container">
					<br>
						<h3 class="login--title"><i class="bi bi-exclamation-triangle-fill"></i> 회원탈퇴 <i class="bi bi-exclamation-triangle-fill"></i></h3>
						<br>
						<br>
						<h4 align="left">비밀번호 재확인</h4>
						<span style="color:red">※  회원님의 정보 보호를 위해 비밀번호를 다시 확인해주세요! ※</span>
						<br>
						<br>
						
						<input type="hidden" id="pwd" name="userid" class="form-input" value="<%=session.getAttribute("userid")%>" readonly>
						<div align="left"><label class=form-input--title for="pwd">비밀번호</label></div>
						<input type="password" id="userid" name="pwd" class="form-input">
						<div style="color:red"><Strong>${message}</Strong></div>
						<input type="submit" class="form-btn" value="로그인" id="login" onclick="location.href='deleteTerms.jsp'">
						<br>
					</div>
				</form>
			</div>
		</div>
		</section>
				<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>