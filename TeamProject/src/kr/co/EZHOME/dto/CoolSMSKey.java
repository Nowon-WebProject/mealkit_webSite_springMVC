package kr.co.EZHOME.dto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.RequestScope;

import kr.co.EZHOME.database.UserMapper;

//한번만 apikey, apisecret 값을 DB에서 가져오기 위한 클래스

@Component
public class CoolSMSKey {
	
	private String apiKey;
	private String apiSecret;
	private String phone;

	public CoolSMSKey() {
		
	}

	public String getApiKey() {
		return apiKey;
	}

	public void setApiKey(String apiKey) {
		this.apiKey = apiKey;
	}

	public String getApiSecret() {
		return apiSecret;
	}

	public void setApiSecret(String apiSecret) {
		this.apiSecret = apiSecret;
	}
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
}
