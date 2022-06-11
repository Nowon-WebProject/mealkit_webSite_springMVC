package kr.co.EZHOME.domain;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.Vector;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.EZHOME.dao.ItemDAO;
import kr.co.EZHOME.dto.ItemDTO;
import kr.co.EZHOME.dto.PageDTO;
import kr.co.EZHOME.dto.PostscriptDTO;

@Service
public class Item {

	private final ItemDAO itemDAO;

	public Item(ItemDAO itemDAO) {
		this.itemDAO = itemDAO;
	}
	
	//기록해놨던 userid 삭제
	public void deleteUserToItemPost(int item_num, String userid) {
		itemDAO.deleteUserToItemPost(item_num, userid);
	}
	
	//ItemPostUser Table에 해당 유저기록
	public void registUserToItemPost(int item_num, String userid) {
		itemDAO.registUserToItemPost(item_num, userid);
	}
	
	// 해당 아이디로 해당아이템 후기작성을 한적이 있는지 채크
	public DataStatus userPostCheck(int item_num, String userid) {
		
		return itemDAO.userPostCheck(item_num, userid);

	}
	
	// 갱신된 별점 itemDB 에 갱신하기
	public void updateStar(double averageStar, int item_num) {
		itemDAO.updateStar(averageStar, item_num);
	}

	public double minusAverageStar(int post_num, int item_num) {

		double newAverageStar; // 최신화 되는 평균 별점
		int allPostscriptNumber = itemDAO.countPostscrpit(item_num); // 총 후기 개수
		double beforeAverageStar = itemDAO.selectItem(item_num).get(0).getItem_starsAvg(); // 이전 별 평균값
		if (allPostscriptNumber  == 1) { //후기가 하나밖에없을때는 0으로 나눠지기 때문에 바로 리턴을 해준다
			return beforeAverageStar;
		}
		double minusStar = itemDAO.selectPostByPost_num(post_num).getPost_stars(); //삭제되는 별점
		// 총 별점 = 이전 별 평균값 * 총 후기 개수
		double totalStar = beforeAverageStar * allPostscriptNumber;

		// 최신화되는 평균값 = (총 별점 + 현재 후기 별점) / (후기 개수 + 1)
		newAverageStar = (totalStar - minusStar) / (allPostscriptNumber - 1);

		return newAverageStar;
	}

	// 별점 평균 내기
	public double addAverageStar(PostscriptDTO postscriptDTO, int item_num) {

		double newAverageStar; // 최신화 되는 평균 별점
		int allPostscriptNumber = itemDAO.countPostscrpit(item_num); // 총 후기 개수
		double addStar = postscriptDTO.getPost_stars(); // 이번에 추가되는 별점
		// 첫평가일 경우
		if (allPostscriptNumber == 0) {
			return addStar;
		}
		double beforeAverageStar = itemDAO.selectItem(item_num).get(0).getItem_starsAvg(); // 이전 별 평균값
		// 총 별점 = 이전 별 평균값 * 총 후기 개수
		double totalStar = beforeAverageStar * allPostscriptNumber;

		// 최신화되는 평균값 = (총 별점 + 현재 후기 별점) / (후기 개수 + 1)
		newAverageStar = (totalStar + addStar) / (allPostscriptNumber + 1);

		return newAverageStar;
	}

	// 후기 삭제
	public void deletePostscript(int post_num) {
		itemDAO.deletePostscript(post_num);
	}

	// 후기 작성 (insert)
	public void insertPostscript(PostscriptDTO postscriptDTO, MultipartFile file, String saveDirectory) {

		String saveName;

		// 파일 이름 변경
		if (!file.isEmpty()) {
			UUID uuid = UUID.randomUUID();
			saveName = uuid + "_" + file.getOriginalFilename(); // 서버상의 파일이름이 겹치는것을 방지
			saveName = saveName.substring(30);
		} else {
			saveName = null;
		}
		

		try {
			file.transferTo(new File(saveDirectory, saveName));
		} catch (Exception e) {
			e.printStackTrace();
		}

		postscriptDTO.setPost_image(saveName);
		postscriptDTO.setPost_help(0);
		postscriptDTO.setPost_hits(0);

		itemDAO.insertPostscript(postscriptDTO);
	}

	// 해당 post_num의 조회수 증가
	public void updateHits(int post_num) {

		itemDAO.updateHits(post_num);
	}

	// post_num 로 후기 DB 정보 가져오기
	public PostscriptDTO selectPostByPost_num(int post_num) {

		return itemDAO.selectPostByPost_num(post_num);
	}

	// 해당 상품 번호의 모든 후기글 가져오기
	public List<PostscriptDTO> selectAllPostscript(PageDTO pageDTO, int item_num, String order) {

		int startRow = pageDTO.getStartRow();
		int endRow = pageDTO.getEndRow();

		return itemDAO.selectAllPostscript(startRow, endRow, item_num, order);

	}

	// 후기 페이징 작업
	public void postscriptPaging(PageDTO pageDTO, int item_num) {

		int pageSize = pageDTO.getPageSize(); // 화면에 보여질 총 게시글 개수
		int totalPageNum = 0; // 전체 글 개수
		int pageCount = 0; // 페이지 숫자 세기
		int startRow; // 클릭하여 이동할 수 있는 버튼의 시작번호
		int endRow; // 클릭하여 이동할 수 있는 버튼의 끝번호
		int startPage = 1; // 시작 페이지
		int endPage; // 끝 페이지
		int pageBlock = 10; // 한번에 보여주는 총 컨텐츠 개수
		int pageNum = pageDTO.getPageNum(); // 이동한 페이지

		// step1. 초기값 설정

		if (pageDTO.getPageSize() == 0) {
			// 처음일경우 초기값
			pageSize = 7;
		}

		// 처음엔 1페이지
		if (pageNum == 0) {
			pageNum = 1;
		}

		// 출력한 총 상품 개수 가져오기
		totalPageNum = itemDAO.countPostscrpit(item_num);

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

		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setStartRow(startRow);
		pageDTO.setEndRow(endRow);
		pageDTO.setPageCount(pageCount);
		pageDTO.setPageSize(pageSize);
	}

	// 후기 좋아요 개수 추가
	public void addPostLike(int post_num) {
		itemDAO.addPostLike(post_num);
	}

	// 좋아요한 아이디 저장
	public void registUser(int post_num, String userid) {
		itemDAO.registUser(post_num, userid);
	}

	// 해당 유저로 좋아요한 이력이 있는지 확인
	public DataStatus userLikeCheck(int post_num, String userid) {

		return itemDAO.userLikeCheck(post_num, userid);
	}

	// 모든 상품 삭제
	public void deleteAllItems() {
		itemDAO.deleteAllItems();
	}

	// 상품 수정
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
