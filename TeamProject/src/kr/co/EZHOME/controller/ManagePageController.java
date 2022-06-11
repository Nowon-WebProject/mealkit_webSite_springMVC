package kr.co.EZHOME.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServlet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.EZHOME.beans.PageDTO;
import kr.co.EZHOME.domain.Board;
import kr.co.EZHOME.domain.FileUploadServiceImpl;
import kr.co.EZHOME.domain.Item;
import kr.co.EZHOME.domain.Order;
import kr.co.EZHOME.domain.User;
import kr.co.EZHOME.dto.BbsDTO;
import kr.co.EZHOME.dto.ItemDTO;
import kr.co.EZHOME.dto.OrderDTO;
import kr.co.EZHOME.dto.UserDTO;

@Controller
public class ManagePageController {

	private final User user;
	private final Board board;
	private final Item item;
	private final Order order;
	private final FileUploadServiceImpl fileuploadService;

	public ManagePageController(User user, Board board, Item item, Order order,
			FileUploadServiceImpl fileuploadService) {
		this.user = user;
		this.board = board;
		this.item = item;
		this.order = order;
		this.fileuploadService = fileuploadService;
	}
	
	//모든 상품 삭제
	@GetMapping("/deleteAll")
	public String deleteAll() {
		
		item.deleteAllItems();
		
		return "redirect:/itemListManagePage.do";
	}
	
	
	//상품 수정
	@PostMapping("/itemUpdateDo")
	public String itemUpdateDoPost(@ModelAttribute ItemDTO itemDTO, MultipartFile[] uploadfiles, Model model,
			HttpServletRequest request) {
		
		String saveDirectory = request.getServletContext().getRealPath("resources/images/item");
		// Save mediaFile on system
		String fileName;
		int count = 1;
		double item_discount = itemDTO.getItem_discount();

		//할인율 형식 맞추기
		if (item_discount > 1) {
			itemDTO.setItem_discount(item_discount / 100.0);
		}
		
		for (MultipartFile file : uploadfiles) {
			fileName = fileuploadService.saveFile(file, saveDirectory, count);
			if (count == 1) {
				itemDTO.setItem_pictureUrl1(fileName);
			} else {
				itemDTO.setItem_pictureUrl2(fileName);
			}
			count++;
		}
		
		String check = request.getParameter("item_category");
		System.out.println(check);
		if(check.equals("new")) {
			itemDTO.setItem_category(request.getParameter("newCategory"));
		}
		
		// 상품 정보 DB저장
		item.updateItem(itemDTO);
		
		return "redirect:/itemListManagePage.do";
	}
	
	// itemUpdate.jsp 로 이동
	@GetMapping("/itemUpdateDo")
	public String itemUpdateDo(int item_num, Model model, HttpServletRequest request) {
		
		ArrayList<ItemDTO> list = item.selectItem(item_num);
		
		model.addAttribute("item", list.get(0));
		
		Vector<ItemDTO> categoryList = item.getCategoryList();
		request.setAttribute("categoryList", categoryList);
		
		return "managePage/itemUpdate";
	}
	
	// 상품 삭제
	@PostMapping("itemDeleteDo")
	public String itemDeleteDo(int item_num) {
		
		item.deleteItem(item_num);
		
		return "forward:/itemListManagePage.do";
	}
	
	//itemDelete.jsp 페이지로 이동
	@GetMapping("/itemDeleteDo")
	public String itemDeleteDo(int item_num, Model model) {
		
		ArrayList<ItemDTO> list = item.selectItem(item_num);
		ItemDTO itemDTO = list.get(0);
		
		model.addAttribute("item", itemDTO);
		
		return "managePage/itemDelete";
	}
	
	// 상품등록 기능
	@PostMapping("/itemWriteDo")
	public String itemWriteDo(@ModelAttribute ItemDTO itemDTO, MultipartFile[] uploadfiles, Model model,
			HttpServletRequest request) throws IOException {

		String saveDirectory = request.getServletContext().getRealPath("resources/images/item");
		// Save mediaFile on system
		String fileName;
		double item_discount = itemDTO.getItem_discount();
		int count = 1;

		for (MultipartFile file : uploadfiles) {
			fileName = fileuploadService.saveFile(file, saveDirectory, count);
			if (count == 1) {
				itemDTO.setItem_pictureUrl1(fileName);
			} else {
				itemDTO.setItem_pictureUrl2(fileName);
			}
			count++;
		}
		if (item_discount > 0) {
			itemDTO.setItem_discount(item_discount / 100.0);
		}
		
		
		String check = request.getParameter("item_category");
		System.out.println(check);
		if(check.equals("new")) {
			itemDTO.setItem_category(request.getParameter("newCategory"));
		}
		
		
		
		// 상품 정보 DB저장
		item.insertItem(itemDTO);
		return "redirect:/itemListManagePage.do";
	}

	// 아이템 리스트 관리자 페이지 (post방식)
	@PostMapping("/itemListManagePage.do")
	public String itemListManagePageDo(@ModelAttribute("pageInfo") PageDTO pageBean, Model model) {

		// 게시글 출력될 페이지 번호 계산(페이징 작업)
		item.calculatingPageNumber(pageBean);

		// 모든 상품 리스트 뽑아오기
		List<ItemDTO> list = item.selectAllItems(pageBean.getStartRow(), pageBean.getEndRow());

		model.addAttribute("items", list);
		model.addAttribute("page", pageBean);

		return "managePage/itemListManagement";
	}

	// 상품등록 창으로 이동
	@GetMapping("/itemWriteDo")
	public String itemWriteDo(HttpServletRequest request) {
		
		Vector<ItemDTO> categoryList = item.getCategoryList();
		request.setAttribute("categoryList", categoryList);

		return "managePage/itemWrite";
	}

	// 아이템 리스트 관리자 페이지
	@GetMapping("/itemListManagePage")
	public String itemListManagePage(@ModelAttribute("pageInfo") PageDTO pageBean, Model model) {

		// 게시글 출력될 페이지 번호 계산(페이징 작업)
		item.calculatingPageNumber(pageBean);

		// 모든 상품 리스트 뽑아오기
		List<ItemDTO> list = item.selectAllItems(pageBean.getStartRow(), pageBean.getEndRow());

		model.addAttribute("items", list);
		model.addAttribute("page", pageBean);

		return "managePage/itemListManagement";
	}

	@GetMapping("/refundManageOk.do")
	public String refundManageOkDo(HttpServletRequest request) {

		// 취소/환불 요청 관리 서블릿
		// refundManage.jsp에서 승인을 눌러 넘어온 값들을 이용하여
		// 결제를 취소하는 작업을 함.
		// 재고 + , 판매량 -

		String[] orderInfo = request.getParameterValues("orderInfo");

		String check = request.getParameter("check");
		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");

		String refund_status = "";

		if (check.equals("승인")) {
			for (int i = 0; i < orderInfo.length; i++) {
				String orderInfo2 = orderInfo[i];
				String[] orderInfo3 = orderInfo2.split("/");

				int num = Integer.parseInt(orderInfo3[0]); // item_num
				int cnt = Integer.parseInt(orderInfo3[1]); // item_cnt
				String order_num = orderInfo3[2];

				item.updateSalesAndQuantity(cnt, num);

				refund_status = "취소 완료";
				order.modifyRefundStatus(order_num, refund_status, num);

			}
		} else {
			for (int i = 0; i < orderInfo.length; i++) {
				String orderInfo2 = orderInfo[i];
				String[] orderInfo3 = orderInfo2.split("/");

				int num = Integer.parseInt(orderInfo3[0]); // item_num
				String order_num = orderInfo3[2];

				refund_status = "거절";
				order.modifyRefundStatus(order_num, refund_status, num);

				String reject = request.getParameter("reject");
				if (reject.equals("empty")) {
					reject = request.getParameter("reject2");
				}
				order.updateReject(reject, order_num, num);
			}
		}

		return "redirect:/refundManage.do?pageNum=1&pageSize=10&category=" + category + "&keyword=" + keyword + "";
	}

	@GetMapping("/refundManage.do")
	public String refundManageDo(HttpServletRequest request) {

		// 모든 유저의 결제정보를 출력하기 위한 서블릿

		// 모든 유저의 결제정보를 출력하기 위한 서블릿

		// 화면에 보여질 총 게시글 개수
		int pageSize = 10;
		String ps = request.getParameter("pageSize");
		if (ps == null)
			pageSize = 10;
		else
			pageSize = Integer.parseInt(ps);

		// 누른 페이지
		String pageNum = request.getParameter("pageNum");
		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");

		// 처음엔 1페이지
		if (pageNum == null)
			pageNum = "1";

		// 현재 페이지 (누른 페이지 또는 1페이지)
		int currentPage = Integer.parseInt(pageNum);

		// 전체 글 개수
		int count = 0;
		count = order.getRefundRequestCnt(category, keyword);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = (currentPage * pageSize);

		int countResult[] = item.pageCount(count, pageSize, currentPage);
		int startPage = countResult[0];
		int endPage = countResult[1];
		int pageCount = countResult[2];

		request.setAttribute("startPage", startPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("endPage", endPage);
		request.setAttribute("count", count);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("currentPage", currentPage);
		ArrayList<OrderDTO> olist = order.getRefundRequestList(category, keyword, startRow, endRow);
		request.setAttribute("olist", olist);

		return "order/refundManage";
	}

	@PostMapping("/refundRequest.do")
	public String refundRequestDo(HttpServletRequest request) {

		// 유저의 취소/환불 요청 서블릿
		// 원하는 품목을 체크하고 신청을 누르면
		// 해당 값을 이용하여 작업이 이루어짐
		// 배송상태가 '결제완료'일 시 즉시 취소가 되며
		// 배송준비, 배송완료 상태일 시 취소 요청 상태로 넘어감.

		String[] a = request.getParameterValues("orderInfo");
		String order_num = request.getParameter("order_num");
		request.getParameter("infoCheck");

		String refund_request = request.getParameter("refund_request");

		String refund_status = "";

		for (int i = 0; i < a.length; i++) {
			String a1 = a[i];
			String[] a2 = a1.split("/");

			int num = Integer.parseInt(a2[0]); // item_num
			int cnt = Integer.parseInt(a2[3]); // item_cnt
			String deli_status = a2[4]; // item_name
			if (deli_status.equals("결제완료")) {
				item.updateSalesAndQuantity(cnt, num);
				refund_status = "취소 완료";
				order.modifyRefundStatus(order_num, refund_status, num);

			} else {
				if (refund_request.equals("empty")) {
					refund_request = request.getParameter("refund_request2");
				}
				refund_status = "취소 요청 중..";
				order.modifyRefundRequest(order_num, refund_request, num);
				order.modifyRefundStatus(order_num, refund_status, num);
			}

		}

		return "redirect:/orderInfo.do?order_num=" + order_num + "&infoCheck=1";
	}

	@GetMapping("/orderManageOk.do")
	public String orderManageOkDo(HttpServletRequest request) {

		// 관리자가 변경할 배송상태와 변경할 주문정보를 체크하여 값이 넘어옴.
		// 해당하는 주문정보들의 배송상태를 넘어온 값으로 변경함.

		String num = request.getParameter("order_num");
		String deli_status = request.getParameter("deli_status");
		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");

		order.updateDeli_Status(deli_status, num);

		return "redirect:/orderManage.do?pageNum=1&pageSize=10&category=" + category + "&keyword=" + keyword + "";
	}

	@GetMapping("/orderManage.do")
	public String orderManageDo(HttpServletRequest request) {
		// 모든 유저의 결제정보를 출력하기 위한 서블릿

		// 화면에 보여질 총 게시글 개수
		int pageSize = 10;
		String ps = request.getParameter("pageSize");
		if (ps == null)
			pageSize = 10;
		else
			pageSize = Integer.parseInt(ps);

		// 누른 페이지
		String pageNum = request.getParameter("pageNum");
		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");

		// 처음엔 1페이지
		if (pageNum == null)
			pageNum = "1";

		// 현재 페이지 (누른 페이지 또는 1페이지)
		int currentPage = Integer.parseInt(pageNum);

		// 전체 글 개수
		int count = 0;
		count = order.getOrderManageCnt(category, keyword);

		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = (currentPage * pageSize);

		int countResult[] = item.pageCount(count, pageSize, currentPage);
		int startPage = countResult[0];
		int endPage = countResult[1];
		int pageCount = countResult[2];

		request.setAttribute("startPage", startPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("endPage", endPage);
		request.setAttribute("count", count);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("currentPage", currentPage);

		ArrayList<OrderDTO> olist = order.getAllOrderList(category, keyword, startRow, endRow);
		request.setAttribute("olist", olist);
		return "order/orderManage";
	}

	@GetMapping("/orderInfo.do")
	public String orderInfoDo(HttpServletRequest request) {

		String order_num = request.getParameter("order_num");
		int infoCheck = Integer.parseInt(request.getParameter("infoCheck"));
		System.out.println(order_num);
		ArrayList<OrderDTO> orderInfoList = order.getOrderInfo(order_num);

		request.setAttribute("olist", orderInfoList);
		request.setAttribute("infoCheck", infoCheck);

		return "order/orderInfo";
	}

	@GetMapping("/orderOkList.do")
	public String orderOkListDo(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");

		// 화면에 보여질 총 게시글 개수
		int pageSize = 10;
		String ps = request.getParameter("pageSize");
		if (ps == null)
			pageSize = 10;
		else
			pageSize = Integer.parseInt(ps);

		// 누른 페이지
		String pageNum = request.getParameter("pageNum");
		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");

		// 처음엔 1페이지
		if (pageNum == null)
			pageNum = "1";

		// 현재 페이지 (누른 페이지 또는 1페이지)
		int currentPage = Integer.parseInt(pageNum);

		// 전체 글 개수
		int count = 0;
		count = order.getOrderCnt(userid);

		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = (currentPage * pageSize);

		int countResult[] = item.pageCount(count, pageSize, currentPage);
		int startPage = countResult[0];
		int endPage = countResult[1];
		int pageCount = countResult[2];

		request.setAttribute("startPage", startPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("endPage", endPage);
		request.setAttribute("count", count);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("category", category);
		request.setAttribute("keyword", keyword);

		ArrayList<OrderDTO> olist = order.getOrderList(userid, startRow, endRow);
		request.setAttribute("olist", olist);

		return "order/orderOkList";
	}

	@PostMapping("bbsUpdate.do")
	public String bbsUpdateDo(@RequestParam("mediaFile") MultipartFile file, Model model, HttpServletRequest request) {

		BbsDTO bdto = new BbsDTO();
		String path = request.getServletContext().getRealPath("resources/images/board");
		String bbsid = request.getParameter("bbsid");
		String bbstitle = request.getParameter("bbstitle");
		String bbscontent = request.getParameter("bbscontent");
		String fileName = file.getOriginalFilename();

		bbscontent = bbscontent.replace("\n", "<br>");
		bdto.setBbsid(Integer.parseInt(bbsid));
		bdto.setBbstitle(bbstitle);
		bdto.setBbscontent(bbscontent);
		bdto.setBbsimg(fileName);

		board.updateMember(bdto);

		return "forward:/bbsList.do";

	}

	@PostMapping("/bbsWrite.do")
	public String bbsWriteDo(@RequestParam("mediaFile") MultipartFile file, Model model, HttpServletRequest request)
			throws IOException {

		String path = request.getServletContext().getRealPath("resources/images/board");
		String fileName = file.getOriginalFilename();
		String bbstitle = request.getParameter("bbstitle");
		String bbscontent = request.getParameter("bbscontent");
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		bbscontent = bbscontent.replace("\n", "<br>");

		BbsDTO bdto = new BbsDTO();

		bdto.setUserid(userid);
		bdto.setBbstitle(bbstitle);
		bdto.setBbscontent(bbscontent);

		// Save mediaFile on system
		if (!file.getOriginalFilename().isEmpty()) {
			file.transferTo(new File(path, fileName));
			model.addAttribute("msg", "File uploaded successfully.");
			model.addAttribute("file", fileName);
		} else {
			model.addAttribute("msg", "Please select a valid mediaFile..");
		}

		bdto.setBbsimg(fileName);

		board.bbsWrite(bdto);

		return "forward:/bbsList.do";
	}

	@PostMapping("/userBbsView.do")
	public String userBbsViewDo(HttpServletRequest request) {
		String bbsid = request.getParameter("bbsid");
		String url = "managePage/userBbsView";
		String file = "";

		int count = 0;

		BbsDTO bdto = new BbsDTO();
		Vector<BbsDTO> vec = new Vector<BbsDTO>();

		bdto = board.findBoard(bbsid);
		vec.add(bdto);

		bdto.setBbscount(bdto.getBbscount() + 1);
		// 조회수
		board.updateBBSCount(bdto);

		if (bdto.getBbsimg() == "" || bdto.getBbsimg() == null) {
		} else {
			file = bdto.getBbsimg();
		}

		request.setAttribute("file", file);
		request.setAttribute("vec", vec);

		return url;
	}

	@PostMapping("/userBbs.do")
	public String userBbsDo(HttpServletRequest request) {
		Vector<BbsDTO> vec = new Vector<BbsDTO>();
		Vector<BbsDTO> vec1 = new Vector<BbsDTO>();
		BbsDTO bdto;
		String page = request.getParameter("page");
		String size = request.getParameter("size");

		if (page == null || page == "") {
			page = "1";
		}
		if (size == null || size == "") {
			size = "10";
		}
		int pageNum = Integer.parseInt(page);
		int sizeNum = Integer.parseInt(size);
		String[] arr = { "", "", "" };

		switch (sizeNum) {
		case 10:
			arr[0] = "selected";
			break;
		case 15:
			arr[1] = "selected";
			break;
		case 20:
			arr[2] = "selected";
			break;
		}

		/*
		 * 1 2 3 4
		 * 
		 * 1 11 21 31
		 * 
		 * 10 20 30 40
		 */
		vec = board.getBBSList();

		int all = vec.size();
		if(vec.size() != 0) {
		int count = 0;
		if (all % sizeNum != 0) {
			count = 1;
		}
		all = all / sizeNum;
		if (count == 1) {
			all = all + 1;
		}
		int endNum = pageNum * sizeNum;
		if (endNum > vec.size()) {
			endNum = vec.size();
		}
		int startNum = endNum - sizeNum + 1;

		for (int i = startNum; i <= endNum; i++) {
			bdto = vec.get(i - 1);
			vec1.add(bdto);
		}

		int start=0;
        if(pageNum % 10 == 0) {start = pageNum - 9;}
        else { start = ((pageNum / 10) * 10) + 1;}
        int end = start + 9 ;
        if(end > all) {end = all;}

		request.setAttribute("page", page);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("all", all);
		request.setAttribute("vec", vec1);
		request.setAttribute("arr", arr);
		request.setAttribute("check", 0);
		}else {
			request.setAttribute("page", page);
			request.setAttribute("start", 0);
			request.setAttribute("end", 0);
			request.setAttribute("all", all);
			request.setAttribute("vec", vec1);
			request.setAttribute("arr", arr);
			request.setAttribute("check", 1);
			
		}
		
		
		return "managePage/userbbs";
	}

	@PostMapping("/bbsDelete.do")
	public String bbsDeleteDo(HttpServletRequest request) {

		String bbsid = request.getParameter("delete");

		board.deleteMember(bbsid);

		return "forward:/bbsList.do";
	}

	@PostMapping("/bbsView.do")
	public String bbsViewDo(HttpServletRequest request) {
		String bbsid = request.getParameter("bbsid");
		String url = "";
		String update = request.getParameter("update");

		String file = "";

		int count = 0;

		BbsDTO bdto = new BbsDTO();
		Vector<BbsDTO> vec = new Vector<BbsDTO>();

		bdto = board.findBoard(bbsid);
		vec.add(bdto);

		if (update == null || update == "") {
			url = "/managePage/bbsView";
			bdto.setBbscount(bdto.getBbscount() + 1);
			board.updateBBSCount(bdto);
		} else {
			url = "/managePage/bbsUpdate";
		}

		if (bdto.getBbsimg() == "" || bdto.getBbsimg() == null) {
		} else {
			file = bdto.getBbsimg();
		}

		// String content = bdto.getBbscontent();
		// String title = bdto.getBbstitle();
		request.setAttribute("file", file);
		request.setAttribute("vec", vec);

		return url;
	}

	@GetMapping("/bbsWrite")
	public String bbsWrite() {

		return "managePage/bbsWrite";
	}

	@PostMapping("/bbsList.do")
	public String bbsListDo(HttpServletRequest request) {

		Vector<BbsDTO> vec = new Vector<BbsDTO>();
		Vector<BbsDTO> vec1 = new Vector<BbsDTO>();
		BbsDTO bdto;
		String page = request.getParameter("page");
		String size = request.getParameter("size");

		if (page == null || page == "") {
			page = "1";
		}
		if (size == null || size == "") {
			size = "10";
		}
		int pageNum = Integer.parseInt(page);
		int sizeNum = Integer.parseInt(size);
		String[] arr = { "", "", "" };

		switch (sizeNum) {
		case 10:
			arr[0] = "selected";
			break;
		case 15:
			arr[1] = "selected";
			break;
		case 20:
			arr[2] = "selected";
			break;
		}

		/*
		 * 1 2 3 4
		 * 
		 * 1 11 21 31
		 * 
		 * 10 20 30 40
		 */
		vec = board.getBBSList();

		int all = vec.size();
		if(vec.size() != 0) {
		int count = 0;
		if (all % sizeNum != 0) {
			count = 1;
		}
		all = all / sizeNum;
		if (count == 1) {
			all = all + 1;
		}
		int endNum = pageNum * sizeNum;
		if (endNum > vec.size()) {
			endNum = vec.size();
		}
		int startNum = endNum - sizeNum + 1;

		for (int i = startNum; i <= endNum; i++) {
			bdto = vec.get(i - 1);
			vec1.add(bdto);
		}

		int start=0;
        if(pageNum % 10 == 0) {start = pageNum - 9;}
        else { start = ((pageNum / 10) * 10) + 1;}
        int end = start + 9 ;
        if(end > all) {end = all;}

		request.setAttribute("page", page);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("all", all);
		request.setAttribute("vec", vec1);
		request.setAttribute("arr", arr);
		request.setAttribute("check", 0);
		}else {
			request.setAttribute("page", page);
			request.setAttribute("start", 0);
			request.setAttribute("end", 0);
			request.setAttribute("all", all);
			request.setAttribute("vec", vec1);
			request.setAttribute("arr", arr);
			request.setAttribute("check", 1);
			
		}
		
		return "managePage/bbsList";
	}

	@PostMapping("/memberFind.do")
	public String memberFindDo(HttpServletRequest request) {

		String type = request.getParameter("type");
		String key = request.getParameter("key");
		String[] arr = { "", "", "" };

		Vector<UserDTO> vec = new Vector<UserDTO>();

		if (type.equals("userid")) {
			arr[0] = "selected";
		}
		if (type.equals("name")) {
			arr[1] = "selected";
		}
		if (type.equals("phone")) {
			arr[2] = "selected";
		}

		vec = user.likeFind(type, key);

		request.setAttribute("vec", vec);
		request.setAttribute("arr", arr);

		return "managePage/memberSearch";
	}

	@PostMapping("/memberDelete.do")
	public String memberDeleteDo(HttpServletRequest request) {
		String userid = request.getParameter("delete");
		String message;
		message = user.deleteMember(userid);

		System.out.print(message);

		request.setAttribute("message", message);

		return "forward:/memberSearch.do";
	}

	// 회원정보 수정
	@PostMapping("memberUpdate.do")
	public String memberUpdateDo(HttpServletRequest request) {
		String message;
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String birth = request.getParameter("birth");
		if (birth == "") {
			birth = null;
		}
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String addr1 = request.getParameter("addr1");
		String roadaddr = request.getParameter("roadAddr");
		String addr3 = request.getParameter("addr3");
		String userid = request.getParameter("userid");

		String addr = "(" + addr1 + ") " + roadaddr + ", " + addr3;

		// email email + @ + emailSite
		email = null;
		if (request.getParameter("email") != "" && request.getParameter("eMailSite") != "") {
			email = request.getParameter("email") + "@" + request.getParameter("eMailSite");
		}

		UserDTO udto = new UserDTO();
		udto.setName(name);
		udto.setPwd(pwd);
		udto.setBirth(birth);
		udto.setEmail(email);
		udto.setPhone(phone);
		udto.setAddr(addr);
		udto.setUserid(userid);

		message = user.updateMember(udto);
		System.out.print(message);

		request.setAttribute("message", message);

		return "forward:/memberSearch.do";
	}

	@PostMapping("memberOnepick.do")
	public String memberOnepickDo(HttpServletRequest request) {

		String userid = request.getParameter("update");
		String[] arr = { "", "", "", "", "", "" };
		UserDTO userDTO = new UserDTO();

		try {
			userDTO = user.findUser(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String addr = userDTO.getAddr();
		Date birth = userDTO.getBirth();
		String email = userDTO.getEmail();

		arr = user.seperateData(addr, birth, email);

		request.setAttribute("arr", arr);
		request.setAttribute("bean", userDTO);

		return "managePage/memberUpdate";
	}

	// 전체 회원정보 출력
	@PostMapping("memberSearch.do")
	public String memberSearchDo(HttpServletRequest request) {

		String[] arr = { "", "", "" };
		String message = (String) request.getAttribute("message");
		String test = request.getParameter("test");
		if (test == null || test == "") {

		} else {
			message = "test";
		}

		// 회원정보 받아오기
		Vector<UserDTO> vec = user.allSelect();

		request.setAttribute("vec", vec);
		request.setAttribute("arr", arr);
		request.setAttribute("message", message);

		return "managePage/memberSearch";
	}

}
