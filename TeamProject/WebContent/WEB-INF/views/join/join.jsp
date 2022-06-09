<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 회원가입 페이지 -->
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 회원가입</title>
<link href="css/styles.css?test1=5" rel="stylesheet" />
<title>회원가입 화면</title>
<style>

.bi bi-check-lg {
	color: red;
}
</style>
<script type="text/javascript" src="js/libs/jquery-3.6.0.min.js"></script>
<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script type="text/javascript" src="js/member.js?test=12"></script>
<!-- 도로명 주소 검색시 사용하는 daum api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
<br><br><br><br><br>
<section style="width: 60%; margin-left: auto; margin-right: auto;">
<!-- 왼쪽, 오른쪽 바깥여백을 auto로 주면 중앙정렬된다.  -->
    <div align="center">
			<h2>회원가입</h2>
	<form action="join.do" method="post" name="frm">
		<table>
			<tr>
			<td colspan="2"><hr> </td>
			</tr>
			<tr>
				<td>이름 <i class="bi bi-check-lg" style="color: red;"></i> </td>
				<td><input type="text" name="name" size="20" maxlength="16"></td>
			</tr>
			<tr>
				<td>아이디 <i class="bi bi-check-lg" style="color: red;"></i></td>
				<td>
					<input type="text" id="userid" name="userid" size="20" maxlength="16">
					<input type="hidden" name="reid" size="20">
					<input type="button" value="중복체크" onclick="idCheck()">
				</td>
			</tr>
			<tr>
				<td/>
				<td>
					<p class="txt_guideId" >
						<span class="badId">4자 이상의 영문 혹은 영문과 숫자를 조합</span>
						<input type="hidden" name="idValid" value = "false" size="20">
						<br>
						<span class="badCheckedId">아이디 중복확인</span>
					</p>
				</td>
			</tr>
			<tr>
				<td>암호 <i class="bi bi-check-lg" style="color: red;"></i></td>
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
				<td>암호 확인 <i class="bi bi-check-lg" style="color: red;"></i></td>
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
				<td>생년월일</td>
				<td>
					<input type="text" id="birth" name="birth" placeholder="8자리입력(예.19951129)" maxlength="8">
				</td>
			</tr>
			<tr>
				<td/>
				<td>
					<p class="txt_guideBirth" >
						<span class="badBirthGuide"></span>
						<input type="hidden" name="birthValid" value="false" size="20">
					</p>
				</td>
			</tr>

			<tr>
				<td>이메일</td>
				<td><input type="text" name="email" value=""> @ <input type="text" name="eMailSite" value="" readonly>
					<select	id="eMailForm" name="eMailForm" size="1" onchange="email_check()">
						<option value="">선택하세요</option>
						<option value="naver.com">naver.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
						<option value="samsung.com">samsung.com</option>
						<option value="gmail.com">gmail.com</option>
						<option id="직접입력">직접입력</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>휴대폰 번호 <i class="bi bi-check-lg" style="color: red;"></i></td>
				<td>
					<input type='tel' class="phone" name='phone' maxlength="13"/>
					<!--  -->
					<input type="button" value="인증번호 받기" onclick="return phoneCheck(0)">
					<input type="hidden" id="phoneValid" name="phoneValid" value="false" size="20">
					<input type="hidden" name="checkedPhone" size="20">
				</td>
			</tr>
			<tr>
				<td>주소 <i class="bi bi-check-lg" style="color: red;"></i></td>
				<td>
					<input type="text" id="sample4_postcode" name="addr1" placeholder="우편번호" readonly>
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="sample4_roadAddress" name="roadAddr" placeholder="도로명주소" size="60" readonly><br>
					<input type="hidden" id="sample4_jibunAddress" name="jibunAddr" placeholder="지번주소"  size="60">
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" id="sample4_detailAddress" name="addr3" placeholder="상세주소"  size="60"><br>
					<input type="hidden" id="sample4_extraAddress" name="cham" placeholder="참고항목"  size="60">
					<input type="hidden" id="sample4_engAddress" name="engAddr" placeholder="영문주소"  size="60" >
				</td>
			</tr>
			<tr>
				
			</tr>
			<tr>
				<td colspan="2"><hr></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="hidden" name="admin" value="0">
					<input type="submit" value="확인" class="back-btn"onclick="return joinCheck()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="다시작성" class="back-btn">
				</td>
			</tr>
			<tr>
				<td colspan="2">${message}</td>
			</tr>
		</table>
	</form>
    </div>
</section>
<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</div>
</body>
</html>