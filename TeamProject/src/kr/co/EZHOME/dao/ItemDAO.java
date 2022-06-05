package kr.co.EZHOME.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import kr.co.EZHOME.database.ItemMapper;
import kr.co.EZHOME.dto.ItemDTO;

@Repository
public class ItemDAO {
	
	private final ItemMapper itemMapper;
	
	public ItemDAO(ItemMapper itemMapper) {
		this.itemMapper = itemMapper;
	}
	
	public ArrayList<ItemDTO> selectMainItem(String mainCategory) {
		mainCategory = "%"+mainCategory+"%";
		ArrayList<ItemDTO> ilist = itemMapper.selectMainItem(mainCategory);
		
		return ilist;
	}
}
