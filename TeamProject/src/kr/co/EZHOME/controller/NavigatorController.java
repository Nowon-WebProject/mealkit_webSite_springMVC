package kr.co.EZHOME.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.EZHOME.domain.Item;
import kr.co.EZHOME.dto.ItemDTO;

@Controller
public class NavigatorController {
	
	private final Item item;
	
	public NavigatorController(Item item) {
		this.item = item;
	}
	
	//메인 페이지
	@GetMapping("/index")
	public String getIndex(HttpServletRequest request) { 
		
		ArrayList<ItemDTO> ilist1 = item.selectMainItem("샐러드");
		request.setAttribute("ilist1", ilist1);

		ArrayList<ItemDTO> ilist2 = item.selectMainItem("세계여행");
		request.setAttribute("ilist2", ilist2);
		
		ArrayList<ItemDTO> ilist3 = item.selectMainItem("찌개");
		request.setAttribute("ilist3", ilist3);
		
		return "index";
	}
	
	@PostMapping("/index")
	public String postIndex(HttpServletRequest request) { 
		
		ArrayList<ItemDTO> ilist1 = item.selectMainItem("샐러드");
		request.setAttribute("ilist1", ilist1);

		ArrayList<ItemDTO> ilist2 = item.selectMainItem("세계여행");
		request.setAttribute("ilist2", ilist2);
		
		ArrayList<ItemDTO> ilist3 = item.selectMainItem("찌개");
		request.setAttribute("ilist3", ilist3);
		
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
