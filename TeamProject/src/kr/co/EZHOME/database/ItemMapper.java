package kr.co.EZHOME.database;

import java.util.ArrayList;
import java.util.Vector;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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
}
