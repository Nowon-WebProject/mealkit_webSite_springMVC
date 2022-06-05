<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript" >
		var message = "<c:out value='${message}'/>";
		alert(message);
		//존재하지 않는 회원일 경우
		if (message == "입력하신 정보와 일치하는 회원정보가 없습니다.") {
			window.location.href = "/TeamProject/findPassword";
		}
	</script>
	
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
<script type="text/javascript" src="js/member.js?test=12"></script>
</head>
<body>
	<div id="Wrap">
		<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
			<section>
				<div align="center"><b><font size="6" color="gray">비밀 번호 변경</font></b></div>
				<hr>
				<form action="updatePassword.do" method="post" name="frm">
					<table>
						<tr>
							<td>새 비밀번호 <i class="bi bi-check-lg" style="color: red;"></i></td>
							<td><input type="password" id="pwd" name="pwd" size="20" maxlength="16"></td>
							<td><input type="hidden" name="passwordValid" size="20" value="false"></td>
						</tr>
						<tr>
							<td/>
							<td>
								<p class="txt_guidePassword" >
									<span class="badPasswordGuide1">비밀 번호는 8글자 이상이어야 합니다</span> <br>
									<span class="badPasswordGuide2">비밀 번호는 영문, 숫자, 특수문자 중 2가지 이상을 조합해야합니다</span>
								</p>
							</td>
						</tr>
						<tr>
							<td>비밀번호 확인 <i class="bi bi-check-lg" style="color: red;"></i></td>
							<td><input type="password" id="pwd_check" name="pwd_check" size="20" maxlength="16"></td>
						</tr>
						<tr>
							<td/>
							<td>
								<p class="txt_guidePasswordCheck" >
									<span class="badPasswordCheckGuide"></span>
									<input type="hidden" name="passwordCheckValid" value="false" size="20">
								</p>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="submit" value="비밀번호 변경" onclick="return updatePassword()">
								<input type="hidden" name="userid" value="${param.userid }">
							</td>
						</tr>
					</table>					
				</form>
			</section>
		<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>