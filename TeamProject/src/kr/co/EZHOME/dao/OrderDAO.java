package kr.co.EZHOME.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import kr.co.EZHOME.database.OrderMapper;
import kr.co.EZHOME.domain.DataStatus;
import kr.co.EZHOME.dto.MyAddrDTO;
import kr.co.EZHOME.dto.OrderDTO;
import kr.co.EZHOME.dto.RecentAddrDTO;

@Repository
public class OrderDAO {

	private final OrderMapper orderMapper;

	public OrderDAO(OrderMapper orderMapper) {
		this.orderMapper = orderMapper;
	}
	public void updateReject(String reject, String order_num, int item_num) {
		orderMapper.updateReject(reject, order_num, item_num);
		
	}
	
	public ArrayList<OrderDTO> getRefundRequestList(String category, String keyword, int startRow, int endRow){
		keyword = "%"+keyword+"%";
		ArrayList<OrderDTO> refundRequestList = orderMapper.getRefundRequestList(category, keyword, startRow, endRow); 
		return refundRequestList;
	}
	
	public int getRefundRequestCnt(String category, String keyword) {
		keyword = "%"+keyword+"%";
		int refundRequestCnt = orderMapper.getRefundRequestCnt(category, keyword);
		
		return refundRequestCnt;
	}
	
	public void modifyRefundRequest(String order_num, String refund_request,  int item_num) {
		
		orderMapper.modifyRefundRequest(order_num, refund_request, item_num);
		
	}
	
	public void modifyRefundStatus(String order_num, String refund_status, int item_num) {
		orderMapper.modifyRefundStatus(order_num, refund_status, item_num);
		
	}
	
	public void updateDeli_Status(String deli_status, String order_num) {
		orderMapper.updateDeli_status(deli_status, order_num);
		
	}
	
	public ArrayList<OrderDTO> getAllOrderList(String category, String keyword, int startRow, int endRow){
		keyword = "%"+keyword+"%";
		ArrayList<OrderDTO> orderList = orderMapper.getAllOrderList(category, keyword, startRow, endRow);
		return orderList;
	}
	
	
	public int getOrderManageCnt(String category, String keyword) {
		keyword = "%"+keyword+"%";
		int result = orderMapper.getOrderManageCnt(category, keyword);
		return result;
	}
	
	public ArrayList<OrderDTO> getOrderInfo(String order_num){
		ArrayList<OrderDTO> orderInfoList = orderMapper.getOrderInfo(order_num);
		
		return orderInfoList;
	}
	
	public ArrayList<OrderDTO> getOrderList(String userid, int startRow, int endRow){
		ArrayList<OrderDTO> orderList = orderMapper.getOrderList(userid, startRow, endRow);
		
		return orderList;
	}
	
	public int getOrderCnt(String userid) {
		int result = orderMapper.getOrderCnt(userid);
		return result;
	}
	
	
	
	
	//////////////////////////////
	
	// ?????? addr_seq ??????
	public void deleteRecentAddr(int deli_addr_seq) {
		orderMapper.deleteRecentAddr(deli_addr_seq);
	}

	// ?????? ????????? DB??? ????????????
	public void insertRecentAddr(RecentAddrDTO recentAddrDTO) {
		orderMapper.insertRecentAddr(recentAddrDTO);
	}

	// ?????? userid??? ?????? ????????? ?????? ????????? seq ??????
	public int oldRecntAddrFind(String userid) {
		int oldAddrSeq = orderMapper.oldRecntAddrFind(userid);

		return oldAddrSeq;
	}

	// ?????? ????????? ?????? ???????????? ????????? ??????
	public DataStatus recentAddrCheck(String deli_postcode, String deli_name, String userid) {
		deli_postcode = "%" + deli_postcode + "%";
		deli_name = "%" + deli_name + "%";
		int checkedResult = orderMapper.recentAddrCheck(deli_postcode, deli_name, userid);
		DataStatus result;

		if (checkedResult > 0) {
			result = DataStatus.Exist;
		} else {
			result = DataStatus.Not_Exist;
		}

		return result;
	}

	// ?????? ?????? DB??????
	public void insertOrder(OrderDTO orderDTO) {
		orderMapper.insertOrder(orderDTO);
	}

	// ?????? ???????????? ?????? DTO??? ??????
	public void updateMyAddr(MyAddrDTO myAddrDTO) {
		orderMapper.updateMyAddr(myAddrDTO);
	}

	// ?????? addr_seq ??????
	public void deleteMyAddr(int my_deli_addr_seq) {
		orderMapper.deleteMyAddr(my_deli_addr_seq);
	}

	// ?????? ????????? ?????? ????????????
	public ArrayList<MyAddrDTO> getMyAddrList(String userid) {
		ArrayList<MyAddrDTO> myAddrDTO = orderMapper.getMyAddrList(userid);

		return myAddrDTO;
	}

	// ?????? ????????? ????????????
	public void insertMyAddr(MyAddrDTO myAddrDTO) {
		orderMapper.insertMyAddr(myAddrDTO);
	}

	// userid??? ???????????? ?????? ????????? ?????? ??????
	public int myAddrCnt(String userid) {
		int count = orderMapper.myAddrCnt(userid);

		return count;
	}

	// ?????? ????????? ?????? ???????????? ????????? ??????
	public DataStatus myAddrCheck(String deli_postcode, String deli_name, String userid) {
		int checkedResult = orderMapper.myAddrCheck(deli_postcode, deli_name, userid);
		DataStatus result;

		if (checkedResult > 0) {
			result = DataStatus.Exist;
		} else {
			result = DataStatus.Not_Exist;
		}

		return result;
	}

	// ?????? ????????? ????????? ????????????
	public ArrayList<MyAddrDTO> getMyAddr(String userid) {
		ArrayList<MyAddrDTO> myAddrList = orderMapper.getMyAddr(userid);

		return myAddrList;
	}

	// ?????? ????????? ????????? ????????????
	public ArrayList<RecentAddrDTO> getRecentAddr(String userid) {
		ArrayList<RecentAddrDTO> recentAddrList = orderMapper.getRecentAddr(userid);

		return recentAddrList;
	}
}
