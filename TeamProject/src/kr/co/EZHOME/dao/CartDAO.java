package kr.co.EZHOME.dao;

import java.util.ArrayList;

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
	
	//해당 유저의 장바구니 전체 삭제
	public void deleteAllCart(String userid) {
		cartMapper.deleteAllCart(userid);
	}
	
	// 장바구니 페이지에서 상품의 수량 변경 메서드
	public void cartCntModify(int item_cnt, int cart_seq) {
		cartMapper.cartCntModify(item_cnt, cart_seq);
	}
	
	//해당 아이템의 재고량 변경
	public void cartItemCntModify(int quantity, int itemNum) {
		cartMapper.cartItemCntModify(quantity, itemNum);
	}
	
	// 장바구니리스트에서 삭제 (품절되었기 떄문)
	public void deleteCart(int cartSeq) {
		cartMapper.deleteCart(cartSeq);
	}
	
	//장바구니에 있는 재고량을 상품 DB와 동기화
	public void cartItemQuantityModify(int quantity, int itemNum) {
		cartMapper.cartItemQuantityModify(quantity, itemNum);
	}
	
	// 장바구니 리스트 가져오기
	public ArrayList<CartDTO> getCartList(String userid) {
		ArrayList<CartDTO> cartList = cartMapper.getCartList(userid);
		
		return cartList;
	}
	
	
	//장바구니 개수 새기
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
