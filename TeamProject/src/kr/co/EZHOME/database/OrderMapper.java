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
	
	@Insert("insert into ordertbl values(#{order_num}, #{userid}, sysdate, #{order_name}, #{amount}, #{usePoint}, #{deli_name}, #{deli_addr}, #{deli_phone}, #{deli_msg}, #{deli_pwd}, #{deli_status}, #{item_pictureUrl1}, #{item_num}, #{item_name}, #{item_price}, #{item_cnt}, #{refund_status}, #{refund_request}, #{refund_reject})")
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
