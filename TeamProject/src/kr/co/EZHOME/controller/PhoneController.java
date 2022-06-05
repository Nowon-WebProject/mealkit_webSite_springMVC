package kr.co.EZHOME.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.EZHOME.domain.DataStatus;
import kr.co.EZHOME.domain.PhoneAuthentication;
import kr.co.EZHOME.domain.User;

@Controller
public class PhoneController {
	
	private final PhoneAuthentication phoneAuthentication;
	private final User user;
	
	public PhoneController(PhoneAuthentication phoneAuthentication, User user) {
		this.phoneAuthentication = phoneAuthentication;
		this.user = user;
	}
	
	@GetMapping("/sendMessage.do")
	public String sendMessageDo(HttpServletRequest request)
			throws ServletException, IOException {
		//인증 요청 휴대폰 번호
		String phone = request.getParameter("phone");
		String certificationNumber;
		// 발송횟수
		int sendCount = phoneAuthentication.sendCount(request);
		// 발송횟수가 5회 이하일 경우에만 재발송을 해준다
		if (sendCount < 5) {
			//문자 발송 및 인증번호 받기
			certificationNumber = phoneAuthentication.sendMessage(phone);
			//인증번호 저장
			request.setAttribute("certificationNumber", certificationNumber);
		}

		// 발송횟수가 5회 이상일 경우 문자 발송없이 join 창으로
		return "join/phoneCheck";
	}
	
	// 아이디 찾기 확인
	@PostMapping("/findId.do")
	public String findIdDo(HttpServletRequest request) {
		String name = request.getParameter("name");
		String phone = request.getParameter("checkedPhone");

		// checkPhoneUser 메서드를 통해 id찾기시 출력해줄 message 리턴받기
		String message = phoneAuthentication.checkUserPhoneName(phone, name);
		request.setAttribute("message", message);

		return "login/findIdResult";
	}
	
	//비밀번호 찾기 확인
	@PostMapping("/findPassword.do")
	public String findPasswordDo(HttpServletRequest request) {
		String userid = request.getParameter("userid");
		String name = request.getParameter("name");
		String phone = request.getParameter("checkedPhone");
		
		String message = phoneAuthentication.checkUserPhoneNameId(phone, name, userid);
		request.setAttribute("message", message);
		
		return "login/findPasswordResult";
	}
	
	//새 비밀번호 변경
	@PostMapping("updatePassword.do")
	public String updatePassword(HttpServletRequest request) {
		String userid = request.getParameter("userid");
		String password = request.getParameter("pwd");
		String url = "login/login";
		String message;
		
		message = user.updatePassword(userid, password);
		request.setAttribute("message", message);
		
		if (message.equals("비밀번호가 이전 비밀번호와 같습니다. 새로운 비밀번호를 입력해주세요")) {
			return "login/findPasswordResult";
		}
		return "login/login";
	}
	
	//회원가입시 입력한 휴대폰번호가 있는 유저 정보 찾기
	@PostMapping("checkUser.do")
	public String checkUserDo(HttpServletRequest request) {
		String phone = request.getParameter("phone");
		String message;
		
		message = phoneAuthentication.checkUserPhone(phone);
		request.setAttribute("message", message);
		
		return "join/phoneCheckResult";
	}
	
}
