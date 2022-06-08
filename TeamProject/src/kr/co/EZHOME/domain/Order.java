package kr.co.EZHOME.domain;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import kr.co.EZHOME.dao.OrderDAO;
import kr.co.EZHOME.dto.MyAddrDTO;
import kr.co.EZHOME.dto.OrderDTO;
import kr.co.EZHOME.dto.RecentAddrDTO;

@Service
public class Order {

	private final OrderDAO orderDAO;

	public Order(OrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}
	
	
	public void updateReject(String reject, String order_num, int item_num) {
		orderDAO.updateReject(reject, order_num, item_num);
		
	}
	
	public ArrayList<OrderDTO> getRefundRequestList(String category, String keyword, int startRow, int endRow){
		ArrayList<OrderDTO> refundRequestList = orderDAO.getRefundRequestList(category, keyword, startRow, endRow);
		
		return refundRequestList;
	}
	
	
	
	public int getRefundRequestCnt(String category, String keyword) {
		int refundRequestCnt = orderDAO.getRefundRequestCnt(category, keyword);
		
		return refundRequestCnt;
	}

	public void modifyRefundRequest(String order_num, String refund_request, int item_num) {
		orderDAO.modifyRefundRequest(order_num, refund_request, item_num);
		
	}
	
	public void modifyRefundStatus(String order_num, String refund_status, int item_num) {
		orderDAO.modifyRefundStatus(order_num, refund_status, item_num);
	
	}

	public void updateDeli_Status(String deli_status, String order_num) {
		orderDAO.updateDeli_Status(deli_status, order_num);

	}

	public ArrayList<OrderDTO> getAllOrderList(String category, String keyword, int startRow, int endRow) {
		ArrayList<OrderDTO> orderList = orderDAO.getAllOrderList(category, keyword, startRow, endRow);

		return orderList;
	}

	public int getOrderManageCnt(String category, String keyword) {
		int result = orderDAO.getOrderManageCnt(category, keyword);

		return result;
	}

	public ArrayList<OrderDTO> getOrderInfo(String order_num) {
		ArrayList<OrderDTO> orderInfoList = orderDAO.getOrderInfo(order_num);

		return orderInfoList;
	}

	public ArrayList<OrderDTO> getOrderList(String userid, int startRow, int endRow) {
		ArrayList<OrderDTO> orderList = orderDAO.getOrderList(userid, startRow, endRow);

		return orderList;
	}

	public int getOrderCnt(String userid) {
		int result = orderDAO.getOrderCnt(userid);

		return result;
	}

	
	
	
	/////////////////////////

	// 해당 addr_seq 삭제
	public void deleteRecentAddr(int deli_addr_seq) {
		orderDAO.deleteRecentAddr(deli_addr_seq);
	}

	// 최근 배송지 DB에 추가하기
	public void insertRecentAddr(RecentAddrDTO recentAddrDTO) {
		orderDAO.insertRecentAddr(recentAddrDTO);
	}

	// 해당 userid의 가장 오래된 최근 배송지 seq 찾기
	public int oldRecntAddrFind(String userid) {
		int oldAddrSeq = orderDAO.oldRecntAddrFind(userid);

		return oldAddrSeq;
	}

	// 해당 정보의 나의 최근 배송지가 있는지 확인
	public DataStatus recentAddrCheck(String deli_postcode, String deli_name, String userid) {
		DataStatus result = orderDAO.recentAddrCheck(deli_postcode, deli_name, userid);

		return result;
	}

	// 주문 내역 DB저장
	public void insertOrder(OrderDTO orderDTO) {
		orderDAO.insertOrder(orderDTO);
	}

	// 나의 배송지를 해당 DTO로 수정
	public void updateMyAddr(MyAddrDTO myAddrDTO) {
		orderDAO.updateMyAddr(myAddrDTO);
	}

	// 해당 addr_seq 삭제
	public void deleteMyAddr(int my_deli_addr_seq) {
		orderDAO.deleteMyAddr(my_deli_addr_seq);
	}

	// 나의 배송지 등록하기
	public void insertNewMyAddr(MyAddrDTO myAddrDTO, String deli_postcode) {
		String userid = myAddrDTO.getUserid();
		String deli_name = myAddrDTO.getMy_deli_name();

		DataStatus myAddrCheckResult = orderDAO.myAddrCheck(deli_postcode, deli_name, userid);
		if (myAddrCheckResult == DataStatus.Not_Exist) {
			int myAddrCnt = orderDAO.myAddrCnt(userid);
			if (myAddrCnt > 4) {
				System.out.println("나의 배송지가 5개가 초과되었습니다.");
			} else {
				orderDAO.insertMyAddr(myAddrDTO);
			}
		}
		// 중복된 주소가 저장되어 있는 경우
		else {
			System.out.println("이미 저장된 주소이므로 저장되지 않습니다.");
		}
	}

	// 나의 배송지 목록 가져오기
	public ArrayList<MyAddrDTO> getMyAddrList(String userid) {
		ArrayList<MyAddrDTO> myAddrDTO = orderDAO.getMyAddrList(userid);

		return myAddrDTO;
	}

	// 나의 배송지 추가하기
	public void insertMyAddr(MyAddrDTO myAddrDTO) {
		orderDAO.insertMyAddr(myAddrDTO);
	}

	// userid에 존재하는 나의 배송지 개수 확인
	public int myAddrCnt(String userid) {
		int count = orderDAO.myAddrCnt(userid);

		return count;
	}

	// 해당 정보의 나의 배송지가 있는지 확인
	public DataStatus myAddrCheck(String deli_postcode, String deli_name, String userid) {
		DataStatus result = orderDAO.myAddrCheck(deli_postcode, deli_name, userid);

		return result;
	}

	// 나의 배송지 리스트 가져오기
	public ArrayList<MyAddrDTO> getMyAddr(String userid) {
		ArrayList<MyAddrDTO> myAddrList = orderDAO.getMyAddr(userid);

		return myAddrList;
	}

	// 최근 배송지 리스트 가져오기
	public ArrayList<RecentAddrDTO> getRecentAddr(String userid) {
		ArrayList<RecentAddrDTO> recentAddrList = orderDAO.getRecentAddr(userid);

		return recentAddrList;
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
	
}
