package kr.co.EZHOME.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.EZHOME.domain.Cart;
import kr.co.EZHOME.domain.DAOResult;
import kr.co.EZHOME.domain.Item;
import kr.co.EZHOME.dto.CartDTO;

@Controller
public class CartController {

	private final Cart cart;
	private final Item item;
	
	public CartController(Cart cart, Item item) {
		this.cart = cart;
		this.item = item;
	}

	@PostMapping("/cartDelete.do")
	public String cartDeleteDo(HttpServletRequest request) {
		// 장바구니 삭제(개별,전체) 서블릿.
		// 장바구니에서 개별 삭제를 누르면 check 값이 0이 넘어오고,
		// 전체 삭제를 누르면 1이 넘어옴.
		// check을 이용하여 0일 경우 개별삭제, 1일 경우 전체삭제를 실행함.

		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		int check = Integer.parseInt(request.getParameter("check"));
		int cart_seq = -1;
		if (check == 0) {
			cart_seq = Integer.parseInt(request.getParameter("cart_seq"));
		}
		
	
		cart.deleteCart(check, cart_seq, userid);

		return "redirect:/cartList.do";
	}

	@PostMapping("/cartCntModify.do")
	public String cartCntModifyDo(HttpServletRequest request) {
		// 장바구니에서 수량 변경을 누르면 cart_seq(장바구니 품목 각각의 고유 번호)와 item_cnt(수량)이 넘어옴
		// 넘어온 값을 이용해 수량을 변경함.

		int cart_seq = Integer.parseInt(request.getParameter("cart_seq"));
		int item_cnt = Integer.parseInt(request.getParameter("item_cnt"));

		cart.cartCntModify(item_cnt, cart_seq);

		return "redirect:/cartList.do";
	}
	
	@GetMapping("/cartList.do")
	public String cartListDo(HttpServletRequest request) {

		// 장바구니 리스트를 출력하는 서블릿
		// 세션에 저장된 userid를 이용하여
		// 해당 유저의 장바구니 모두 출력함
		// 장바구니에 담은 뒤, 다른 사용자가 해당 품목에 대해 결제 완료가 될 경우
		// 재고에 대한 갱신이 필요한데,
		// cartItemQuantityModify가 그 역할을 수행함.
		// 장바구니 진입시 재고가 0인 상품이 있다면 품절 메세지
		// 선택해둔 수량보다 재고가 적어진다면 선택한 수량을 자동으로 재고량으로 맞추고 재고량 변동 메세지
		// 작업이 모두 끝나면 장바구니 정보를 clist에 담음.
		// cart.jsp로 이동하기 전 세션의 장바구니갯수정보를 업데이트함.

		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		String message = "";
		
		//장바구니를 출력하기 전에 상품DB와 동기화
		message = synchronizeItemAndCart(userid);
		
		//동기화가 반영된 장바구니 리스트 가져오기
		ArrayList<CartDTO> cartList = cart.getCartList(userid);
		request.setAttribute("clist", cartList);
		if (message != "") {
			request.setAttribute("message", ("[ " + message + "] 상품의 재고 정보가 변동되어 장바구니가 수정됩니다."));
		}
		session.setAttribute("cartCnt", cartList.size());
		
		return "cart/cart";
	}
	
	@PostMapping("/cartInsert.do")
	public String cartInsertDo(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 장바구니에 담기 위한 서블릿
		// 메인화면, 상품리스트, 상품상세정보에서
		// 장바구니에 담을경우 이 서블릿으로 이동함.
		// 비로그인 상태일시 아무것도 이루어지지 않고 왔던 페이지로 이동.
		// 로그인 상태일시 각각의 페이지에서 넘어온 파라미터 값으로
		// cartTBL에 추가함.
		// 만약, 같은 이름의 상품이 이미 장바구니에 있다면
		// 새로 추가하는 것이 아닌, 선택한 수량만큼 기존 수량에 + 됨.
		// 모든 작업이 끝난 뒤, 왔던 페이지로 이동함.

		String userid = request.getParameter("userid");
		
		if (userid != "") {
			String item_quantity = request.getParameter("item_quantity");
			String item_num = request.getParameter("item_num");
			String item_pictureUrl1 = request.getParameter("item_pictureUrl1");
			String item_name = request.getParameter("item_name");
			String item_price = request.getParameter("item_price");
			String item_cnt = request.getParameter("item_cnt");

			CartDTO cartDTO = new CartDTO();
			cartDTO.setUserid(userid);
			cartDTO.setItem_quantity(Integer.parseInt(item_quantity));
			cartDTO.setItem_num(Integer.parseInt(item_num));
			cartDTO.setItem_pictureUrl1(item_pictureUrl1);
			cartDTO.setItem_name(item_name);
			cartDTO.setItem_price(item_price);
			cartDTO.setItem_cnt(Integer.parseInt(item_cnt));
			
			cart.insertCart(item_name, userid, cartDTO, item_cnt);
			
			HttpSession session = request.getSession();
			session.setAttribute("cartCnt", cart.cartCnt(userid));
		}

		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
	
	public String synchronizeItemAndCart(String userid) {
		// 장바구니 리스트 가져오기
		ArrayList<CartDTO> cartList = cart.getCartList(userid);
		String message = "";
		
		// 상품 정보와 불러온 장바구니 정보를 동기화
		for (int i = 0; i < cartList.size(); i++) {
			int itemNum = cartList.get(i).getItem_num();
			int quantity = item.selectItem(itemNum).get(0).getItem_quantity();
			int cnt = cartList.get(i).getItem_cnt();
			// 품절 체크
			int check = 0;

			cart.cartItemQuantityModify(quantity, itemNum);

			if (quantity == 0) {
				message += cartList.get(i).getItem_name() + "(품절) ";
				// 메시지가 담겼기 때문에 횟수 증가
				cart.deleteCart(cartList.get(i).getCart_seq());
				// 품절이 되었기 때문에 1로 변경
				check = 1;

			}

			if (quantity < cnt) {
				cart.cartItemCntModify(quantity, itemNum);
				// 메시지가 담겼기 때문에 횟수 증가
				if (check == 0) {
					message += cartList.get(i).getItem_name() + "(재고량 변동) ";
				}
			}
		}
		return message;
	}
}
