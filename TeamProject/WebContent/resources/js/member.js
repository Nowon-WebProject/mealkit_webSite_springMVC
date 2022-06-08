//반응형 jquery 문
$(document).ready(function() {
	
	//전화번호 -자동입력
	$(".phone").keydown(function(event) {
		//event.charCode : 눌린 키보드의 char 값
		//event.keyCode : 눌린 키보드의 char 값
		//크롬의 경우 keyCode에 값이 찍힌다
		//즉 key 값은 눌린 키보드의 값이라고 보면된다
		//둘다 없을땐 0
		var key = event.charCode || event.keyCode || 0;
		$text = $(this);
		// 8 = 백스페이스 , 9 = tab
		if (key !== 8 && key !== 9) {
			if ($text.val().length === 3) {
				$text.val($text.val() + '-');
			}
			// == vs ===
			// ==은 우항에 맞게 형변환하여 true,false 를 해주지만 === 은 형변환을 해서 비교하지 않는다
			// ex) 1 == '1' (true), 1 === '1' (false)
			if ($text.val().length === 8) {
				$text.val($text.val() + '-');
			}
		}
		// 8: 벡스페이스, 9: tab , 46 : . , 48 ~ 57 : 숫자  96~105: 숫자 (탠키리스 아닌 키보드의 숫자패드)
		// 눌린값 리턴 (false가 리턴될경우 눌린 key가 적용되지 않는다)
		return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
	});
	
	//user id 클릭시 아이디 유효성 검증 띄우기
	$("#userid").one("focus", function() {
		var txt_guide = $(".txt_guideId");
		
		txt_guide.css("display", "block");
	});
	
	$("#userid").keyup(function(event) {
		var key = event.charCode || event.keyCode || 0;
		var text = $(this);
		var valid = true;
		var checkEng = false;
		
		//새로운 값이 들어왔으므로 id 중복체크 다시해줘야함 (tab이 아닐경우에만)
		//key가 tab이 아닐때
		if (key != 9) {
			$(".goodCheckedId").attr("class", "badCheckedId");
		}
		
		
		if (text.val().length < 4) {
			//class 변경 attr 에 클래스명 적을때는 . 찍지 말것
			$(".goodId").attr("class", "badId");
			document.frm.idValid.value = false;
			return ;
		}
		//입력한 문자열에 영문자 혹은 숫자가 있을경우
		for (var i = 0; i < text.val().length; i++) {
			//해당 문자를 아스키코드로 변환
			var c = text.val().charCodeAt(i);

			//영문일때 현재 반복문 스킵
			if ((c >= 65 && c <= 90) || (c >=  97 && c <= 122)) {
				//아이디가 숫자만 일때를 대비하여 eng 유무를 check
				checkEng = true;
				continue ;
			}
			//숫자일때 현재 반복문 스킵
			if (c >= 48 && c <= 57) {
				continue;
			}
			//영어 및 숫자가 아닌 문자가 문자열에 들어있을때
			valid = false;
			break;
		}
		
		if (valid == true && checkEng == true) {
			$(".badId").attr("class", "goodId");
			document.frm.idValid.value = true;
		}
		else {
			$(".goodId").attr("class", "badId");
			document.frm.idValid.value = false;
		}
		return ;
	});
	
	//암호
	//passwordGuide1 8글자 이상
	//passwordGuide2 영문 및 숫자 , 특수문자중 2가지 조합
	$("#pwd").one("focus", function() {
		var txt_guide = $(".txt_guidePassword");
		
		txt_guide.css("display", "inline");
		
		return ;
	});
	
	
	//패스워드 입력
	//1. 비밀번호가 8글자 이상인지 확인
	//2. 비밀번호가 영문, 숫자, 특수문자 중 2가지가 이상이 조합되었는지 확인
	$("#pwd").keyup(function (event){
		var pwd = $(this);
		var pwd_check = $("#pwd_check")
		var engCheck = false;
		var numCheck = false;
		var specialCheck = false;
		//passwordValid (submit 할때 참고하는 hidden 값)를 위한 변수
		var valid1 = false;
		var valid2 = false;
		var passwordCheckValid = false;
		
		//1. 비밀번호가 8글자 이상인지 확인
		if (pwd.val().length >= 8) {
			$(".badPasswordGuide1").attr("class", "goodPasswordGuide1");
			valid1 = true;
		}
		else {
			$(".goodPasswordGuide1").attr("class", "badPasswordGuide1");
			valid1 = false;
		}
		
		//2. 비밀번호가 영문, 숫자, 특수문자 중 2가지 이상이 조합되었는지 확인
		//step1. 반복문을 통해 문자열 탐색
		for (var i = 0; i < pwd.val().length; i++) {
			//해당 문자열을 아스키코드로 변환 (text.val()[i] => 이런식으로하면 문자열이 반환된다)
			var c = pwd.val().charCodeAt(i);
			
			//영문일때
			if ((c >= 65 && c <= 90) || (c >=  97 && c <= 122)) {
				engCheck = true;
			}
			//숫자일때
			else if (c >= 48 && c <= 57) {
				numCheck = true;
			}
			//특수 문자
			//아스키코드: 0x21~0x2F(33~47), 0x3A~0x40(58~64), 0x5B~0x60(91~96), 0x7B~0x7E(123~126)
			else if (((c >= 33) && (c <= 47)) || ((c >= 58) && (c <= 64)) || 
					((c >= 91) && (c <= 96)) || ((c >= 123) && (c <= 126))) {
				specialCheck = true;
			}
		}
		//step2. 2가지 이상 조합되었는지 확인
		if ((engCheck && numCheck) || (engCheck && specialCheck) || (numCheck && specialCheck)) {
			$(".badPasswordGuide2").attr("class", "goodPasswordGuide2");
			valid2 = true;
		}else  {
			$(".goodPasswordGuide2").attr("class", "badPasswordGuide2");
			valid2 = false;
		}
		
		if (valid1 && valid2) {
			document.frm.passwordValid.value = true;
		}
		else {
			document.frm.passwordValid.value = false;
		}
		
		//암호확인 로직 여기서 그대로 사용 (암호확인 먼저하고 비밀번호 적을 경우에도 valid 채크가 되어야 하기 때문에)
		if (pwd.val() != pwd_check.val()) {
			$(".goodPasswordCheckGuide").attr("class", "badPasswordCheckGuide");
			$(".badPasswordCheckGuide").text("비밀번호가 일치하지 않습니다");
			passwordCheckvalid = false;
		}
		else if (pwd_check.val().length == 0) {
			$(".goodPasswordCheckGuide").attr("class", "badPasswordCheckGuide");
			$(".badPasswordCheckGuide").text("비밀번호를 먼저 입력해주세요 ");
			passwordCheckvalid = false;
		}
		//암호와 암호확인이 같을때
		else {
			$(".badPasswordCheckGuide").attr("class", "goodPasswordCheckGuide");
			$(".goodPasswordCheckGuide").text("비밀번호가 일치합니다");
			passwordCheckvalid = true;
		}
		
		//passwordCheckValid 설정
		if (passwordCheckvalid == true) {
			document.frm.passwordCheckValid.value = true;
		}
		else {
			document.frm.passwordCheckValid.value = false;
		}
	});
	
	
	//암호 확인이 처음 포커싱 되었을때
	$("#pwd_check").one("focus", function() {
		var txt_guide = $(".txt_guidePasswordCheck");
		
		//처음 암호확인이 포커싱 되었을때 초기화 값
		if ($("#pwd").val().length === 0) {
			$(".goodPasswordCheckGuide").attr("class", "badPasswordCheckGuide");
			$(".badPasswordCheckGuide").text("비밀번호를 먼저 입력해주세요");
		}
		else {
			$(".goodPasswordCheckGuide").attr("class", "badPasswordCheckGuide");
			$(".badPasswordCheckGuide").text("비밀번호가 일치하지 않습니다");
		}
		txt_guide.css("display", "block");
	});
	
	//암호확인에서 키가 눌렸을때
	$("#pwd_check").keyup(function(event) {
		var key = event.charCode || event.keyCode || 0;
		var pwd = $("#pwd");
		var pwd_check = $(this);
		//passwordCheckValid (submit 할때 참고하는 hidden 값)를 위한 변수
		var valid = false;
		
		//암호를 입력을 안하고 암호확인을 할때
		if ($("#pwd").val().length === 0) {
			$(".goodPasswordCheckGuide").attr("class", "badPasswordCheckGuide");
			$(".badPasswordCheckGuide").text("비밀번호를 먼저 입력해주세요");
			valid = false;
		}
		//암호와 암호확인이 같지 않을때
		else if (pwd.val() != pwd_check.val()) {
			$(".goodPasswordCheckGuide").attr("class", "badPasswordCheckGuide");
			$(".badPasswordCheckGuide").text("비밀번호가 일치하지 않습니다");
			valid = false;
		}
		//암호와 암호확인이 같을때
		else {
			$(".badPasswordCheckGuide").attr("class", "goodPasswordCheckGuide");
			$(".goodPasswordCheckGuide").text("비밀번호가 일치합니다");
			valid = true;
		}
		
		//passwordCheckValid 설정
		if (valid == true) {
			document.frm.passwordCheckValid.value = true;
		}
		else {
			document.frm.passwordCheckValid.value = false;
		}
		
	});
	
	//생년월일
	$("#birth").one("focus", function() {
		var txt_guide = $(".txt_guideBirth");
		
		$(".badBirthGuide").text("생년월일을 입력해주세요 (필수입력 X)");
		txt_guide.css("display", "block");
	});
	
	//1. 숫자가 들어왔는가?
	//2. 생년월일이 맞는가
	$("#birth").keyup(function(event) {
		var text = $(this);

		//입력된 생년월일이 8글자가 안된다면
		if (text.val().length < 8) {
			$(".goodBirthGuide").attr("class", "badBirthGuide")
			$(".badBirthGuide").text("유효하지 않은 생년월일 입니다 다시 확인해주세요 (필수입력X)");
			document.frm.birthValid.value = false;
			return;
		}
		
		//숫자 확인
		for (var i = 0; i < text.val().length; i++) {
			var c = text.val().charCodeAt(i);
			
			//숫자가 아니라면
			if (!(c >= 48 && c <= 57)) {
				$(".goodBirthGuide").attr("class", "badBirthGuide")
				$(".badBirthGuide").text("유효하지 않은 생년월일 입니다 다시 확인해주세요 (필수입력X)");
				document.frm.birtValid.value = false;
				return ;
			}
		}
		//숫자가 맞다면
		//생년월일이 유효한가 확인
		var year = Number(text.val().slice(0, 4));
		var month = Number(text.val().slice(4, 6));
		var day = Number(text.val().slice(6, 8));
		var date = new Date();
		//미래
		if (date.getFullYear()-year < 1 || date.getFullYear()-year > 120 || (month < 1 || month > 12) || (day < 1 || day > 31)) {
			$(".goodBirthGuide").attr("class", "badBirthGuide")
			$(".badBirthGuide").text("유효하지 않은 생년월일 입니다 다시 확인해주세요 (필수입력X)");
			document.frm.birthValid.value = false;
		}
		else {
			$(".badBirthGuide").attr("class", "goodBirthGuide")
			$(".goodBirthGuide").text("유효한 생년월일입니다");
			document.frm.birthValid.value = true;
		}

	});
});


function loginCheck(){
	
	if(document.frm.userid.value.length == 0){
		alert("아이디를 입력하세요.");
		document.frm.userid.focus();
		
		return false;
	}
	
	if(document.frm.pwd.value == ""){
		alert("패스워드는 반드시 입력해야 합니다.")
		document.frm.pwd.focus();
		
		return false;
	}
	
	return true;
}

function idCheck(){
	
	if(document.frm.userid.value == ""){
		alert("아이디를 입력해 주세요.")
		document.frm.userid.focus();
		
		return;
	}
	
	if(document.frm.idValid.value === "false"){
		alert("아이디는 4자 이상의 영문 혹은 영문과 숫자를 조합 이어야 합니다.");
		document.frm.userid.focus();
	
		return false;
	}

	var url="idCheck.do?userid="+document.frm.userid.value;
	window.open(url,"_blank_1","toolbar=no,menubar=no,"+"scrollbars=yes,resizable=no,width=450,height=200");
}

function phoneCheck(caseNum){
	//정규 표현식
	const regExp = /[^0-9\-]/g;
	var phone = document.frm.phone.value;
	
	if (phone.length < 13) {
		alert("전화번호 13자리를 다시 확인해주세요")
		
		return false;
	}
	
	//0~9,a~z, A~Z
	if (!(phone.match(regExp) == null)) {
		alert("잘못된 문자가 들어가 있습니다. 전화번호를 다시 확인해주세요");
		
		return false;
	}
	
	var popupX = (window.screen.width / 2) - (400 / 2);
	// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

	var popupY= (window.screen.height / 2) - (500);
	// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
	
	//first 를 통해 인증번호 첫 발송인것을 알려줌
	var url="sendMessage.do?phone="+document.frm.phone.value+"&first=true"+"&caseNum="+caseNum;
	window.open(url,"_blank_1","toolbar=no,menubar=no,"+"scrollbars=yes,resizable=no,width=500,height=300, left="+ popupX + ", top= "+ popupY);
}

function idok(userid){
	opener.frm.userid.value=userid;
	opener.frm.reid.value=userid;
	//중복확인 되었을때 guide txt 도 초록색으로 변경
	opener.$(".badCheckedId").attr("class", "goodCheckedId");
	self.close();
}

//내가 선택한 이메일 select option값 넣기
function email_check() {
    if (document.frm.eMailForm.options[document.frm.eMailForm.selectedIndex].value == "선택하세요") {
        document.frm.eMailSite.readOnly = true;
        document.frm.eMailSite.value = "";
    }
    if (document.frm.eMailForm.options[document.frm.eMailForm.selectedIndex].id == "직접입력") {
        document.frm.eMailSite.readOnly = false;
        document.frm.eMailSite.value = "";
        document.frm.eMailSite.focus();
    } else {
        document.frm.eMailSite.readOnly = true;
        document.frm.eMailSite.value= 
            document.frm.eMailForm.options[document.frm.eMailForm.selectedIndex].value;
    }
}

function joinCheck(){
	//이름
	if(document.frm.name.value.length == 0){
		alert("이름을 적어 주세요.");
		document.frm.name.focus();
	
	return false;
	}
	
	//아이디
	if(document.frm.idValid.value === "false"){
		alert("아이디는 4자 이상의 영문 혹은 영문과 숫자를 조합 이어야 합니다.");
		document.frm.userid.focus();
	
		return false;
	}
	
	//아이디 중복체크
	if(document.frm.reid.value == ""){
		alert("아이디 중복체크를 해주세요");
		document.frm.userid.focus();
	
		return false;
	}
	
	//비밀번호
	if(document.frm.passwordValid.value == "false"){
		alert("비밀번호가 유효하지 않습니다 비밀번호를 확인해주세요");
		document.frm.pwd.focus();
	
		return false;
	}
	//암호확인
	if(document.frm.passwordCheckValid.value == "false"){
		alert("암호확인을 다시 확인해주세요");
		document.frm.pwd_check.focus();
	
		return false;
	}
	
	//생년월일 (필수가 아니므로 비어있다면 넘어간다)
	if(document.frm.birthValid.value == "false" && !(document.frm.birth.value == "")){
		alert("생년월일이 유효하지 않습니다(필수X) 기입하지 않으시려면 내용을 지워주세요");
	    document.frm.birth.focus();
	
	    return false;
	}
	
	//이메일 유효성검사 하지 않음
	
	//전화번호
	if (document.frm.phoneValid.value == "false") {
		alert("휴대폰 번호 인증을 해주세요");
		document.frm.phone.focus();
		
		return false;
	}

	//주소
	//우편번호를 검색하지 않았을때
	if (document.frm.addr1.value.length === 0) {
		alert("우편번호 찾기를 진행해주세요");
		
		return false;
	}
	
	//상세주소를 입력하지 않았을때
	if (document.frm.addr3.value.length === 0) {
		alert("상세주소를 입력해주세요");
		
		return false;
	}
	
	return true;
}

//아이디 찾기
function findId() {
	if (document.frm.name.value == "") {
		alert("회원님의 이름을 입력해주세요");
		document.frm.name.focus();
		
		return false;
	}
	
	if (document.frm.phoneValid.value == "false") {
		alert("핸드폰 인증을 진행해 주세요");
		document.frm.phone.focus();
		
		return false;
	}
	
	return true;
}

//새 비밀번호로 변경
function updatePassword() {
	if (document.frm.passwordValid.value == "false") {
		alert("비밀번호가 유효하지 않습니다. 다시 확인해 주세요.");
		document.frm.pwd.focus();
		
		return false;
	}
	
	if (document.frm.passwordCheckValid.value == "false") {
		alert("비밀번호 확인이 유효하지 않습니다. 다시 확인해 주세요.")
		document.frm.pwd_check.focus();
		
		return false;
	}
	
	return true;
}

//비밀번호 찾기
function findPassword() {
	if (document.frm.name.value == "") {
		alert("회원님의 이름을 입력해주세요");
		document.frm.name.focus();
		
		return false;
	}
	
	if (document.frm.userId.value == "") {
		alert("회원님의 아이디를 입력해주세요");
		document.frm.userId.focus();
		
		return false;
	}
	
	if (document.frm.phoneValid.value == "false") {
		alert("핸드폰 인증을 진행해 주세요");
		document.frm.phone.focus();
		
		return false;
	}
	
	return true;
}


//주소 검색
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
     
            document.getElementById("sample4_engAddress").value = data.addressEnglish;
                   
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}