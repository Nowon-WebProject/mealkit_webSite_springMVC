package kr.co.EZHOME.dto;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.EZHOME.domain.DataStatus;
import kr.co.EZHOME.domain.User;

@Controller
public class JoinController {
	
	private final User user;
	
	public JoinController(User user) {
		this.user = user;
	}
	
	@GetMapping("terms")
	public String terms() {
		
		return "join/terms";
	}
	
	@GetMapping("join")
	public String join() {
		
		return "join/join";
	}

	@GetMapping("idCheck.do")
	public String idCheckDo(HttpServletRequest request) {
		String userid = request.getParameter("userid");
		DataStatus result;
		
		result = user.comfirmId(userid);
		request.setAttribute("result", result);
		
		return "join/idCheck";
	}
	
	@PostMapping("join.do")
	public String joinDo(HttpServletRequest request) throws IOException {
		request.setCharacterEncoding("utf-8");
		String name=request.getParameter("name");
		String userid=request.getParameter("userid");
		String pwd=request.getParameter("pwd");
		String phone=request.getParameter("checkedPhone");
		String admin=request.getParameter("admin");
		String birth = request.getParameter("birth"); 
		String message;
		
		//email email + @ + emailSite
		String email = null;
		if (request.getParameter("email") != "" && request.getParameter("eMailSite") != "") {
			email = request.getParameter("email") + "@" + request.getParameter("eMailSite");
		}
		
		//address 값 받아오기
		String addr1 = request.getParameter("addr1");
		//도로명 주소만
		String roadAddr = request.getParameter("roadAddr");
		String addr3 = request.getParameter("addr3");
				
		String addr = "("+addr1 + ") " + roadAddr + ", " + addr3;
		
		UserDTO userDTO = new UserDTO(name, userid, pwd, birth, email, phone, null, addr, null, 0, Integer.parseInt(admin));
		message = user.insertMember(userDTO);
		request.setAttribute("message", message);
		
		return "login/login";
	}
}
