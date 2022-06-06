package kr.co.EZHOME.domain;

import org.springframework.stereotype.Service;

import kr.co.EZHOME.dao.OrderDAO;

@Service
public class Order {

	private final OrderDAO orderDAO;
	
	public Order(OrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}
	
	
}
