package kr.co.EZHOME.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.EZHOME.domain.Cart;
import kr.co.EZHOME.domain.DataStatus;
import kr.co.EZHOME.domain.Item;
import kr.co.EZHOME.domain.Order;
import kr.co.EZHOME.domain.User;
import kr.co.EZHOME.dto.CartDTO;
import kr.co.EZHOME.dto.MyAddrDTO;
import kr.co.EZHOME.dto.OrderDTO;
import kr.co.EZHOME.dto.RecentAddrDTO;

@Controller
public class OrderController {

	private final Order order;
	private final Cart cart;
	private final Item item;
	private final User user;

	public OrderController(Order order, Cart cart, Item item, User user) {
		this.order = order;
		this.cart = cart;
		this.item = item;
		this.user = user;
	}

	/////////////////////////////////////////////////////////////////////
	@GetMapping("/orderOk.do")
	public String orderOkDo(HttpServletRequest request) {
		// 주문 완료 서블릿
		// payment.jsp에서 결제가 이루어진 후
		// 주문 정보를 가지고 이곳으로 넘어옴.
		// 넘어온 값들을 이용해
		// 유저 포인트 갱신, 주문완료 테이블에 추가, 최근 배송지 추가/삭제가 이루어짐.
		String userid = request.getParameter("userid");
		String order_name = request.getParameter("item_name");
		int amount = Integer.parseInt(request.getParameter("total_price")); // 배송비, 적립금 포함
		String deli_name = request.getParameter("deli_name");
		String deli_addr = request.getParameter("deli_addr");
		String deli_phone = request.getParameter("deli_phone");
		String deli_msg = request.getParameter("deli_msg");
		String deli_pwd = request.getParameter("deli_pwd");
		String deli_status = request.getParameter("deli_status");
		int usePoint = Integer.parseInt(request.getParameter("usePoint"));
		int addPoint = Integer.parseInt(request.getParameter("point"));
		
		String item_num_encode = request.getParameter("item_num");
		String item_cnt_encode = request.getParameter("item_cnt");
		String deli_postcode = request.getParameter("deli_postcode");

		String item_num[] = item_num_encode.split(" ");
		String item_cnt[] = item_cnt_encode.split(" ");
		
		// 4자리 숫자+대문자영문 조합 생성 (주문번호)
		Random rnd = new Random();
		StringBuffer buf = new StringBuffer();
		for (int i = 1; i <= 8; i++) {
			if (rnd.nextBoolean())
				buf.append((char) (rnd.nextInt(26) + 65)); // 0~25(26개) + 65
			else
				buf.append(rnd.nextInt(10));
		}

		String random = buf.toString();
		System.out.println(random);

		String time = new SimpleDateFormat("yyMMddHHmmss").format(System.currentTimeMillis());
		String order_num = time + random;

		//사용할 포인트 DB 적용
		user.applyPoint(usePoint, addPoint, userid);

		// 반복 횟수 : 장바구니에 들어있던 상품의 종류 갯수
		int cnt = cart.cartCnt(userid);
		
		OrderDTO orderDTO = new OrderDTO();
		// 주문한 품목에 대한 정보도 함께 db에 넣음.
		for (int i = 0; i < cnt; i++) {
			//해당 아이템 넘버의 이름
			int itemNum = Integer.parseInt(item_num[i]);
			int itemCnt = Integer.parseInt(item_cnt[i]);
			String item_name = item.selectItem(itemNum).get(0).getItem_name();
			System.out.println(item_num);
			int item_price = item.selectItem(itemNum).get(0).getItem_price();
			String item_pictureUrl1 = item.selectItem(itemNum).get(0).getItem_pictureUrl1();

			orderDTO.setOrder_num(order_num);
			orderDTO.setUserid(userid);
			orderDTO.setOrder_name(order_name);
			orderDTO.setAmount(amount);
			orderDTO.setUsePoint(usePoint);
			orderDTO.setDeli_name(deli_name);
			orderDTO.setDeli_addr(deli_addr);
			orderDTO.setDeli_phone(deli_phone);
			orderDTO.setDeli_msg(deli_msg);
			orderDTO.setDeli_pwd(deli_pwd);
			orderDTO.setDeli_status(deli_status);
			orderDTO.setItem_pictureUrl1(item_pictureUrl1);
			orderDTO.setItem_num(itemNum);
			orderDTO.setItem_name(item_name);
			orderDTO.setItem_price(item_price);
			orderDTO.setItem_cnt(itemCnt);
			orderDTO.setRefund_request("");
			orderDTO.setRefund_status("미신청");
			orderDTO.setRefund_reject("");

			order.insertOrder(orderDTO);
			// 재고, 판매량 갱신
			String sql1 = "+";
			String sql2 = "-";
			item.updateSalesAndQuantity(itemCnt, itemNum, sql1, sql2);
		}

		// 장바구니 비우기
		cart.deleteAllCart(userid);

		// 최근 배송지 추가,삭제
		RecentAddrDTO recentAddrDTO = new RecentAddrDTO();
		recentAddrDTO.setUserid(userid);
		recentAddrDTO.setDeli_name(deli_name);
		recentAddrDTO.setDeli_addr(deli_addr);
		recentAddrDTO.setDeli_phone(deli_phone);
		recentAddrDTO.setDeli_msg(deli_msg);
		recentAddrDTO.setDeli_pwd(deli_pwd);

		DataStatus recentAddrCheckResult = order.recentAddrCheck(deli_postcode, deli_name, userid);
		//최근배송지가 중복되지 않을 경우에만 넣기
		if (recentAddrCheckResult == DataStatus.Not_Exist) {
			order.insertRecentAddr(recentAddrDTO);
		}

		int addrCnt = order.getRecentAddr(userid).size();
		if (addrCnt > 5) {
			int oldAddrSeq = order.oldRecntAddrFind(userid);
			order.deleteRecentAddr(oldAddrSeq);
		}

		HttpSession session = request.getSession();
		session.setAttribute("cartCnt", cart.cartCnt(userid));
		try {
			session.setAttribute("point", user.findUser(userid).getPoint());
			//해당 userid가 DB상에 존재하지 않을때 에러가 발생된다
		}catch(Exception e) {
			e.printStackTrace();
		}

		return "order/orderOk";
	}

	@PostMapping("/payment.do")
	public String paymentDo(HttpServletRequest request) {
		// 결제 서블릿.
		// order에서 넘어온 정보를
		// payment로 보낼 준비를 하고,
		// 또 한번 재고 체크를 진행함.

		String url = "order/payment";
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		String item_name = null;
		int etc = (int) session.getAttribute("cartcnt") - 1;
		String deli_name = request.getParameter("deli_name");
		String deli_phone = request.getParameter("deli_phone");
		String deli_addr = "(" + request.getParameter("deli_postcode") + ") " + request.getParameter("deli_addr1")
				+ ", " + request.getParameter("deli_addr2");
		String deli_postcode = request.getParameter("deli_postcode");
		String deli_msg = request.getParameter("deli_msg");
		String deli_pwd = request.getParameter("deli_pwd");
		String deli_status = request.getParameter("deli_status");
		String[] item_num = request.getParameterValues("item_num[]");
		String[] item_cnt = request.getParameterValues("item_cnt[]");
		int total_price = Integer.parseInt(request.getParameter("total_price"));
		int usePoint = Integer.parseInt(request.getParameter("usePoint"));
		int amount = total_price - usePoint;
		int point = Integer.parseInt(request.getParameter("point"));

		// etc = cartCnt - 1 => ~상품 외 몇건 을 저장하기 위한 값
		if (etc == 0) {
			item_name = request.getParameter("item_name");
			request.setAttribute("item_name", item_name);
		} else {
			item_name = request.getParameter("item_name") + " 외 " + etc + " 건";
			request.setAttribute("item_name", item_name);
		}

		request.setAttribute("deli_addr", deli_addr);
		request.setAttribute("total_price", total_price);
		request.setAttribute("usePoint", usePoint);
		request.setAttribute("point", point);
		request.setAttribute("amount", amount);
		request.setAttribute("deli_msg", deli_msg);
		request.setAttribute("deli_pwd", deli_pwd);
		request.setAttribute("deli_postcode", deli_postcode);
		request.setAttribute("deli_status", deli_status);
		request.setAttribute("userid", userid);
		request.setAttribute("deli_name", deli_name);
		request.setAttribute("deli_phone", deli_phone);

		//문자열 배열을 문자열로 (get 방식 하기 위함)
		String itemNum = String.join(" ",item_num);
		String itemCnt = String.join(" ",item_cnt);
		request.setAttribute("item_num", itemNum);
		request.setAttribute("item_cnt", itemCnt);
		
		
		// 구매할 시점에 재고보다 구매량이 많을경우 구매실패
		int cnt = cart.cartCnt(userid);
		String message = "";
		int check = 0;
		for (int i = 0; i < cnt; i++) {
			int item_quantity = item.selectItem(Integer.parseInt(item_num[i])).get(0).getItem_quantity();

			// 재고량이 더 적은 경우 , 많은 경우
			if (Integer.parseInt(item_cnt[i]) > item_quantity) {
				String item_name1 = item.selectItem(Integer.parseInt(item_num[i])).get(0).getItem_name();
				message += item_name1 + " ";
				check = 1;
			}
		}
		if (check == 1) {
			url = "forward:/order.do";
		}
		request.setAttribute("message", "[ " + message + "] 의 재고보다 구매하시려는 양이 많아 결제가 취소됩니다. 확인 후 다시 주문해주세요.");

		return url;
	}

	@PostMapping("/myAddrModify.do")
	public String myAddrModifyDo(HttpServletRequest request) {
		// 나의 배송지 수정 서블릿
		// seq값을 이용해 해당하는 배송지 정보를 수정함.
		int my_deli_addr_seq = Integer.parseInt(request.getParameter("my_deli_addr_seq"));
		String my_deli_nick = request.getParameter("deli_nick");
		String my_deli_name = request.getParameter("deli_name");
		String my_deli_addr = "(" + request.getParameter("deli_postcode") + ") " + request.getParameter("deli_addr1")
				+ ", " + request.getParameter("deli_addr2");
		String my_deli_phone = request.getParameter("deli_phone");
		String my_deli_msg = request.getParameter("deli_msg");
		String my_deli_pwd = request.getParameter("deli_pwd");

		MyAddrDTO myAddrDTO = new MyAddrDTO();
		myAddrDTO.setMy_deli_addr_seq(my_deli_addr_seq);
		myAddrDTO.setMy_deli_nick(my_deli_nick);
		myAddrDTO.setMy_deli_name(my_deli_name);
		myAddrDTO.setMy_deli_addr(my_deli_addr);
		myAddrDTO.setMy_deli_phone(my_deli_phone);
		myAddrDTO.setMy_deli_msg(my_deli_msg);
		myAddrDTO.setMy_deli_pwd(my_deli_pwd);

		order.updateMyAddr(myAddrDTO);

		return "redirect:/myAddrManage.do";
	}

	@GetMapping("/myAddrModify")
	public String myAddrModify() {

		return "order/myAddrModify";
	}

	@PostMapping("/myAddrDelete.do")
	public String myAddrDeleteDo(HttpServletRequest request) {
		// 나의 배송지 삭제 서블릿
		// seq값을 받아와 해당하는 데이터를 삭제함.
		int my_deli_addr_seq = Integer.parseInt(request.getParameter("my_deli_addr_seq"));
		order.deleteMyAddr(my_deli_addr_seq);

		return "redirect:/myAddrManage.do";
	}

	@GetMapping("/myAddrInsert")
	public String myAddrInsert() {

		return "order/myAddrInsert";
	}

	@GetMapping("/myAddrManage.do")
	public String myAddrManageDo(HttpServletRequest request) {

		// 나의 배송지 메인화면 서블릿
		// 저장된 배송지를 출력하고, 배송지 추가를 담당함.
		// 나의 배송지는 5개까지 저장 가능하며, 추가를 원할 시 삭제 후 시도해야 함.

		String url = "myAddrManage.jsp";

		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		String deli_nick = request.getParameter("deli_nick");
		// 배송지 추가 케이스인 경우
		if (deli_nick != null) {
			String deli_name = request.getParameter("deli_name");
			String deli_addr = "(" + request.getParameter("deli_postcode") + ") " + request.getParameter("deli_addr1")
					+ ", " + request.getParameter("deli_addr2");
			String deli_phone = request.getParameter("deli_phone");
			String deli_msg = request.getParameter("deli_msg");
			String deli_pwd = request.getParameter("deli_pwd");
			String deli_postcode = request.getParameter("deli_postcode");
			System.out.println(deli_nick);
			MyAddrDTO myAddrDTO = new MyAddrDTO();
			myAddrDTO.setUserid(userid);
			myAddrDTO.setMy_deli_nick(deli_nick);
			myAddrDTO.setMy_deli_name(deli_name);
			myAddrDTO.setMy_deli_addr(deli_addr);
			myAddrDTO.setMy_deli_phone(deli_phone);
			myAddrDTO.setMy_deli_msg(deli_msg);
			myAddrDTO.setMy_deli_pwd(deli_pwd);

			// 나의 배송지 등록하기
			order.insertNewMyAddr(myAddrDTO, deli_postcode);
		}
		ArrayList<MyAddrDTO> myAddrList = order.getMyAddrList(userid);
		request.setAttribute("malist", myAddrList);

		session.setAttribute("myaddrcnt", myAddrList.size());

		return "order/myAddrManage";
	}

	@PostMapping("/order.do")
	public String orderDo(HttpServletRequest request) {
		// 주문페이지 서블릿
		// 장바구니 리스트를 출력하며
		// 장바구니 페이지와 마찬가지로 페이지 접근 시 재고량을 체크함.
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		ArrayList<CartDTO> clist = cart.getCartList(userid);

		request.setAttribute("clist", clist);
		String message2 = "";

		message2 = checkQuantity(clist, message2);

		request.setAttribute("message2", ("[ " + message2 + "] 상품의 재고량에 문제가 생겼습니다. 다시 확인해주세요"));
		session.setAttribute("cartcnt", cart.cartCnt(userid));

		// 최근배송지 출력, 최근배송지 나의배송지 갯수 정보 저장
		ArrayList<RecentAddrDTO> addrList = order.getRecentAddr(userid);
		request.setAttribute("alist", addrList);
		session.setAttribute("addrcnt", addrList.size());

		return "order/order";
	}

	public String checkQuantity(ArrayList<CartDTO> clist, String message2) {
		for (int i = 0; i < clist.size(); i++) {
			int ItemNum = clist.get(i).getItem_num();
			int quantity = item.selectItem(ItemNum).get(0).getItem_quantity();
			int cnt = clist.get(i).getItem_cnt();
			if (quantity < cnt) {
				message2 += clist.get(i).getItem_name() + " ";
			}
		}
		return message2;
	}
}