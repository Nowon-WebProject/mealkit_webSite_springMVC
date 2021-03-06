package kr.co.EZHOME.dao;

import java.util.Vector;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.EZHOME.database.UserMapper;
import kr.co.EZHOME.domain.DAOResult;
import kr.co.EZHOME.domain.DataStatus;
import kr.co.EZHOME.dto.CoolSMSKey;
import kr.co.EZHOME.dto.UserDTO;

@Repository
public class UserDAO {

	private UserMapper userMapper;

	public UserDAO(UserMapper userMapper) {
		this.userMapper = userMapper;
	}


	// 포인트 적용
	public void applyPoint(int usePoint, int addPoint, String userid) {
		userMapper.applyPoint(usePoint, addPoint, userid);
	}

	// 검색 type과 검색어에 맞는 유저 정보들 가져오기
	public Vector<UserDTO> likeFind(String type, String key) {
		key = "%" + key + "%";
		Vector<UserDTO> userInfos = userMapper.likeFind(type, key);

		return userInfos;
	}

	public DAOResult deleteMember(String userid) {
		DAOResult result;
		int checkResult = userMapper.deleteMember(userid);

		if (checkResult > 0) {
			result = DAOResult.Success;
		} else {
			result = DAOResult.Failed;
		}

		return result;
	}

	// 회원 정보 수정
	public DAOResult updateMember(UserDTO userDTO) {

		int checkDAO = userMapper.updateMember(userDTO);
		DAOResult result;

		if (checkDAO > 0) {
			result = DAOResult.Success;
		} else {
			result = DAOResult.Failed;
		}

		return result;
	}

	// 전체 회원정보 가져오기
	public Vector<UserDTO> allSelect() {
		Vector<UserDTO> memberInfo = userMapper.allSelect();

		return memberInfo;

	}

	// 회원가입) 회원정보 DB에 등록하기
	public DAOResult insertMember(UserDTO userDTO) {
		DAOResult result;
		int insertResult = userMapper.insertMember(userDTO);
		if (insertResult > 0) {
			result = DAOResult.Success;
		} else {
			result = DAOResult.Failed;
		}
		return result;
	}

	// userid로 유저 정보 DB에서 select 후 리턴하기
	public UserDTO findUser(String userid) throws Exception {
		UserDTO udto = userMapper.findUser(userid);

		if (udto == null) {
			throw new IllegalArgumentException("존재하지 않는 회원입니다.");
		}

		return udto;
	}

	// 새 비밀번호 변경하기
	public DAOResult updatePassword(String userid, String password) {
		int updateResult = userMapper.updatePassword(userid, password);
		DAOResult result;

		if (updateResult > 0) {
			result = DAOResult.Success;
		} else {
			result = DAOResult.Failed;
		}

		return result;
	}

	// DB로 부터 userid 찾아서 넘기기 (phone, name, userid 3가지가 모두 일치하는 userid이여야한다)
	public DataStatus checkUserPhoneNameId(String phone, String name, String userid) {
		String checkedUserid = userMapper.checkUserPhoneNameId(phone, name, userid);
		DataStatus result;

		if (checkedUserid == null) {
			result = DataStatus.Not_Exist;
		} else {
			result = DataStatus.Exist;
		}
		return result;
	}

	// DB로 부터 userid 찾아서 넘기기 (phone, name 이 일치하는 userid여야한다)
	public String checkUserPhoneName(String phone, String name) {
		String userid = userMapper.checkUserPhoneName(phone, name);

		return userid;
	}

	// DB로 부터 userid 찾아서 넘기기
	public DataStatus checkUserPhone(String phone) {
		DataStatus result;
		String userid = userMapper.checkUserPhone(phone);

		if (userid == null) {
			result = DataStatus.Not_Exist;
		} else {
			result = DataStatus.Exist;
		}

		return result;
	}

	// CoolSMS api key, api secret, phone 받아오기
	public CoolSMSKey getCoolSMS() {
		CoolSMSKey coolSMSKey = userMapper.getCoolSMS();

		try {
			if (coolSMSKey == null) {
				throw new IllegalArgumentException("CoolSMS API DB가 존재하지 않습니다");
			}
		} catch (Exception e) {
			// 에러 출력
			e.printStackTrace();
		}

		return coolSMSKey;
	}

	//////////////////////////////
	public UserDTO getMember(String userid) {
		UserDTO udto = userMapper.getMember(userid);

		return udto;
	}

	public String userCheck(String userid) {
		String userPwd = userMapper.userCheck(userid);
		return userPwd;
	}

//	public void deleteMember(String userid) {
//		userMapper.deleteMember(userid);
//
//	}
//
//	public int updateMember(UserDTO udto) {
//		int updateMember = userMapper.updateMember(udto);
//
//		return updateMember;
//	}

}
