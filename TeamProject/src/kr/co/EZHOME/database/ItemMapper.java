package kr.co.EZHOME.database;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.EZHOME.dto.ItemDTO;

public interface ItemMapper {
	@Select("select * from item where item_main like #{mainCategory}")
	ArrayList<ItemDTO> selectMainItem(@Param("mainCategory")String mainCategory);
	
	@Select("select * from item where item_num=#{item_num}")
	ArrayList<ItemDTO> selectItem(@Param("item_num")int item_num);
	
	@Select("select * from (select A.*, Rownum Rnum from(select * from item where item_name like #{keyword} and "
			+ "item_category like #{category} ${sortSalesSql}order by ${sortPriceSql}${sortDateSql})A) where Rnum >= #{startRow} and Rnum <= #{endRow}")
	Vector<ItemDTO> getItemList(@Param("keyword")String keyword, @Param("category")String category, 
								@Param("sortSalesSql")String sortSalesSql,
								@Param("sortPriceSql")String sortPriceSql, @Param("sortDateSql")String sortDateSql,
								@Param("startRow")int startRow, @Param("endRow")int endRow);
	
	@Select("select count(*) from item where ${itemSalesSql}item_name like #{keyword} and item_category like #{category}")
	int itemSearchCnt(@Param("itemSalesSql")String itemSalesSql, @Param("keyword")String keyword, 
						@Param("category")String category);
	
	@Select("select item_category from item group by item_category order by item_category")
	Vector<ItemDTO> getCategoryList();
	
	@Update("update item set item_sales = item_sales + #{itemCnt}, item_quantity = item_quantity - #{itemCnt} where item_num = #{itemNum}")
	public void updateSalesAndQuantity(@Param("itemCnt")int itemCnt, @Param("itemNum")int itemNum);
	
	@Select("select count(*) from item")
	public int getAllCount();
	
	@Select("select * from(select A.*, Rownum Rnum from(select * from item order by item_num desc)A) where Rnum >= #{startRow} and Rnum <= #{endRow}")
	public List<ItemDTO> selectAllItems(@Param("startRow")int startRow, @Param("endRow")int endRow);
	
	@Insert("insert into item values(#{item_pictureUrl1}, #{item_pictureUrl2}, item_seq.nextval, #{item_category}, #{item_name}, #{item_content}, #{item_price}, "
			+ "#{item_quantity}, sysdate, #{item_total}, #{item_time}, #{item_main}, #{item_sales}, #{item_discount}, #{item_starsAvg})")
	public void insertItem(ItemDTO itemDTO);
	
	@Delete("delete from item where item_num=#{item_num}")
	public void deleteItem(int item_num);
	
	@Update("update item set item_pictureUrl1=#{item_pictureUrl1}, item_pictureUrl2=#{item_pictureUrl2}, "
			+ "item_category=#{item_category}, item_name=#{item_name}, item_content=#{item_content}, item_price=#{item_price}, "
			+ "item_quantity=#{item_quantity}, item_total=#{item_total}, "
			+ "item_time=#{item_time}, item_main=#{item_main}, item_sales=#{item_sales}, item_discount=#{item_discount}, "
			+ "item_starsAvg=#{item_starsAvg} where item_num=#{item_num}")
	public void updateItem(ItemDTO itemDTO);
	
	@Delete("delete from item")
	public void deleteItemTable();
	
	@Update("drop sequence item_seq")
	public void dropSequence();
	
	@Update("create sequence item_seq start with 1 increment by 1")
	public void createSequence();
}
