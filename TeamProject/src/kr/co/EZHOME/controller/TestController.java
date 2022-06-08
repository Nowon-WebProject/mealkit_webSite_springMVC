package kr.co.EZHOME.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class TestController {
	
	@GetMapping("/test")
	public String test() {
		return "test/martiPartRequest";
	}
	
	@PostMapping("/singleFileUpload")
	public String singleFileUpload(@RequestParam("mediaFile") MultipartFile file, Model model, HttpServletRequest request)
	      throws IOException {
		String saveDirectory=request.getServletContext().getRealPath("resources/images/board");
	   // Save mediaFile on system
	   if (!file.getOriginalFilename().isEmpty()) {
	      file.transferTo(new File(saveDirectory, file.getOriginalFilename()));
	      model.addAttribute("msg", "File uploaded successfully.");
	      model.addAttribute("file", file.getOriginalFilename());
	   } else {
	      model.addAttribute("msg", "Please select a valid mediaFile..");
	   }
	   return "test/fileUploadForm";
	}
}
