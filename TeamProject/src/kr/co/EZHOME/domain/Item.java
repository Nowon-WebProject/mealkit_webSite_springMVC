package kr.co.EZHOME.domain;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import kr.co.EZHOME.dao.ItemDAO;
import kr.co.EZHOME.dto.ItemDTO;

@Service
public class Item {
	
	private final ItemDAO itemDAO;
	
	public Item(ItemDAO itemDAO) {
		this.itemDAO = itemDAO;
	}
	
	public ArrayList<ItemDTO> selectMainItem(String mainCategory) {
		ArrayList<ItemDTO>ilist = itemDAO.selectMainItem(mainCategory);
		
		return ilist;
	}
}
