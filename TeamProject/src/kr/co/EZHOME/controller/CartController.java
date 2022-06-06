package kr.co.EZHOME.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.EZHOME.domain.Cart;
import kr.co.EZHOME.domain.DAOResult;
import kr.co.EZHOME.dto.CartDTO;

@Controller
public class CartController {

	private final Cart cart;

	public CartController(Cart cart) {
		this.cart = cart;
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
}
