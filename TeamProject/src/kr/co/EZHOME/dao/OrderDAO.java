package kr.co.EZHOME.dao;

import org.springframework.stereotype.Repository;

import kr.co.EZHOME.database.OrderMapper;

@Repository
public class OrderDAO {

	private final OrderMapper orderMapper;
	
	public OrderDAO(OrderMapper orderMapper) {
		this.orderMapper = orderMapper;
	}
}
