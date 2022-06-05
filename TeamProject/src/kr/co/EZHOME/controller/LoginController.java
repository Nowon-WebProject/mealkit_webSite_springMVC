package kr.co.EZHOME.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.EZHOME.database.UserMapper;
import kr.co.EZHOME.domain.DataStatus;
import kr.co.EZHOME.domain.LoginStatus;
import kr.co.EZHOME.domain.PhoneAuthentication;
import kr.co.EZHOME.domain.User;
import kr.co.EZHOME.dto.CoolSMSKey;
import kr.co.EZHOME.dto.UserDTO;

@Controller
public class LoginController {
	
	private final User user;
	
	public LoginController(User user) {
		this.user = user;
	}
	
	//로그인
	@PostMapping("/login.do")
	public String loginDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "login/login";
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		LoginStatus result;
		
		try {
			validate(userid, pwd);
			result = user.login(userid, pwd, request);
		}catch (Exception e) { //로그인 도중 발생하는 에러 처리
			request.setAttribute("message", e.getMessage());
			e.printStackTrace();
			//로그인 실패시 가는 url
			return url;
		}
		
		//로그인 결과 처리
		if (result == LoginStatus.LOGIN_SUCCESS) {
			request.setAttribute("message", "로그인 되었습니다.");
			//로그인 성공시 가게되는 url
			url = "index";
		} else if (result == LoginStatus.PASSWORD_WRONG) {
			request.setAttribute("message", "비밀번호가 맞지 않습니다.");
		}
		return url;
	}
	
	//아이디 찾기
	@GetMapping("/findId")
	public String findId() {
		
		return "login/findId";
	}
	
	// 비밀번호 찾기
	@GetMapping("/findPassword")
	public String findPassword() {

		return "login/findPassword";
	}

	private void validate(String userid, String pwd) {
		if (userid == null || userid == "") {
			throw new IllegalArgumentException("아이디가 비어있습니다.");
		} else if (pwd == null || pwd == "") {
			throw new IllegalArgumentException("패스워드가 비어있습니다.");
		}
	}

}
