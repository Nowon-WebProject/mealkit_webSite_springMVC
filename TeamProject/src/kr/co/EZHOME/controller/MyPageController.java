package kr.co.EZHOME.controller;

import org.springframework.stereotype.Controller;

import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.EZHOME.dao.UserDAO;
import kr.co.EZHOME.domain.MyPage;
import kr.co.EZHOME.domain.User;
import kr.co.EZHOME.dto.UserDTO;

@Controller
public class MyPageController {
	
	private final MyPage myPage;
	private final User user;
	
	public MyPageController(MyPage myPage, User user) {
		this.myPage = myPage;
		this.user = user;
	}
	
	@PostMapping("delete.do")
	public String deleteDo(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String userid= (String) session.getAttribute("userid");
		
		user.deleteMember(userid);
		session.invalidate();
		
		request.setAttribute("message", "회원탈퇴가 정상적으로 완료되었습니다.");
		return "myPage/delete";
	}
	
	@PostMapping("deleteOK.do")
	public String deleteOKDo(HttpServletRequest request) {
		String url = "myPage/deleteOK";
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");

		//탈퇴를 위한 비밀번호 재 입력시, 
		//해당 아이디의 실제 비밀번호와 입력한 비밀번호가 
		//일치하는지 체크.
		
		int result=user.userCheck(userid, pwd);
		
		if (result == 1) {
			request.setAttribute("message", "로그인 되었습니다.");
			url="myPage/deleteTerms";
		} else if (result == 0) {
			request.setAttribute("message", "비밀번호가 맞지 않습니다.");
		} 
		
		
		return url;
	}
	
	@PostMapping("modify.do")
	public String modifyDo(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
 		String email=request.getParameter("email1")+"@"+request.getParameter("eMailSite");
 		String addr= "("+request.getParameter("addr")+") "+ request.getParameter("addr1") +", "+ request.getParameter("addr2");
		String name=request.getParameter("name");
		String birth=request.getParameter("birth");
		String phone=request.getParameter("phone");
		
	
		UserDTO udto=new UserDTO();
		udto.setUserid(userid);
		udto.setName(name);
		udto.setPwd(pwd); 
		udto.setBirth(birth); 
		udto.setEmail(email);
		udto.setPhone(phone); 
		udto.setAddr(addr);
		 
		user.updateMember(udto);

		HttpSession session = request.getSession();
		session.setAttribute("loginUser", udto);
		session.setAttribute("name", udto.getName());
		session.setAttribute("pwd",udto.getPwd());
		session.setAttribute("email",udto.getEmail());	
		session.setAttribute("phone",udto.getPhone());
		session.setAttribute("addr", udto.getAddr());
		session.setAttribute("birth", udto.getBirth());
		request.setAttribute("message", "회원정보가 정상적으로 수정되었습니다.");
		return "myPage/modifyOK";
	}
	
	
	
	
	
	
	@PostMapping("/modifyOK.do")
	public String modifyOKDo(HttpServletRequest request) throws Exception {
		
		String url = "myPage/modifyOK";
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		int result = user.userCheck(userid, pwd);
		
		
		if (result == 1) {
			url="myPage/modify";
		} else if (result == 0) {
			request.setAttribute("message", "비밀번호가 맞지 않습니다.");
		} 
		
		
		
		UserDTO userDTO = new UserDTO();
		userDTO = user.findUser(userid);
		String[] arr = { "", "", "", "", "", "" };
		String addr = userDTO.getAddr();
		Date birth = userDTO.getBirth();
		String email = userDTO.getEmail();
		
		arr = user.seperateData(addr, birth, email);
		request.setAttribute("arr", arr);
		
		return url;
	}
	
	
	
	@GetMapping("/modifyOK")
	public String modifyOK() {
		
		return "myPage/modifyOK";
	}
	
	
	@GetMapping("/deleteOK")
	public String deleteOK() {
		
		return "myPage/deleteOK";
	}
	
	@GetMapping("/delete")
	public String delete() {
		
		return "myPage/delete";
	}
	
}
