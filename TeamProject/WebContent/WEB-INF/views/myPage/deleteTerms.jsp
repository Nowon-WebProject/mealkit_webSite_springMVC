<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠, 집에서 | 회원탈퇴</title>
<link href="css/styles.css" rel="stylesheet" />
<style>
.form-btn {
	display: block;
	width: 40%;
	font-size: 16px;
	height: 40px;
	background-color: #fd7e14;
	color: #fff;
	box-sizing: border-box;
	margin: 5px 0;
	cursor: pointer;
	border: 0;
}

.form-btn:hover {
	background-color: #FF9900;
	box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.5);
}
</style>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/TeamProject/js/member.js?version=6"></script>
<script type="text/javascript">
</script>
</head>
<body>
<div id="wrap">
		<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
		<jsp:include page="/WEB-INF/views/ui/side.jsp"></jsp:include>
		<section align="center"
			style="width: 60%; margin-left: auto; margin-right: auto;">
<form action="delete.do" method="post" name="frm">
<%String userid=request.getParameter("userid");%>
<input type="hidden" name="userid" value="${loginUser.userid}">
	<div align="center"><h1>회원탈퇴</h1>
	<br>
	
	<div style="color:red; text-align:left; width:60%">※ 회원 탈퇴 시 이미 결제된 주문은 취소/환불 되지 않으며, 탈퇴 후 관련 정보가 파기되므로,<br>&nbsp;&nbsp;&nbsp;&nbsp;신중한 탈퇴를 부탁드립니다.
	<br>※ 관련하여 문의 사항이 있으시다면 1대1 문의를 해주세요.</div></div>
	<br>
	<div id="table" align="center">
	<strong>회원탈퇴 안내</strong>
	<div align="center">

<textarea rows="6" cols="90" readonly>[회원탈퇴 약관]

회원탈퇴 신청 전 안내 사항을 확인 해 주세요.
회원탈퇴를 신청하시면 현재 로그인 된 아이디는 사용하실 수 없습니다.
회원탈퇴를 하더라도, 서비스 약관 및 개인정보 취급방침 동의하에 따라 일정 기간동안 회원 개인정보를 보관합니다.

- 주문 정보
- 상품 구입 및 대금 결제에 관한 기록
- 상품 배송에 관한 기록
- 소비자 불만 또는 처리 과정에 관한 기록
- 게시판 작성 및 사용후기에 관한 기록

※ 상세한 내용은 사이트 내 개인정보 취급방침을 참고 해 주세요.</textarea></div>
<input type="checkbox" id="check1" required><i class="bi bi-exclamation-lg" style="color:red"></i>회원 탈퇴 안내에 동의합니다.
	</div>
	<br>
	<br>
	<div align="center"><strong>개인정보처리방침 </strong>
	<div align="center">
<textarea rows="6" cols="90" readonly>
쇼핑몰 「이젠, 집에서」는 「개인정보보호법」 등 관련법령에 따라 정보주체의 개인정보 및 권익을 보호하고, 개인정보와 관련한 정보주체의 고충을 원활하게 처리할 수 있도록 다음과 같은 개인정보 처리방침을 두고 있습니다.
제 1 조 개인정보 처리 항목
회사는 서비스를 위한 목적에 필요한 범위에서 최소한의 개인정보를 다음과 같이 처리합니다.
서비스 회원가입 및 관리
필수항목 : 이름, 생년월일, 아이디, 비밀번호, 성별, 이메일
선택항목 : 주소, 연락처, 프로필사진, 체형정보, 취향정보

민원사무 처리
이름, 아이디, 주소, 연락처 등 상담을 위해 필요한 회원의 등록정보

재화 또는 서비스 제공
이름, 아이디, 이메일, 주소, 연락처 등 서비스 수령을 위한 정보

마케팅 및 광고에의 활용
이름, 연락처, 생년월일, 서비스 이용정보, 회원이 사이트 내에 게시·등록한 콘텐츠 등

서비스 개발 및 개선
성별, 나이, 지역, 체형정보, 취향정보, 이용후기(글, 사진, 영상 등 콘텐츠 포함), 구매 이력 등
회사는 위 개인정보 처리와 관련하여 특정 개인을 알아볼 수 없도록 비식별화 조치를 취한 후 조치가 완료된 정보를 이용 및 제3자에게 제공합니다.

서비스 이용 과정에서 IP주소, 쿠키, 서비스 이용 기록, 기기정보, 위치정보가 생성되어 수집될 수 있습니다.

제 2 조 개인정보 수집·이용 및 목적
회사는 서비스를 위한 목적에 필요한 범위에서 최소한의 개인정보를 수집 및 이용합니다. 수집한 개인정보는 다음의 목적 외 용도로는 이용되지 않으며, 이용 목적이 변경될 경우 회원의 사전 동의를 구합니다.
서비스 회원가입 및 관리
서비스 가입의사 확인, 회원자격 유지·관리, 서비스 부정이용 방지, 고충처리, 분쟁 조정을 위한 기록 보존 등

 민원사무 처리
 민원인의 신원 확인, 민원사항 확인, 처리결과 통보 등

 재화 또는 서비스 제공
 서비스 제공, 콘텐츠 제공, 본인인증, 맞춤 서비스 제공 등

 마케팅 및 광고에의 활용
 이벤트 및 광고성 정보 제공 및 참여기회 제공, 마케팅 및 광고 콘텐츠제작 및 게재 등

 서비스 개발 및 개선
 신규 서비스 및 제품 개발, 맞춤 서비스 제공, 서비스의 유효성 확인, 접속 빈도파악, 회원의 서비스 이용에 대한 통계 분석 등

제 3 조 개인정보의 제공 및 위탁
 회사는 회원의 동의, 법률의 특별한 규정 등 「개인정보보호법」제17조 및 제18조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.
 회사는 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.

수탁업체
위탁업무 내용
(주)코드엠
신용카드 결제 처리 및 구매안전서비스

(주)카카오페이
카카오 페이를 이용한 구매 및 요금 결제

(주)다우기술
SMS/MMS 등 문자메시지 발송 대행


제 4 조 개인정보의 보유 및 파기
 회사는 원칙적으로 회원의 개인정보를 회원 탈퇴 시까지 보유하며, 회원 탈퇴 시 지체없이 파기합니다.
 단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.

 부정이용기록
 부정이용기록은 수집 시점으로부터 6개월 간 보관하고 파기합니다.
 	
「전자상거래 등에서 소비자 보호에 관한 법률」
 표시·광고에 관한 기록 : 6개월
 계약 또는 청약철회 등에 관한 기록 : 5년 보관
 대금결제 및 재화 등의 공급에 관한 기록 : 5년 보관
 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 보관

 「전자금융거래법」
 전자금융에 관한 기록 : 5년 보관

 「통신비밀보호법」
 로그인 기록 등 방문 기록 : 3개월

 회원탈퇴, 서비스 종료, 이용자에게 동의 받은 개인정보 보유기간의 도래와 같이 개인정보의 수집 및 이용목적이 달성된 개인정보는 재생이 불가능한 방법으로 파기합니다.
 법령에서 보존의무를 부과한 정보는 해당 법령에서 정한 기간이 경과한 후 지체없이 재생이 불가능한 방법으로 파기합니다.
 회사는 ‘개인정보 유효기간제’에 따라 1년 간 로그인하지 않거나 서비스를 이용하지 않은 회원의 개인정보를 별도로 분리하여 보관 및 관리합니다.

제 5 조 정보주체 및 법정대리인의 권리와 행사 방법

 회원은 회사에 대해 언제든지 서면, 전자우편 등의 방법으로 개인정보 열람·정정·삭제·처리정리 요구 등의 권리를 행사할 수 있습니다.
 제1항에 따른 권리 행사는 회원의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다.
 회원의 개인정보의 오류에 대한 정정을 요청한 경우, 정정을 완료하기 전까지 해당 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체 없이 통지하여 정정이 이루어지도록 하겠습니다.
 개인정보 열람 및 처리정지 요구는 「개인정보 보호법」 제37조제2항 및 관련 법령에 의하여 회원의 권리가 제한될 수 있습니다.

제 6 조 개인정보의 안정성 확보조치
 회사는 개인정보를 안전하게 관리하기 위하여 최선을 다하며 다음과 같은 조치를 취하고 있습니다.

 관리적 조치 : 내부관리계획 수립·시행
 물리적 조치 : 개인정보시스템의 물리적 보관 장소에 대한 비인가자 출입 통제
 기술적 조치 : 개인정보에 대한 접근 제한, 중요정보에 대한 암호화, 보안프로그램 설치 등

	</textarea> 
	</div>
	<input type="checkbox" id="check2" required>  <i class="bi bi-exclamation-lg" style="color:red"></i> 개인정보처리방침에 동의합니다.
	<br>
	<br>
	<input type="submit" class="form-btn" value="탈퇴하기">
	</div>
	<!-- <input type="submit" value="탈퇴하기 " id="next" onclick="location.href='delete'"> -->
	<!-- <input type="hidden" onclick="deleteCheck()"> -->
</form>
</section>
		<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>