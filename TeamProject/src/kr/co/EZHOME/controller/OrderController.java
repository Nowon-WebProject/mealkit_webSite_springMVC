package kr.co.EZHOME.controller;

import org.springframework.stereotype.Controller;

import kr.co.EZHOME.domain.Order;

@Controller
public class OrderController {
	
	private final Order order;
	
	public OrderController(Order order) {
		this.order = order;
	}
}
