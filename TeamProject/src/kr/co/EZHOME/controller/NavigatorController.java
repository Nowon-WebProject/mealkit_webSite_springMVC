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
		
		ArrayList<ItemDTO> ilist1 = item.selectMainItem("야식");
		request.setAttribute("ilist1", ilist1);

		ArrayList<ItemDTO> ilist2 = item.selectMainItem("스테이크");
		request.setAttribute("ilist2", ilist2);
		
		ArrayList<ItemDTO> ilist3 = item.selectMainItem("일본여행");	
		request.setAttribute("ilist3", ilist3);
		
		ArrayList<ItemDTO> ilist4 = item.selectMainItem("집밥");
		request.setAttribute("ilist4", ilist4);
		
		ArrayList<ItemDTO> ilist5 = item.selectMainItem("파스타");
		request.setAttribute("ilist5", ilist5);
		
		ArrayList<ItemDTO> ilist6 = item.selectMainItem("샐러드");
		request.setAttribute("ilist6", ilist6);
		
		ArrayList<ItemDTO> ilist7 = item.selectMainItem("동남아여행");
		request.setAttribute("ilist7", ilist7);
		
		ArrayList<ItemDTO> ilist8 = item.selectMainItem("중국여행");
		request.setAttribute("ilist8", ilist8);
		
		return "index";
	}
	
	@PostMapping("/index")
	public String postIndex(HttpServletRequest request) { 
		
		ArrayList<ItemDTO> ilist1 = item.selectMainItem("야식");
		request.setAttribute("ilist1", ilist1);

		ArrayList<ItemDTO> ilist2 = item.selectMainItem("스테이크");
		request.setAttribute("ilist2", ilist2);
		
		ArrayList<ItemDTO> ilist3 = item.selectMainItem("일본여행");	
		request.setAttribute("ilist3", ilist3);
		
		ArrayList<ItemDTO> ilist4 = item.selectMainItem("집밥");
		request.setAttribute("ilist4", ilist4);
		
		ArrayList<ItemDTO> ilist5 = item.selectMainItem("파스타");
		request.setAttribute("ilist5", ilist5);
		
		ArrayList<ItemDTO> ilist6 = item.selectMainItem("샐러드");
		request.setAttribute("ilist6", ilist6);
		
		ArrayList<ItemDTO> ilist7 = item.selectMainItem("동남아여행");
		request.setAttribute("ilist7", ilist7);
		
		ArrayList<ItemDTO> ilist8 = item.selectMainItem("중국여행");
		request.setAttribute("ilist8", ilist8);
		
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
