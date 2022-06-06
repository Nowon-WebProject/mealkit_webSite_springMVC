package kr.co.EZHOME.dao;

import org.springframework.stereotype.Repository;

import kr.co.EZHOME.database.CartMapper;
import kr.co.EZHOME.domain.DataStatus;
import kr.co.EZHOME.dto.CartDTO;

@Repository
public class CartDAO {
	
	private final CartMapper cartMapper;
	
	public CartDAO(CartMapper cartMapper) {
		this.cartMapper = cartMapper;
	}
	
	public int cartCnt(String userid) {
		int result = cartMapper.cartCnt(userid);

		return result;
	}
	
	//장바구니 DB 변경 (이미 DB가 있는경우 수량 + )
	public void addCart(String item_name, String userid, int item_cnt) {
		cartMapper.addCart(item_name, item_cnt, userid);
	}
	
	//장바구니 DB 추가
	public void insertCart(CartDTO cartDTO) {
		cartMapper.insertCart(cartDTO);
	}
	
	
	
	//장바구니에 이미 넣어져 있는 상품인지 확인
	public DataStatus cartCheck(String item_name, String userid) {
		DataStatus result;
		
		int cartResult = cartMapper.cartCheck(item_name, userid);
		
		//장바구니에 존재하는 상품일경우
		if (cartResult > 0) {
			result = DataStatus.Exist;
		}
		else {
			result = DataStatus.Not_Exist;
		}
		
		return result;
	}
}
