package kr.co.EZHOME.controller;

import org.springframework.stereotype.Controller;
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
		
		String userid=request.getParameter("userid");
		
		UserDTO udto=user.getMember(userid);
		
		myPage.deleteMember(userid);
		session.invalidate();
		
		
		return "myPage/delete";
	}
	
	@PostMapping("deleteOK.do")
	public String deleteOKDo(HttpServletRequest request) {
		String url = "myPage/deleteOK";
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");

		int result=user.userCheck(userid, pwd);
		System.out.println(result+"테스트");
		if (result == 1) {
			UserDTO udto = user.getMember(userid);
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", udto);
			
			
			session.setAttribute("name", udto.getName());
			session.setAttribute("id", udto.getUserid());
			session.setAttribute("pwd",udto.getPwd());
			session.setAttribute("birth", udto.getBirth());
			session.setAttribute("email",udto.getEmail());
			session.setAttribute("phone",udto.getPhone());
			session.setAttribute("rdate", udto.getRegistDate());
			session.setAttribute("addr", udto.getAddr());
			/* session.setAttribute("deli", udto.getDeliAddr()); */
			session.setAttribute("admin", udto.getAdmin());
			
			session.setAttribute("result", result);
			
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
		String phone=request.getParameter("phone");
		
	
		UserDTO udto=new UserDTO();
		udto.setUserid(userid);
		 udto.setName(name);
		 udto.setPwd(pwd); 
		 udto.setEmail(email);
		 udto.setPhone(phone); 
		 udto.setAddr(addr);
		 
		 	myPage.updateMember(udto);

			HttpSession session = request.getSession();
			session.setAttribute("loginUser", udto);
			session.setAttribute("name", udto.getName());
			session.setAttribute("id", udto.getUserid());
			session.setAttribute("pwd",udto.getPwd());
			session.setAttribute("birth", udto.getBirth());
			session.setAttribute("email",udto.getEmail());	
			session.setAttribute("phone",udto.getPhone());
			session.setAttribute("rdate", udto.getRegistDate());
			session.setAttribute("addr", udto.getAddr());
		/* session.setAttribute("deli", udto.getDeliAddr()); */
			session.setAttribute("admin", udto.getAdmin());
		/* session.setAttribute("result", result); */
			
			
			
		/*
		 * if (result == 1) { System.out.println("회원정보수정 성공");
		 * response.sendRedirect("index.jsp"); // 성공하면 메인화면으로 } else {
		 * System.out.println("회원정보수정 실패"); response.sendRedirect("modify.jsp"); // 실패하면
		 * modify 머물러 있음. }
		 * 
		 */
		 
		
		return "index";
	}
	
	
	
	
	
	
	@PostMapping("/modifyOK.do")
	public String modifyOKDo(HttpServletRequest request) {
		
		String url = "myPage/modifyOK";
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");

		UserDTO udto = user.getMember(userid);
		
		int result = user.userCheck(userid, pwd);
		
		
		if (result == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", udto);
			session.setAttribute("name", udto.getName());
			session.setAttribute("id", udto.getUserid());
			session.setAttribute("pwd",udto.getPwd());
			session.setAttribute("birth", udto.getBirth());
			session.setAttribute("email",udto.getEmail());
			session.setAttribute("phone",udto.getPhone());
			session.setAttribute("rdate", udto.getRegistDate());
			session.setAttribute("addr", udto.getAddr());
			/* session.setAttribute("deli", udto.getDeliAddr()); */
			session.setAttribute("admin", udto.getAdmin());
			session.setAttribute("result", result);
			
			
			request.setAttribute("message", "로그인 되었습니다.");
			url="myPage/modify";
		} else if (result == 0) {
			request.setAttribute("message", "비밀번호가 맞지 않습니다.");
		} 
		
		
		
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
