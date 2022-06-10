package kr.co.EZHOME.controller;

import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.co.EZHOME.beans.PageDTO;
import kr.co.EZHOME.domain.Item;
import kr.co.EZHOME.dto.ItemDTO;

@Controller
public class ItemController {
	
	private final Item item;
	
	public ItemController(Item item) {
		this.item = item;
	}
	
	@GetMapping("itemList.do")
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
	
	@GetMapping("itemAbout.do")
	public String itemAboutDo(HttpServletRequest request) {
		
		int item_num = Integer.parseInt(request.getParameter("item_num"));
		
		ArrayList<ItemDTO> itemList = item.selectItem(item_num);
		request.setAttribute("ilist", itemList);
		return "item/itemAbout";
	}
}
