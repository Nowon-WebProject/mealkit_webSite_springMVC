package kr.co.EZHOME.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.co.EZHOME.domain.DataStatus;
import kr.co.EZHOME.domain.Item;
import kr.co.EZHOME.dto.ItemDTO;
import kr.co.EZHOME.dto.PageDTO;
import kr.co.EZHOME.dto.PostscriptDTO;

@Controller
public class ItemController {

	private final Item item;

	public ItemController(Item item) {
		this.item = item;
	}

	//좋아요 횟수 추가
	@GetMapping("/updatePostscriptHelp.do")
	public String updatePostscriptHelpDo(String post_num, String item_num, String userid, Model model, HttpServletRequest request) {
		
		String message;
		DataStatus result;
		//해당 유저로 좋아요한 이력이 있는지 확인
		result = item.userLikeCheck(Integer.parseInt(post_num), userid);
		
		//해당 유저가 존재한다면 좋아요 x
		if (result == DataStatus.Exist) {
			message = "이미 좋아요를 누른 게시글입니다";
		}
		//존재하지 않을때 좋아요 update
		else {
			//좋아요한 아이디 저장
			item.registUser(Integer.parseInt(post_num), userid);
			//후기 좋아요 개수 추가
			item.addPostLike(Integer.parseInt(post_num));
			message = "도움된 후기예요!";
		}
		model.addAttribute("message", message);
		
		return "item/afterPostAction";
	}
	
	@GetMapping("/postDelete")
	public String postDelete(String post_num, Model model) {
		
		item.deletePostscript(Integer.parseInt(post_num));
		model.addAttribute("message", "후기글 삭제가 완료되었습니다");
		
		return "item/afterPostAction";
	}
	
	
	//후기글 작성 요청
	@PostMapping("/postWriteDo")
	public String postWriteDo(@ModelAttribute PostscriptDTO postscriptDTO, MultipartFile file, HttpServletRequest request, Model model) {
		
		String saveDirectory = request.getServletContext().getRealPath("resources/images/postscript");
		
		item.insertPostscript(postscriptDTO, file, saveDirectory);
		model.addAttribute("message", "후기글 작성이 완료되었습니다");
		return "item/afterPostAction";
	}

	@GetMapping("/postScriptContent")
	public String postScriptContent(int post_num, Model model) {

		PostscriptDTO postscriptDTO = item.selectPostByPost_num(post_num);

		// 해당 post_num의 조회수 증가
		item.updateHits(post_num);

		model.addAttribute("postscript", postscriptDTO);
		return "item/postScriptContent";
	}

	@GetMapping("/itemList.do")
	public String itemListDo(HttpServletRequest request) {
		// 상품 리스트 출력 서블릿
		// itemList.jsp에도 자바코드가 많이 사용되고 있음..
		// 카테고리 설정, 키워드 검색, ~개씩 보기, 가격순 정렬, 리스트(카드)형 보기 등 조건을 선택할 때 마다
		// 해당 조건에 맞는 리스트만 ilist에 담아 넘김.
		// 화면에 보여질 게시글의 개수를 지정

		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		String check = request.getParameter("check"); // 전체, 인기, 신상
		String category = request.getParameter("category"); // 검색 카테고리 (한식, 중식, 양식)
		String priceSort = request.getParameter("priceSort"); // 가격정렬
		String view = request.getParameter("view"); // 카드형(디폴트), 리스트형
		String pageNum = request.getParameter("pageNum"); // 현재 페이지 위치
		String keyword = request.getParameter("keyword"); // 검색어
		Vector<ItemDTO> vec;

		// pageNum 이 없을 경우 1페이지로 초기화
		if (pageNum == null) {
			pageNum = "1";
		}

		int count = 0; // 전체 글의 개수 저장
		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 정수형

		// 현재 페이지에 보여 줄 시작 번호를 설정 ==> 데이터 베이스에서 불러올 시작 번호
		int startRow = (currentPage - 1) * pageSize + 1; // 1 11 21 31
		int endRow = currentPage * pageSize; // 10 20 30 40

		vec = item.getItemList(keyword, category, check, priceSort, startRow, endRow);
		count = item.itemSearchCnt(keyword, category, check);

		int countResult[] = item.pageCount(count, pageSize, currentPage);
		int startpage = countResult[0];
		int endPage = countResult[1];
		int pageCount = countResult[2];

		request.setAttribute("ilist", vec);
		request.setAttribute("check", check);
		request.setAttribute("startPage", startpage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("endPage", endPage);
		request.setAttribute("count", count);
		request.setAttribute("view", view);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("currentPage", currentPage);

		Vector<ItemDTO> categoryList = item.getCategoryList();
		request.setAttribute("categoryList", categoryList);

		return "item/itemList";
	}

	@GetMapping("/itemAbout.do")
	public String itemAboutDo(HttpServletRequest request, @ModelAttribute PageDTO pageDTO, Model model) {
		
		int item_num = Integer.parseInt(request.getParameter("item_num"));
		String order = request.getParameter("order");
		String viewNumber = request.getParameter("viewNumber");

		if (order == null) {
			order = "1";
		}

		// 후기에서 넘어왔을 경우 바로 후기위치로focus하기 위해 about 페이지의 현재 위치 구분해준다
		if (viewNumber == null) {
			model.addAttribute("viewNumber", "0");
		} else {
			model.addAttribute("viewNumber", viewNumber);
		}

		ArrayList<ItemDTO> itemList = item.selectItem(item_num);
		item.postscriptPaging(pageDTO, item_num);
		List<PostscriptDTO> postscripts = item.selectAllPostscript(pageDTO, item_num, order);

		model.addAttribute("ilist", itemList);
		model.addAttribute("page", pageDTO);
		model.addAttribute("postscripts", postscripts);
		model.addAttribute("order", order);
		return "item/itemAbout";
	}
}
