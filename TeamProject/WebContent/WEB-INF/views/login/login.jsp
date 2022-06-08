<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!-- 로그인 페이지 -->
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 로그인</title>
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

 .findUserInfo{
	float: right;
	font-size: 8px;
	margin-bottom: 10px;
}

</style>
<script type="text/javascript">
	var message = "<c:out value='${message}'/>";
	if (message != "") {
		alert(message);
	}
</script>
</head>
<body>
<div id="wrap">
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
<section>
	<br><br><br><br><br>
	<div class="table" align="center">
		<div class="table-cell">
			<form action="login.do" method="post" name="frm">
				<div class="login-container">
					<h3 class="login--title">로그인</h3>
					<div align="left"><label class=form-input--title for="userid">아이디</label></div>
					<input type="text" id="userid" name="userid" class="form-input">
					<div align="left"><label class=form-input--title for="pwd">비밀번호</label></div>
					<input type="password" id="pwd" name="pwd" class="form-input">
					<div class="findUserInfo">
						<a class="findId" href="findId">아이디 찾기</a> &nbsp; 
						<a class="findPassword" href="findPassword">비밀번호 찾기</a>
					</div>
					<input type="submit" class="form-btn" value="로그인" id="login">
					<input type="button" class="form-btn" value="회원가입" id="signup" onclick="location.href='/TeamProject/terms'">
				</div>
			</form>
		</div>
	</div>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>