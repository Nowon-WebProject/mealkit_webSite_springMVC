package kr.co.EZHOME.database;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.EZHOME.dto.CartDTO;

public interface CartMapper {

	@Select("select count(item_name) from carttbl where item_name=#{item_name} and userid=#{userid}")
	public int cartCheck(@Param("item_name")String item_name, @Param("userid")String userid);
	
	@Insert("insert into carttbl values(#{item_num},#{item_pictureUrl1},cart_seq.nextVal,#{userid},#{item_name},#{item_price},#{item_cnt},#{item_quantity})")
	public void insertCart(CartDTO cartDTO);
	
	@Update("update carttbl set item_cnt=item_cnt+#{item_cnt} where item_name=#{item_name} and userid=#{userid}")
	public void addCart(@Param("item_name")String item_name, @Param("item_cnt")int item_cnt, @Param("userid")String userid);
	
	@Select("select count(*) from carttbl where userid=#{userid}")
	public int cartCnt(@Param("userid")String userid);
}