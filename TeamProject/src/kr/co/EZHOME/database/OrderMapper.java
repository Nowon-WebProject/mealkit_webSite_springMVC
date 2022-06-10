package kr.co.EZHOME.database;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.EZHOME.dto.MyAddrDTO;
import kr.co.EZHOME.dto.OrderDTO;
import kr.co.EZHOME.dto.RecentAddrDTO;

public interface OrderMapper {
	
	

	//자신의 주문내역 출력
	@Select("select * from (select A.*, Rownum Rnum from(select * from (select ROW_NUMBER() OVER(PARTITION BY order_num ORDER BY order_num) AS RNUM2, ordertbl.* FROM ordertbl where userid=#{userid}) where rnum2=1 order by order_num desc)A) where Rnum >= #{startRow} and Rnum <= #{endRow}")
	ArrayList<OrderDTO> getOrderList(@Param("userid")String userid, @Param("startRow")int startRow, @Param("endRow")int endRow);
	
	//자신의 상세주문페이지 출력
	@Select("select * from ordertbl where order_num=#{order_num}")
	ArrayList<OrderDTO> getOrderInfo(@Param("order_num")String order_num);
	
	//상세주문페이지에서 취소/환불 요청시 상태 변경
	@Update("update (select * from ordertbl where order_num=#{order_num}) set refund_status=#{refund_status} where item_num=#{item_num}")
	void modifyRefundStatus(@Param("order_num")String order_num, @Param("refund_status")String refund_status, @Param("item_num")int item_num);
	
	//배송중 이후 상태에서 취소/환불 요청 시 요청 사유 추가 
	@Update("update ordertbl set refund_request=#{refund_request} where item_num=#{item_num} and order_num=#{order_num}")
	void modifyRefundRequest(@Param("order_num")String order_num, @Param("refund_request")String refund_request, @Param("item_num")int item_num);
	
	//결제건의 배송상태 변경
	@Update("update ordertbl set deli_status=#{deli_status} where order_num=#{order_num}")
	void updateDeli_status(@Param("deli_status")String deli_status, @Param("order_num")String order_num);
	
	//취소/환불 거절 시 사유 해당 결제건의 아이템에 대해 사유 추가
	@Update("update ordertbl set refund_reject=#{reject} where order_num=#{order_num} and item_num=#{item_num}")
	void updateReject(@Param("reject")String reject, @Param("order_num")String order_num, @Param("item_num")int item_num);
	
	//자신의 주문내역 출력시 페이지 사이즈 조절을 위한 카운트 조회
	@Select("select count(*) from (select * from (select ROW_NUMBER() OVER(PARTITION BY order_num ORDER BY order_num ) AS RNUM, ordertbl.* FROM ordertbl where userid = #{userid}) where rnum=1)")
	int getOrderCnt(@Param("userid")String userid);
	
	//취소/환불 요청이 들어온 건 출력
	@Select("select * from (select A.*, Rownum Rnum from(select * from ordertbl where ${category} like #{keyword} and refund_status = '취소 요청 중..' order by order_num asc)A) where Rnum >= #{startRow} and Rnum <= #{endRow}")
	ArrayList<OrderDTO> getRefundRequestList(@Param("category")String category, @Param("keyword")String keyword, @Param("startRow")int startRow, @Param("endRow")int endRow);

	//취소/환불 요청 출력 시 페이지 사이즈 조절을 위한 카운트 조회
	@Select("select count(*) from ordertbl where ${category} like #{keyword} and refund_status = '취소 요청 중..'")
	int getRefundRequestCnt(@Param("category")String category, @Param("keyword")String keywordSql);	
	
	
	//관리자가 배송상태 변경할때, 모든 유저의 주문 내역 출력 (같은 결제번호는 하나만 출력) 
	@Select("select * from (select A.*, Rownum Rnum from(select * from (select ROW_NUMBER() OVER(PARTITION BY order_num ORDER BY order_num) AS RNUM2, ordertbl.* FROM ordertbl where ${category} like #{keyword}) where rnum2=1 order by order_num desc)A) where Rnum >= #{startRow} and Rnum <= #{endRow}")
	ArrayList<OrderDTO> getAllOrderList(@Param("category")String category, @Param("keyword")String keyword, @Param("startRow")int startRow, @Param("endRow")int endRow);
	
	//배송상태 변경페이지 출력 시 페이지 사이즈 조절을 위한 카운트 조회
	@Select("select count(*) from (select * from (select ROW_NUMBER() OVER(PARTITION BY order_num ORDER BY order_num ) AS RNUM, ordertbl.* FROM ordertbl where ${category} like #{keyword}) where rnum=1)")
	int getOrderManageCnt(@Param("category")String category, @Param("keyword")String keyword);	
	
	
	
	//////////////////////////////////
	
	@Select("select * from recentaddrtbl where userid=#{userid} order by deli_addr_seq asc")
	public ArrayList<RecentAddrDTO>getRecentAddr(@Param("userid")String userid);
	
	@Select("select * from myaddrtbl where userid=#{userid} order by my_deli_addr_seq asc")
	public ArrayList<MyAddrDTO>getMyAddr(@Param("userid")String userid);
	
	@Select("select count(*) from myaddrtbl where (my_deli_addr like #{deli_postcode} and my_deli_name like #{deli_name}) and userid=#{userid}")
	public int myAddrCheck(@Param("deli_postcode")String deli_postcode, @Param("deli_name")String deli_name, @Param("userid")String userid);
	
	@Select("select count(*) from myaddrtbl where userid=#{userid}")
	public int myAddrCnt(@Param("userid")String userid);
	
	@Insert("insert into myaddrtbl values(my_deli_addr_seq.nextVal,#{userid},#{my_deli_nick},#{my_deli_name},#{my_deli_addr},#{my_deli_phone},#{my_deli_msg},#{my_deli_pwd})")
	public void insertMyAddr(MyAddrDTO myAddrDTO);
	
	@Select("select * from myaddrtbl where userid=#{userid} order by my_deli_addr_seq asc")
	ArrayList<MyAddrDTO> getMyAddrList(@Param("userid")String userid);
	
	@Delete("delete from myaddrtbl where my_deli_addr_seq=#{my_deli_addr_seq}")
	public void deleteMyAddr(@Param("my_deli_addr_seq")int my_deli_addr_seq);
	
	@Update("update myaddrtbl set my_deli_nick=#{my_deli_nick}, my_deli_name=#{my_deli_name}, my_deli_addr=#{my_deli_addr}, my_deli_phone=#{my_deli_phone}, my_deli_msg=#{my_deli_msg}, my_deli_pwd=#{my_deli_pwd} where my_deli_addr_seq=#{my_deli_addr_seq}")
	public void updateMyAddr(MyAddrDTO myAddrDTO);
	
	@Insert("insert into ordertbl values(#{order_num}, #{userid}, sysdate, #{order_name}, #{amount}, #{usePoint}, #{deli_name}, #{deli_addr}, #{deli_phone}, #{deli_msg}, #{deli_pwd},  #{deli_status}, #{item_pictureUrl1}, #{item_num}, #{item_name}, #{item_price}, #{item_cnt}, #{refund_status}, #{refund_request}, #{refund_reject})")
	public void insertOrder(OrderDTO orderDTO);
	
	@Select("select count(*) from recentaddrtbl where (deli_addr like #{deli_postcode} and deli_name like #{deli_name}) and userid=#{userid}")
	public int recentAddrCheck(@Param("deli_postcode")String deli_postcode, @Param("deli_name")String deli_name, @Param("userid")String userid);
	
	@Select("select deli_addr_seq from (select deli_addr_seq from recentaddrtbl where userid=#{userid} order by deli_addr_seq asc) where rownum=1")
	public int oldRecntAddrFind(@Param("userid")String userid);
	
	@Insert("insert into recentaddrtbl values(deli_addr_seq.nextVal, #{userid}, #{deli_name}, #{deli_addr}, #{deli_phone}, #{deli_msg}, #{deli_pwd})")
	public void insertRecentAddr(RecentAddrDTO recentAddrDTO);
	
	@Delete("delete from recentaddrtbl where deli_addr_seq=#{deli_addr_seq}")
	public void deleteRecentAddr(@Param("deli_addr_seq")int deli_addr_seq);
}
