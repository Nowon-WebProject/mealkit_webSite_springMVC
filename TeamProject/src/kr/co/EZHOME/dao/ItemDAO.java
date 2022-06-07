package kr.co.EZHOME.dao;

import java.util.ArrayList;
import java.util.Vector;

import org.springframework.stereotype.Repository;

import kr.co.EZHOME.database.ItemMapper;
import kr.co.EZHOME.dto.ItemDTO;

@Repository
public class ItemDAO {

	private final ItemMapper itemMapper;

	public ItemDAO(ItemMapper itemMapper) {
		this.itemMapper = itemMapper;
	}

	// 아이템 판매량, 재고 업데이트
	public void updateSalesAndQuantity(int itemCnt, int itemNum) {
		itemMapper.updateSalesAndQuantity(itemCnt, itemNum);
	}

	// 카테고리 종류 가져오기
	public Vector<ItemDTO> getCategoryList() {
		Vector<ItemDTO> vec = itemMapper.getCategoryList();

		return vec;
	}

	// 검색된 아이템리스트의 전체 개수 (페이지 이동 만들기 위한 메서드)
	public int itemSearchCnt(String keyword, String category, String check) {
		String itemSalesSql = "";

		keyword = "%" + keyword + "%";
		category = "%" + category + "%";
		if (check.equals("best")) {
			itemSalesSql = "item_sales>0 and ";
		}
		int result = itemMapper.itemSearchCnt(itemSalesSql, keyword, category);

		return result;
	}

	// 카테고리별 item list 가져오기
	public Vector<ItemDTO> getItemList(String keyword, String category, String check, String priceSort, int startRow,
			int endRow) {
		String sortPriceSql;
		String sortDateSql;
		String sortSalesSql = "";

		keyword = "%" + keyword + "%";
		category = "%" + category + "%";
		if (priceSort.equals("high")) {
			sortPriceSql = "item_price desc, ";
		} else if (priceSort.equals("low")) {
			sortPriceSql = "item_price asc, ";
		} else {
			sortPriceSql = "";
		}

		if (check.equals("all")) {
			sortDateSql = "item_date asc";
		} else if (check.equals("new")) {
			sortDateSql = "item_date desc";
		}
		// check = best
		else {
			sortDateSql = "item_sales desc";
			sortSalesSql = "and item_sales>0 ";
		}

		Vector<ItemDTO> itemDTO = itemMapper.getItemList(keyword, category, sortSalesSql, sortPriceSql, sortDateSql,
				startRow, endRow);

		return itemDTO;
	}

	public ArrayList<ItemDTO> selectItem(int item_num) {

		ArrayList<ItemDTO> itemList = itemMapper.selectItem(item_num);

		return itemList;
	}

	public ArrayList<ItemDTO> selectMainItem(String mainCategory) {
		mainCategory = "%" + mainCategory + "%";
		ArrayList<ItemDTO> ilist = itemMapper.selectMainItem(mainCategory);

		return ilist;
	}

}
