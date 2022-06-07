package kr.co.EZHOME.domain;

import org.springframework.stereotype.Service;

import kr.co.EZHOME.dao.MyPageDAO;
import kr.co.EZHOME.dto.UserDTO;

@Service
public class MyPage {

	private final MyPageDAO myPageDAO;
	
	public MyPage(MyPageDAO myPageDAO) {
		this.myPageDAO = myPageDAO;
	}
	
	
	public void deleteMember(String userid) {
		myPageDAO.deleteMember(userid);
		
	}
	
	public int updateMember(UserDTO udto) {
		
		int updateCheck = myPageDAO.updateMember(udto);
		
		
		return updateCheck;
	}
	
	
	
	
}
