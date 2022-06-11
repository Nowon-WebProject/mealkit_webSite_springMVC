package kr.co.EZHOME.domain;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public interface FileUploadService {
	public String saveFile(MultipartFile file, String saveDirectory, int count);
}
