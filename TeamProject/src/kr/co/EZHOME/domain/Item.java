package kr.co.EZHOME.domain;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.springframework.stereotype.Service;

import kr.co.EZHOME.beans.PageDTO;
import kr.co.EZHOME.dao.ItemDAO;
import kr.co.EZHOME.dto.ItemDTO;

@Service
public class Item {

	private final ItemDAO itemDAO;

	public Item(ItemDAO itemDAO) {
		this.itemDAO = itemDAO;
	}

	//모든 상품 삭제
	public void deleteAllItems() {
		itemDAO.deleteAllItems();
	}
	
	//상품 수정
	public void updateItem(ItemDTO itemDTO) {
		itemDAO.updateItem(itemDTO);
	}
	
	// 상품 삭제
	public void deleteItem(int item_num) {
		itemDAO.deleteItem(item_num);
	}
	
	// 상품 정보 DB저장
	public void insertItem(ItemDTO itemDTO) {
		itemDAO.insertItem(itemDTO);
	}

	// 존재하는 모든 아이템 읽어오기
	public List<ItemDTO> selectAllItems(int startRow, int endRow) {
		return itemDAO.selectAllItems(startRow, endRow);
	}

	// 아이템 관리자 페이지 출력시 필요한 페이지 계산
	public void calculatingPageNumber(PageDTO pageBean) {

		int pageSize = pageBean.getPageSize(); // 화면에 보여질 총 게시글 개수
		int totalPageNum = 0; // 전체 글 개수
		int pageCount = 0; // 페이지 숫자 세기
		int startRow; // 클릭하여 이동할 수 있는 버튼의 시작번호
		int endRow; // 클릭하여 이동할 수 있는 버튼의 끝번호
		int startPage = 1; // 시작 페이지
		int endPage; // 끝 페이지
		int pageBlock = 10; // 한번에 보여주는 총 컨텐츠 개수
		int pageNum = pageBean.getPageNum(); // 이동한 페이지

		// step1. 초기값 설정

		if (pageBean.getPageSize() == 0) {
			// 처음일경우 초기값
			pageSize = 10;
		}

		// 처음엔 1페이지
		if (pageNum == 0) {
			pageNum = 1;
		}

		// 출력한 총 상품 개수 가져오기
		totalPageNum = itemDAO.getAllCount();

		// 지금 페이지에 보여질 시작 번호와 끝 번호
		// ex.
		// p1 p2 p3 p4
		// 1 11 21 31 ...
		// 10 20 30 40 ...
		startRow = (pageNum - 1) * pageSize + 1;
		endRow = (pageNum * pageSize);

		// 전체 페이지 개수 구하기
		// totalPageNum: 전체 글 개수, pageSize: 화면에 보여질 총 게시글 개수
		pageCount = totalPageNum / pageSize + (totalPageNum % pageSize == 0 ? 0 : 1);

		// 시작 페이지 구하기
		// currentPage: 현재 페이지
		if (pageNum % 10 != 0) {
			startPage = (pageNum / 10) * 10 + 1;
		} else {
			startPage = (pageNum / 10 - 1) * 10 + 1;
		}

		// 끝 페이지 구하기
		endPage = startPage + pageBlock - 1;

		if (endPage > pageCount) {
			endPage = pageCount;
		}

		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setStartRow(startRow);
		pageBean.setEndRow(endRow);
		pageBean.setPageCount(pageCount);
		pageBean.setPageSize(pageSize);
	}

	// 아이템 판매량, 재고 업데이트
	public void updateSalesAndQuantity(int itemCnt, int itemNum) {
		itemDAO.updateSalesAndQuantity(itemCnt, itemNum);
	}

	// 카테고리 종류 가져오기
	public Vector<ItemDTO> getCategoryList() {
		Vector<ItemDTO> vec = itemDAO.getCategoryList();

		return vec;
	}

	// 검색된 아이템리스트의 전체 개수 (페이지 이동 만들기 위한 메서드)
	public int itemSearchCnt(String keyword, String category, String check) {
		int result = itemDAO.itemSearchCnt(keyword, category, check);

		return result;
	}

	// 카테고리, 정렬별 아이템 리스트 가져오기
	public Vector<ItemDTO> getItemList(String keyword, String category, String check, String priceSort, int startRow,
			int endRow) {
		Vector<ItemDTO> itemDTO = itemDAO.getItemList(keyword, category, check, priceSort, startRow, endRow);

		return itemDTO;
	}

	public int[] pageCount(int count, int pageSize, int currentPage) {

		// 전체 페이지 개수 구하기
		// count: 전체 글 개수, pageSize: 화면에 보여질 총 게시글 개수
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
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
		if (endPage > pageCount)
			endPage = pageCount;
		int result[] = { startPage, endPage, pageCount };

		return result;
	}

	public ArrayList<ItemDTO> selectItem(int item_num) {

		ArrayList<ItemDTO> itemList = itemDAO.selectItem(item_num);

		return itemList;
	}

	public ArrayList<ItemDTO> selectMainItem(String mainCategory) {
		ArrayList<ItemDTO> ilist = itemDAO.selectMainItem(mainCategory);

		return ilist;
	}

}
