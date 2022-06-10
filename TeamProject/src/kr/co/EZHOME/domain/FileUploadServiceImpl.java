package kr.co.EZHOME.domain;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileUploadServiceImpl implements FileUploadService {

	
	public String saveFile(MultipartFile file, String saveDirectory) {
		// 파일 이름 변경
		UUID uuid = UUID.randomUUID();
		String saveName = uuid + "_" + file.getOriginalFilename(); //서버상의 파일이름이 겹치는것을 방지
		saveName = saveName.substring(30);
		System.out.println("saveName: " + saveName);

		// 저장할 File 객체를 생성(껍데기 파일)
		File fileInfo = new File(saveDirectory, saveName); // 저장할 폴더 경로, 저장할 파일 이름

		try {
			file.transferTo(fileInfo); // 업로드 파일에 fileInfo이라는 정보를 추가하여 파일을 저장한다.
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}

		return saveName;
	} 
}
