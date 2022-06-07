package kr.co.EZHOME.dao;

import org.springframework.stereotype.Repository;

import kr.co.EZHOME.database.MyPageMapper;
import kr.co.EZHOME.dto.UserDTO;

@Repository
public class MyPageDAO {
	
	private final MyPageMapper myPageMapper;
	
	public MyPageDAO(MyPageMapper myPageMapper) {
		this.myPageMapper = myPageMapper;
		
	}
	
	public void deleteMember(String userid) {
		myPageMapper.deleteMember(userid);
		
	}
	
	public int updateMember(UserDTO udto) {
		int updateMember = myPageMapper.updateMember(udto);
		
		return updateMember;
	}
}
