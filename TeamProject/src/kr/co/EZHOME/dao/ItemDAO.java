package kr.co.EZHOME.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.springframework.stereotype.Repository;

import kr.co.EZHOME.database.ItemMapper;
import kr.co.EZHOME.domain.DataStatus;
import kr.co.EZHOME.dto.ItemDTO;
import kr.co.EZHOME.dto.PostscriptDTO;

@Repository
public class ItemDAO {

	private final ItemMapper itemMapper;

	public ItemDAO(ItemMapper itemMapper) {
		this.itemMapper = itemMapper;
	}

	// 후기 좋아요 개수 추가
	public void addPostLike(int post_num) {
		itemMapper.addPostLike(post_num);
	}

	// 좋아요한 아이디 저장
	public void registUser(int post_num, String userid) {
		itemMapper.registUser(post_num, userid);
	}

	// 해당 유저로 좋아요한 이력이 있는지 확인
	public DataStatus userLikeCheck(int post_num, String userid) {

		DataStatus result;
		int selectResult = itemMapper.userLikeCheck(post_num, userid);

		if (selectResult > 0) {
			result = DataStatus.Exist;
		} else {
			result = DataStatus.Not_Exist;
		}

		return result;
	}

	// 후기 삭제
	public void deletePostscript(int post_num) {
		itemMapper.deletePostscript(post_num);
	}

	// 후기 작성 (insert)
	public void insertPostscript(PostscriptDTO postscriptDTO) {
		itemMapper.insertPostscript(postscriptDTO);
	}

	// 해당 post_num의 조회수 증가
	public void updateHits(int post_num) {

		itemMapper.updateHits(post_num);
	}

	// post_num 로 후기 DB 정보 가져오기
	public PostscriptDTO selectPostByPost_num(int post_num) {

		return itemMapper.selectPostByPost_num(post_num);
	}

	// 모든 후기글 가져오기
	public List<PostscriptDTO> selectAllPostscript(int startRow, int endRow, int item_num, String order) {

		String variableSqlWord = "invalid order value";
		// 최근 등록순
		if (order.equals("1")) {
			variableSqlWord = "post_num";
		}
		// 도움 많은순
		else if (order.equals("2")) {
			variableSqlWord = "post_help";
		} else if (order.equals("3")) {
			variableSqlWord = "post_hits";
		}

		return itemMapper.selectAllPostscript(startRow, endRow, item_num, variableSqlWord);
	}

	// 해당 아이템의 후기 게시글 개수 가져오기
	public int countPostscrpit(int item_num) {
		return itemMapper.countPostscript(item_num);
	}

	// 모든 상품 삭제
	public void deleteAllItems() {
		itemMapper.deleteItemTable();
		itemMapper.dropSequence();
		itemMapper.createSequence();
	}

	// 상품 수정
	public void updateItem(ItemDTO itemDTO) {
		itemMapper.updateItem(itemDTO);
	}

	// 상품 삭제
	public void deleteItem(int item_num) {
		itemMapper.deleteItem(item_num);
	}

	// 상품 정보 DB저장
	public void insertItem(ItemDTO itemDTO) {
		itemMapper.insertItem(itemDTO);
	}

	// 존재하는 모든 아이템 읽어오기
	public List<ItemDTO> selectAllItems(int startRow, int endRow) {
		return itemMapper.selectAllItems(startRow, endRow);
	}

	// 상품 개수 모두 읽어오기
	public int getAllCount() {
		int totalPageNum = itemMapper.getAllCount();

		return totalPageNum;
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
