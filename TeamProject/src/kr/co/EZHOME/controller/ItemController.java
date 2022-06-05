package kr.co.EZHOME.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.EZHOME.domain.Item;

@Controller
public class ItemController {
	
	private final Item item;
	
	public ItemController(Item item) {
		this.item = item;
	}
	
	@GetMapping("itemAbout.do")
	public String itemAboutDo(HttpServletRequest request) {
		
		
		return "";
	}
}
