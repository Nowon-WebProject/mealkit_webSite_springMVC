package kr.co.EZHOME.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.EZHOME.beans.TestBean;
import kr.co.EZHOME.dao.ItemDAO;
import kr.co.EZHOME.domain.FileUploadServiceImpl;
import kr.co.EZHOME.domain.Item;
import kr.co.EZHOME.dto.PageDTO;
import kr.co.EZHOME.dto.PostscriptDTO;

@Controller
public class TestController {

	private final FileUploadServiceImpl fileuploadService;
	private final Item item;
	
	public TestController(FileUploadServiceImpl fileuploadService, Item item) {
		this.fileuploadService = fileuploadService;
		this.item = item;
	}

	@GetMapping("/testPost")
	public String testPost(@ModelAttribute PageDTO pageDTO, Model model, String order) {

		int item_num = 107;
		if (order == null) {
			order = "1";
		}
		
		item.postscriptPaging(pageDTO, item_num);		
		List<PostscriptDTO> postscripts = item.selectAllPostscript(pageDTO, item_num, order);	
		model.addAttribute("page", pageDTO);
		model.addAttribute("postscripts",  postscripts);
		model.addAttribute("order", order);
		
		return "item/postScript";
	}

	@GetMapping("/test")
	public String test() {
		return "test/martiPartRequest";
	}

//	@PostMapping("/singleFileUpload")
//	public String singleFileUpload(@RequestParam("mediaFile") MultipartFile[] file, @RequestParam("mediaFile2") MultipartFile file2,
//			Model model, HttpServletRequest request)
//	      throws IOException {
//		String saveDirectory=request.getServletContext().getRealPath("resources/images/board");
//	   // Save mediaFile on system
//	   if (!file[0].getOriginalFilename().isEmpty() && !file[1].getOriginalFilename().isEmpty()) {
//	      file[0].transferTo(new File(saveDirectory, file[0].getOriginalFilename()));
//	      file[1].transferTo(new File(saveDirectory, file[1].getOriginalFilename()));
//	      model.addAttribute("msg", "File uploaded successfully.");
//	      model.addAttribute("file", file[0].getOriginalFilename());
//	      model.addAttribute("file2", file[1].getOriginalFilename());
//	   } else {
//	      model.addAttribute("msg", "Please select a valid mediaFile..");
//	   }
//	   return "test/fileUploadForm";
//	}

	@PostMapping("/singleFileUpload")
	public String singleFileUpload(MultipartFile[] uploadfiles, Model model, HttpServletRequest request)
			throws IOException {
		String saveDirectory = request.getServletContext().getRealPath("resources/images/board");
		// Save mediaFile on system
		int count = 1;
		String fileName;
		for (MultipartFile file : uploadfiles) {
			System.out.println("upload() POST 호출");
			// 파일 이름을 String 값으로 반환한다
			System.out.println("파일 이름(uploadfile.getOriginalFilename()) : " + file.getOriginalFilename());
			// 파일 크기를 반환한다
			System.out.println("파일 크기(uploadfile.getSize()) : " + file.getSize());

			fileName = fileuploadService.saveFile(file, saveDirectory);
			model.addAttribute("file" + String.valueOf(count), fileName);
			count++;
		}

		return "test/fileUploadForm";
	}

//	@PostMapping("/singleFileUpload")
//	public String singleFileUpload(MultipartFile[] uploadfiles, Model model, HttpServletRequest request)
//			throws IOException {
//		String saveDirectory = request.getServletContext().getRealPath("resources/images/board");
//		// Save mediaFile on system
//		int count = 1;
//
//		System.out.println(saveDirectory);
//		for(MultipartFile file : uploadfiles) {
//			UUID uuid = UUID.randomUUID();
//			String saveName = uuid + "_" + file.getOriginalFilename(); 
//			System.out.println("upload() POST 호출");
//			//파일 이름을 String 값으로 반환한다
//			System.out.println("파일 이름(uploadfile.getOriginalFilename()) : "+ file.getOriginalFilename());
//			//파일 크기를 반환한다
//			System.out.println("파일 크기(uploadfile.getSize()) : "+ file.getSize());
//			
//			File fileInfo = new File(saveDirectory, saveName);
//			file.transferTo(fileInfo);
//			model.addAttribute("file" + String.valueOf(count), saveName);
//			count++;
//		}
//
//		return "test/fileUploadForm";
//	}
	@GetMapping("/modelTest")
	public String modelTest() {

		return "test/modelTest";
	}

	@GetMapping("/modelTestResult")
	public String modelTestResult(@ModelAttribute("Bean") TestBean testBean, Model model) {

		int c = 5;
		int d = 6;
		model.addAttribute("TestBean", testBean);
		model.addAttribute("c", c);
		model.addAttribute("d", d);

		return "test/modelTestResult";
	}
}
