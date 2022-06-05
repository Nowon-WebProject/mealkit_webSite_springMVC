package kr.co.EZHOME.domain;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.RequestScope;

import kr.co.EZHOME.dao.UserDAO;
import kr.co.EZHOME.database.UserMapper;
import kr.co.EZHOME.dto.CoolSMSKey;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service
public class PhoneAuthentication {
	
	private final UserDAO userDAO;
	private String companyNumber;
	private final DefaultMessageService messageService;
	
	public PhoneAuthentication(UserDAO userDAO) {
		this.userDAO = userDAO;
		CoolSMSKey coolSMSKey = userDAO.getCoolSMS();
		String apiKey = coolSMSKey.getApiKey();
		String apiSecret = coolSMSKey.getApiSecret();
		this.companyNumber = coolSMSKey.getPhone();
		this.messageService = NurigoApp.INSTANCE.initialize(apiKey, apiSecret, "https://api.coolsms.co.kr");
	}
	
	//문자 메시지 발송 api
	public String sendMessage(String phone) {
		String certificationNumber = MakeCertificationNumber();
		
		if (phone.length() == 13) {
			String[] phoneSplit = phone.split("-");
			phone = phoneSplit[0] + phoneSplit[1] + phoneSplit[2];
		}
		Message message = new Message();
		message.setFrom(companyNumber);
		message.setTo(phone);
		message.setText("[" + certificationNumber + "] 이젠, 집에서 인증번호를 입력해주세요.");
		SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
		System.out.println(response);
		
		return certificationNumber;
	}
	
	public String checkUserPhoneNameId(String phone, String name, String userid) {
		String message;
		DataStatus result = userDAO.checkUserPhoneNameId(phone, name, userid);
		
		//3가지 정보를 모두 만족하는 userid가 존재하는 경우
		if (result == DataStatus.Exist) {
			message = "새로운 비밀번호를 입력해 주세요";
		}
		else {
			message = "입력하신 정보와 일치하는 회원정보가 없습니다.";
		}
		
		return message;
	}
	
	//해당 번호와 이름이 일치하는 유저가 있는지 확인 (아이디 찾을때 사용하는 메서드)
	public String checkUserPhoneName(String phone, String name) {
		String message;
		String userid;
		
		userid = userDAO.checkUserPhoneName(phone, name);
		if (userid != null) {
			message = "회원님의 아이디는 " + userid + "입니다";
		}
		else {
			message = "회원님의 아이디가 존재하지 않습니다";
		}
		
		return message;
	}
	
	//해당 번호를 가진 유저가 있는지 확인 (회원가입시 사용하는 메서드)
	public String checkUserPhone(String phone) {
		DataStatus result = userDAO.checkUserPhone(phone);
		String message;
		
		if (result == DataStatus.Exist) {
			message = "이미 회원가입이 완료된 휴대폰 번호입니다";
		}
		//핸드폰번호가 있는 유저가 존재하지 않을때
		else {
			message = "휴대폰 번호 인증이 완료되었습니다";
		}
		
		return message;
	}

	public int sendCount(HttpServletRequest request) {
		HttpSession session = request.getSession();
		int count = 1;
		//처음 전송했을떄 1로 초기화
		if (!(request.getParameter("first") == null)) {
			session.setAttribute("sendCount", 1);
		}
		//발송횟수가 1회 이상일경우 이전 session 값 가져와서 +1
		else {
			count = (Integer)session.getAttribute("sendCount") + 1;
			session.setAttribute("sendCount", count);
		}
		
		return count;
	}
	
	// 6자리 인증번호 난수 만들기
	public String MakeCertificationNumber() {
		Random rand = new Random();
		String numStr = ""; // 난수 저장될 변수

		// 0~9 난수 만들기 6번 반복
		for (int i = 0; i < 6; i++) {
			numStr += Integer.toString(rand.nextInt(10));
		}

		return numStr;
	}
}
