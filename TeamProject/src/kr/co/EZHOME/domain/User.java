package kr.co.EZHOME.domain;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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
	

	private UserDAO userDAO;
	
	@Autowired
	public User(UserDAO userDAO) {
		this.userDAO = userDAO;
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
	
	public LoginStatus login(String userid, String inputPassword, HttpServletRequest request)throws Exception {
		//userid 로 찾기
		UserDTO udto = userDAO.findUser(userid);
		//DB pwd
		String pwd = udto.getPwd();
		
		//DB의 pwd와 input pwd가 같은지 확인 
		if(pwd.equals(inputPassword)) {
			//로그인한 유저의 정보 session 에 넣기
			makeSession(request, udto);
			return LoginStatus.LOGIN_SUCCESS;
		}else {
			return LoginStatus.PASSWORD_WRONG;
		}
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

	private void makeSession(HttpServletRequest request, UserDTO udto) {
		HttpSession session = request.getSession();
		session.setAttribute("name", udto.getName());
		session.setAttribute("userid", udto.getUserid());
		session.setAttribute("password",udto.getPwd());
		session.setAttribute("birth", udto.getBirth());
		session.setAttribute("email",udto.getEmail());
		session.setAttribute("phone",udto.getPhone());
		if (udto.getRegistDate() != null) {
			session.setAttribute("registDate", udto.getRegistDate().toString());
		}
		session.setAttribute("addr", udto.getAddr());
		session.setAttribute("deli", udto.getDeli());
		session.setAttribute("point", udto.getPoint());
		session.setAttribute("admin", udto.getAdmin());
	}
	
	
}

