package kr.co.EZHOME.database;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.co.EZHOME.dto.ItemDTO;

public interface ItemMapper {
	@Select("select * from item where item_main like #{mainCategory}")
	ArrayList<ItemDTO> selectMainItem(@Param("mainCategory")String mainCategory);		
}
