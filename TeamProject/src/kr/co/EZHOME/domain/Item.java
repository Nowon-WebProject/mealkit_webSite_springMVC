package kr.co.EZHOME.domain;

import java.util.ArrayList;
import java.util.Vector;

import org.springframework.stereotype.Service;

import kr.co.EZHOME.dao.ItemDAO;
import kr.co.EZHOME.dto.ItemDTO;

@Service
public class Item {
	
	private final ItemDAO itemDAO;
	
	public Item(ItemDAO itemDAO) {
		this.itemDAO = itemDAO;
	}
	
	//카테고리 종류 가져오기
	public Vector<ItemDTO> getCategoryList() {
		Vector<ItemDTO> vec = itemDAO.getCategoryList();
		
		return vec;
	}
	
	//검색된 아이템리스트의 전체 개수 (페이지 이동 만들기 위한 메서드)
	public int itemSearchCnt(String keyword, String category, String check) {
		int result = itemDAO.itemSearchCnt(keyword, category, check);
		
		return result;
	}
	
	
	// 카테고리, 정렬별 아이템 리스트 가져오기
	public Vector<ItemDTO> getItemList(String keyword, String category, String check, String priceSort, int startRow, int endRow) {
		Vector<ItemDTO> itemDTO = itemDAO.getItemList(keyword, category, check, priceSort, startRow, endRow);
		
		return itemDTO;
	}
	
	public int[] pageCount(int count, int pageSize, int currentPage) {
		
		// 전체 페이지 개수 구하기
		// count: 전체 글 개수, pageSize: 화면에 보여질 총 게시글 개수
		int pageCount = count / pageSize + (count % pageSize == 0? 0:1);
		int startPage = 1;
		int pageBlock = 10;
		
		// 시작 페이지 구하기
		// currentPage: 현재 페이지
		if (currentPage % 10 != 0) {
			startPage = (currentPage / 10) * 10 + 1;
		} else {		
			startPage = (currentPage / 10 - 1) * 10 + 1;
		}

		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount)
				endPage = pageCount;
		int result[] = {startPage, endPage, pageCount};
		
		return result;
	}
	
	public ArrayList<ItemDTO> selectItem(int item_num) {
		
		ArrayList<ItemDTO> itemList = itemDAO.selectItem(item_num);
		
		return itemList;
	}
	
	public ArrayList<ItemDTO> selectMainItem(String mainCategory) {
		ArrayList<ItemDTO>ilist = itemDAO.selectMainItem(mainCategory);
		
		return ilist;
	}
	
}
