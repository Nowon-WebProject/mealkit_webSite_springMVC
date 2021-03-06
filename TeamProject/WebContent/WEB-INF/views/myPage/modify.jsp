<%@page import="kr.co.EZHOME.dto.UserDTO"%>
<%@page import="kr.co.EZHOME.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 회원정보수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<!-- 정보  -->	
<!-- 주소 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- ajax -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="js/member.js"></script>
<script type="text/javascript" src="js/sunwoo.js?test=73"></script>
</head>
<body>
<%
String addr = (String)session.getAttribute("addr");
String postcode = addr.substring(1,6);
String addr1 = addr.substring(8,addr.lastIndexOf(","));
String addr2 = addr.substring(addr.lastIndexOf(",")+2);

String email = (String)session.getAttribute("email");
int find = email.indexOf("@");
String email1 = email.substring(0, find);
String email2 = email.substring(find+1);

String[] arr=(String[])request.getAttribute("arr");


%>
		<div id="wrap">	
			<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
			<jsp:include page="/WEB-INF/views/ui/side.jsp"></jsp:include>
			<section align="center"
			style="width: 60%; margin-left: auto; margin-right: auto;">
			<div align="center">
		<h3><b><i class="bi bi-brush"></i> 개인 정보 수정</b></h3><br>
		<hr>
		<br>
<form action="modify.do" method="post" name="frm">	
		<table>
			<tr>
				<td style="width:25%">이름 <i class="bi bi-check-lg" style="color:red"></i></td>
				<td><input type="text" name="name" size="20" value="<%=session.getAttribute("name") %>"><br>
				<!-- <span> 숫자, 특수문자 입력 불가 </span> -->
				</td>
			</tr>
			
			<tr>
				<td>아이디</td>
				<td><%=session.getAttribute("userid")%>
				<input type="hidden" name="userid" value="<%=session.getAttribute("userid") %>"><br></td>
			</tr>
			<!-- <tr>
				<td>현재 비밀번호</td>
				<td><input type="password" name="pwd" value="" size="20"><br></td>
			</tr> -->
			
			
			<tr><!--"word-break:nowrap" 사용하면 한 줄로 표현 가능한데 안 먹힘...  -->
				<td>새로운 비밀번호 <i class="bi bi-check-lg" style="color:red"></i></td>
				<td><input type="password" name="pwd" size="20" placeholder="비밀번호를 입력하시오"></td>
			</tr>
			<tr height="30">
				<td width="80">비밀번호 확인 <i class="bi bi-check-lg" style="color:red"></i></td>
				<td><input type="password" name="pwd_check" size="20"></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td>
					<input type="text" id="birth" name="birth" value="<%=arr[3]%>" maxlength="8">
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
				<td>이메일</td>
				<td><input type="text" name="email1" value="<%=email1%>"> @ <input type="text" name="eMailSite" value="<%=email2%>" readonly>
				<%-- <input type="hidden" name="email1" value="<%=email1%>"> --%>
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
				</tr>
				<tr>
				<td><!-- <span class="form-label"> -->전화번호<!-- </span> --></td>
				<td><input type="text" class="phone" name="phone" onkeyup="mobile_keyup(this)" size="20" value="<%=session.getAttribute("phone") %>" maxlength="13"><br></td>
			</tr>
			<tr>
				<td>주소 <i class="bi bi-check-lg" style="color:red"></i></td>
				<td>
				<input type="text" name="addr" id="sample4_postcode" value="<%=postcode%>" placeholder="우편번호" >
				<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="page"><br>
				<input type="text"  name="addr1" id="sample4_roadAddress" value="<%=addr1%>" placeholder="도로명주소">
				<input type="hidden" name="1" id="sample4_jibunAddress" placeholder="지번주소"><br>
				<span id="guide" id="deli1" style="color:#999;display:none"></span> <!-- 예상주소 -->
				<input type="text" name="addr2" id="sample4_detailAddress" value="<%=addr2%>" placeholder="상세주소" size="60"><br>
				<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
				<input type="hidden" id="sample4_engAddress" name="engAddr" placeholder="영문주소"  size="60" >
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<br>
					<input type="hidden" name="pageNum" value="1">
					<input type="hidden" name="pageSize" value="10">
					<input type="submit" value="확인" class="back-btn"onclick="return check()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="다시작성" class="back-btn">
					<br>
				</td>
			</tr>
			
		</table>
	</form>
		</div>
			</section>
		<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>