<%@page import="kr.co.EZHOME.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "kr.co.EZHOME.domain.User" %>
<!DOCTYPE html>
<!-- 회원가입 페이지 -->
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 관리자페이지</title>
<link href="css/styles.css?test1=7" rel="stylesheet" />
<title>회원수정 화면</title>
<script type="text/javascript" src="js/libs/jquery-3.6.0.min.js"></script>
<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script type="text/javascript" src="js/member.js?test=73"></script>
<script type="text/javascript" src="js/sunwoo.js?test=73"></script>
<!-- 도로명 주소 검색시 사용하는 daum api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(
		function() {
			var admin = <%=(Integer)session.getAttribute("admin")%>
			if(admin != 1){
			alert("접근 권한이 없습니다.");
			location.href="index";
			}
		});
</script>
</head>
<body>
<%
	UserDTO bean=(UserDTO)request.getAttribute("bean");
	String[] arr=(String[])request.getAttribute("arr");
%>
<div id="wrap">
<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
<section style="width: 40%; margin-left: auto; margin-right: auto;">
<!-- 왼쪽, 오른쪽 바깥여백을 auto로 주면 중앙정렬된다.  -->
    <div align="center">
			<br>
			<br>
			<h2>회원수정</h2>
			<button class="back-btn" onclick="history.back()" style="float:right">이전</button>
			<br>
			<hr>
	<form action="memberUpdate.do" method="post" name="frm">
		<table>
			<tr>
			<td colspan="2"> </td>
			</tr>
			<tr>
				<td>이름 <i class="bi bi-check-lg" style="color: red;"></i></td>
				<td><input type="text" name="name" size="20" maxlength="16" value="<%=bean.getName()%>"></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>
					<%=bean.getUserid() %>
					<input type="hidden" id="userid" name="userid" value="<%=bean.getUserid() %>" size="20" maxlength="16">
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
					<input type="text" id="birth" name="birth" value="<%=arr[3] %>" maxlength="8">
				</td>
			</tr>
			<tr>
				<td/>
				<td>
					<p class="txt_guideBirth" >
						<span class="goodBirthGuide">유효한 생년월일입니다</span>
						<input type="hidden" name="birthValid" value="true" size="20">
					</p>
				</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td>
					<input type='tel' class="phone" name='phone' value=<%=bean.getPhone() %> maxlength="13"/>
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email" value="<%=arr[4] %>"> @ <input type="text" name="eMailSite" value="<%=arr[5] %>">
					<select	id="eMailForm" name="eMailForm" size="1" onchange="email_check()">
						<option value="naver.com">naver.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
						<option value="samsung.com">samsung.com</option>
						<option value="gmail.com">gmail.com</option>
						<option id="직접입력" selected>직접입력</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>주소 <i class="bi bi-check-lg" style="color: red;"></i></td>
				<td>
					<input type="text" id="sample4_postcode" name="addr1" value="<%=arr[0] %>" readonly>
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="page"><br>
					<input type="text" id="sample4_roadAddress" name="roadAddr" value="<%=arr[1] %>" size="60" readonly><br>
					<input type="hidden" id="sample4_jibunAddress" name="jibunAddr" placeholder="지번주소"  size="60">
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" id="sample4_detailAddress" name="addr3" value="<%=arr[2] %>"  size="60"><br>
					<input type="hidden" id="sample4_extraAddress" name="cham" placeholder="참고항목"  size="60">
					<input type="hidden" id="sample4_engAddress" name="engAddr" placeholder="영문주소"  size="60" >
				</td>
			</tr>
			<tr>
				
			</tr>
		</table>
			<hr>		
			<div align="center">
 				   <div style="width:100px">
					<input type="submit" value="수정" onclick="return birthCheck()" class="confirm-btn" style="display:inline">
					<input type="submit" value="취소" formaction="memberSearch.do" name="test" class="table-btn" style="display:inline">
			    </div>
		    </div>
	</form>
    </div>
	</section>
<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
</div>

</body>
</html>