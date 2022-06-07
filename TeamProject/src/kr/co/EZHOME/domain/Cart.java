package kr.co.EZHOME.domain;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import kr.co.EZHOME.dao.CartDAO;
import kr.co.EZHOME.dto.CartDTO;

@Service
public class Cart {

	private final CartDAO cartDAO;

	public Cart(CartDAO cartDAO) {
		this.cartDAO = cartDAO;
	}

	// 해당 유저의 장바구니 전체 삭제
	public void deleteAllCart(String userid) {
		cartDAO.deleteAllCart(userid);
	}

	public void deleteCart(int check, int cart_seq, String userid) {

		if (check == 0) {
			cartDAO.deleteCart(cart_seq);
		} else {
			cartDAO.deleteAllCart(userid);
		}
	}

	// 장바구니 페이지에서 상품의 수량 변경 메서드
	public void cartCntModify(int item_cnt, int cart_seq) {
		cartDAO.cartCntModify(item_cnt, cart_seq);
	}

	// 해당 아이템의 재고량 변경
	public void cartItemCntModify(int quantity, int itemNum) {
		cartDAO.cartItemCntModify(quantity, itemNum);
	}

	// 장바구니리스트에서 삭제 (품절되었기 떄문)
	public void deleteCart(int cartSeq) {
		cartDAO.deleteCart(cartSeq);
	}

	// 장바구니에 있는 재고량을 상품 DB와 동기화
	public void cartItemQuantityModify(int quantity, int itemNum) {
		cartDAO.cartItemQuantityModify(quantity, itemNum);
	}

	// 장바구니 리스트 가져오기
	public ArrayList<CartDTO> getCartList(String userid) {
		ArrayList<CartDTO> cartList = cartDAO.getCartList(userid);

		return cartList;
	}

	// 장바구니 개수 확인하기
	public int cartCnt(String userid) {
		int result = cartDAO.cartCnt(userid);

		return result;
	}

	// 장바구니 추가
	public void insertCart(String item_name, String userid, CartDTO cartDTO, String item_cnt) {
		DataStatus result = cartDAO.cartCheck(item_name, userid);

		// 장바구니에 이미 있을 시 수량만 추가.
		// 신규일 시 그대로 추가
		if (result == DataStatus.Exist) {
			cartDAO.addCart(item_name, userid, Integer.parseInt(item_cnt));
		} else {
			cartDAO.insertCart(cartDTO);
		}
	}

}
