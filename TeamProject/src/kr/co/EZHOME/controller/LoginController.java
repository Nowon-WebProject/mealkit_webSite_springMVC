package kr.co.EZHOME.controller;

import java.io.File;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.EZHOME.database.UserMapper;
import kr.co.EZHOME.domain.Cart;
import kr.co.EZHOME.domain.DataStatus;
import kr.co.EZHOME.domain.LoginStatus;
import kr.co.EZHOME.domain.PhoneAuthentication;
import kr.co.EZHOME.domain.User;
import kr.co.EZHOME.dto.CoolSMSKey;
import kr.co.EZHOME.dto.UserDTO;

@Controller
public class LoginController {
	
	private final User user;
	private final Cart cart;
	private final String uploadDir = "C:\\study\\mealKit_webSite\\TeamProject\\WebContent\\images\\product";
	
	public LoginController(User user, Cart cart) {
		this.user = user;
		this.cart = cart;
	}
	
	//로그인
	@PostMapping("/login.do")
	public String loginDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "login/login";
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String message;
		UserDTO userDTO;
		
		try {
			validate(userid, pwd);
			 userDTO= user.login(userid);
		}catch (Exception e) { //로그인 도중 발생하는 에러 처리
			request.setAttribute("message", e.getMessage());
			e.printStackTrace();
			//로그인 실패시 가는 url
			return url;
		}
		
		//로그인 결과 처리
		if (userDTO.getPwd().equals(pwd)) {
			request.setAttribute("message", "로그인 되었습니다.");
			makeSession(request, userDTO);
			//로그인 성공시 가게되는 url
			url = "redirect:/index";
		} else {
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

	private void makeSession(HttpServletRequest request, UserDTO userDTO) {
		HttpSession session = request.getSession();
		session.setAttribute("name", userDTO.getName());
		session.setAttribute("userid", userDTO.getUserid());
		session.setAttribute("password",userDTO.getPwd());
		session.setAttribute("birth", userDTO.getBirth());
		session.setAttribute("email",userDTO.getEmail());
		session.setAttribute("phone",userDTO.getPhone());
		if (userDTO.getRegistDate() != null) {
			session.setAttribute("registDate", userDTO.getRegistDate().toString());
		}
		session.setAttribute("addr", userDTO.getAddr());
		session.setAttribute("deli", userDTO.getDeli());
		session.setAttribute("point", userDTO.getPoint());
		session.setAttribute("admin", userDTO.getAdmin());
		session.setAttribute("cartCnt", cart.cartCnt(userDTO.getUserid()));
	}
}
