package kr.co.EZHOME.domain;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.RequestScope;

import kr.co.EZHOME.dao.UserDAO;
import kr.co.EZHOME.database.UserMapper;
import kr.co.EZHOME.dto.UserDTO;

@Service
public class User {
	
	private final UserDAO userDAO;
	
	public User(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	//검색 type과 검색어에 맞는 유저 정보들 가져오기
	public Vector<UserDTO> likeFind(String type, String key) {
		Vector<UserDTO> userInfos = userDAO.likeFind(type, key);
		
		return userInfos;
	}
	
	public String deleteMember(String userid) {
		String message;
		DAOResult result = userDAO.deleteMember(userid);
		
		if (result == DAOResult.Success) {
			message =  "삭제되었습니다";
		} 
		else {
			message = "오류 확인";
		}
		
		return message;
	}
	
	public String updateMember(UserDTO userDTO) {
		
		DAOResult result = userDAO.updateMember(userDTO);
		String message;
		if (result == DAOResult.Success) {
			message =  "수정되었습니다";
		} 
		else {
			message = "오류 확인";
		}
		
		return message;
	}
	
	//주소를 우편번호, 도로명주소, 상세주소, 생년월일을 나눠준다
	public String[] seperateData(String addr, Date dateBirth, String email) {
		String[] arr= {"","","", "", "", ""};
		String a = "";
		int count=0;
		int count1=0;
	
		if (addr != null) {
			for(int i=0;i<addr.length();i++) {
				if(addr.charAt(i) == ')') { count=i;}
				if(addr.charAt(i) == ',') { count1=i;}}
			
			for(int i=1;i<=count-1;i++) {
				arr[0]+=addr.charAt(i);
			}
			for(int i=count+2;i<count1;i++) {
				arr[1]+=addr.charAt(i);
			}
			for(int i=count1+2;i<addr.length();i++) {
				arr[2]+=addr.charAt(i);
			}
		}

		//생년월일 - 삭제
		if (dateBirth != null) {
			String birth = dateBirth.toString();
			for (int i = 0; i < birth.length(); i++) {
				if (birth.charAt(i) != '-') {
					a += birth.charAt(i);
				}
			}
			arr[3] = a;
		}
		
		//이메일 분리
		if (email == null || email == "" ) {
	
		}
		else if (email.equals("null")) {
			
		}
		else {
			String[] splitEmail = email.split("@");
			arr[4] = splitEmail[0];
			arr[5] = splitEmail[1];
		}
		
		
		return arr;
	}
	
	//전체 회원정보 가져오기
	public Vector<UserDTO> allSelect() {
		Vector<UserDTO> memberInfo = userDAO.allSelect();
		
		return memberInfo;
	}
	
	public DataStatus comfirmId(String userid) {
		DataStatus result;
		UserDTO userDTO;
		
		if (userid.length() <4) {
			result = DataStatus.Invalid_InputValue;
			return result;
		}
		else {
			try {
				userDTO = userDAO.findUser(userid);
				result = DataStatus.Exist;	
			}
			//존재하지 않는 회원일 경우 (exception 발생)
			catch (Exception e){
				result = DataStatus.Not_Exist;
			}	
		}
		
		return result;
	}
	
	public UserDTO login(String userid) throws Exception{
		//userid 로 찾기
		UserDTO userDTO = userDAO.findUser(userid);
		
		return userDTO;
	}
	
	public String updatePassword(String userid, String password) {
		String message;
		UserDTO userDTO;
		
		//1. 새 비밀번호가 이전 비밀번호와 일치하는지 확인하기
		try {
			userDTO = userDAO.findUser(userid);
			if (userDTO.getPwd().equals(password)) {
				message = "비밀번호가 이전 비밀번호와 같습니다. 새로운 비밀번호를 입력해주세요";
				return message;
			}
			//DB에 존재하지 않는 id가 들어왔을경우 에러발생
		}catch (Exception e) {
			e.printStackTrace();
		}
	
		//2. 새 비밀번호가 이전 비밀번호와 일치하지 않다면
		DAOResult result = userDAO.updatePassword(userid, password);
		if (result == DAOResult.Success) {
			message = "비밀번호 변경에 성공했습니다";
		}
		else {
			message = "비밀번호 변경에 실패했습니다";
		}
		
		return message;
	}
	
	public String insertMember(UserDTO userDTO) {
		DAOResult result;
		String message;
		
		result = userDAO.insertMember(userDTO);
		if (result == DAOResult.Success) {
			message = "회원 가입에 성공했습니다.";
		}
		else {
			message = "회원 가입에 실패했습니다.";
		}
		
		return message;
	}
}

