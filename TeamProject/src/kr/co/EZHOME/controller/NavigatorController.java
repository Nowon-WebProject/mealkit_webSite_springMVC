package kr.co.EZHOME.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NavigatorController {
	
	//메인 페이지
	@GetMapping("/index")
	public String index() {
		
		return "index";
	}
	
	//사이트소개
	@GetMapping("/about")
	public String about() {
		
		return "introduce/about";
	}
	
	//마이페이지
	@GetMapping("/myPage")
	public String myPage() {
		
		return "myPage/myPage";
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout() {
		
		return "login/logout";
	}
	
	//관리자 페이지
	@GetMapping("/managePage")
	public String managePage() {
		
		return "managePage/managePage";
	}
	
	//로그인 페이지
	@GetMapping("/login")
	public String login() {
		
		return "login/login";
	}
}
