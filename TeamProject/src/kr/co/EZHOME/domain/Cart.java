package kr.co.EZHOME.domain;

import org.springframework.stereotype.Service;

import kr.co.EZHOME.dao.CartDAO;
import kr.co.EZHOME.dto.CartDTO;

@Service
public class Cart {
	
	private final CartDAO cartDAO;
	
	public Cart(CartDAO cartDAO) {
		this.cartDAO = cartDAO;
	}
	
	//장바구니 개수 확인하기
	public int cartCnt(String userid) {
		int result = cartDAO.cartCnt(userid);
		
		return result;
	}
	
	//장바구니 추가
	public void insertCart(String item_name, String userid, CartDTO cartDTO, String item_cnt) {
		DataStatus result = cartDAO.cartCheck(item_name, userid);
		
		// 장바구니에 이미 있을 시 수량만 추가.
		// 신규일 시 그대로 추가
		if (result == DataStatus.Exist) {
			cartDAO.addCart(item_name, userid, Integer.parseInt(item_cnt));
		}
		else {
			cartDAO.insertCart(cartDTO);
		}
	}

}
