package kr.co.EZHOME.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServlet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.EZHOME.domain.Board;
import kr.co.EZHOME.domain.User;
import kr.co.EZHOME.dto.BbsDTO;
import kr.co.EZHOME.dto.UserDTO;

@Controller
public class ManagePageController {

	private final User user;
	private final Board board;

	public ManagePageController(User user, Board board) {
		this.user = user;
		this.board = board;
	}

	@PostMapping("bbsUpdate.do")
	public String bbsUpdateDo(@RequestParam("mediaFile") MultipartFile file, Model model, HttpServletRequest request) {

		BbsDTO bdto=new BbsDTO();
		String path = request.getServletContext().getRealPath("resources/images/board");
		String bbsid=request.getParameter("bbsid");
		String bbstitle=request.getParameter("bbstitle");
		String bbscontent=request.getParameter("bbscontent");
		String fileName = file.getOriginalFilename();
		
		bbscontent = bbscontent.replace("\n", "<br>");
		bdto.setBbsid(Integer.parseInt(bbsid));
		bdto.setBbstitle(bbstitle);
		bdto.setBbscontent(bbscontent);
		bdto.setBbsimg(fileName);
		
		board.updateMember(bdto);
		
		return "forward:/bbsList.do";
		
	}
	@PostMapping("/bbsWrite.do")
	public String bbsWriteDo(@RequestParam("mediaFile") MultipartFile file, Model model, HttpServletRequest request)
			throws IOException {

		String path = request.getServletContext().getRealPath("resources/images/board");
		String fileName = file.getOriginalFilename();
		String bbstitle = request.getParameter("bbstitle");
		String bbscontent = request.getParameter("bbscontent");
		HttpSession session = request.getSession();
		String userid= (String)session.getAttribute("userid");
		bbscontent = bbscontent.replace("\n", "<br>");

		BbsDTO bdto = new BbsDTO();

		bdto.setUserid(userid);
		bdto.setBbstitle(bbstitle);
		bdto.setBbscontent(bbscontent);

		// Save mediaFile on system
		if (!file.getOriginalFilename().isEmpty()) {
			file.transferTo(new File(path, fileName));
			model.addAttribute("msg", "File uploaded successfully.");
			model.addAttribute("file", fileName);
		} else {
			model.addAttribute("msg", "Please select a valid mediaFile..");
		}

		bdto.setBbsimg(fileName);
		
		board.bbsWrite(bdto);

		return "forward:/bbsList.do";
	}

	@PostMapping("/userBbsView.do")
	public String userBbsViewDo(HttpServletRequest request) {
		String bbsid = request.getParameter("bbsid");
		String url = "managePage/userBbsView";
		String file = "";

		int count = 0;

		BbsDTO bdto = new BbsDTO();
		Vector<BbsDTO> vec = new Vector<BbsDTO>();

		bdto = board.findBoard(bbsid);
		vec.add(bdto);

		bdto.setBbscount(bdto.getBbscount() + 1);
		// 조회수
		board.updateBBSCount(bdto);

		if (bdto.getBbsimg() == "" || bdto.getBbsimg() == null) {
		} 
		else {
			file = bdto.getBbsimg();
		}

		request.setAttribute("file", file);
		request.setAttribute("vec", vec);

		return url;
	}

	@PostMapping("/userBbs.do")
	public String userBbsDo(HttpServletRequest request) {
		Vector<BbsDTO> vec = new Vector<BbsDTO>();
		Vector<BbsDTO> vec1 = new Vector<BbsDTO>();
		BbsDTO bdto;
		String page = request.getParameter("page");
		String size = request.getParameter("size");

		if (page == null || page == "") {
			page = "1";
		}
		if (size == null || size == "") {
			size = "10";
		}
		int pageNum = Integer.parseInt(page);
		int sizeNum = Integer.parseInt(size);
		String[] arr = { "", "", "" };

		switch (sizeNum) {
		case 10:
			arr[0] = "selected";
			break;
		case 15:
			arr[1] = "selected";
			break;
		case 20:
			arr[2] = "selected";
			break;
		}

		/*
		 * 1 2 3 4
		 * 
		 * 1 11 21 31
		 * 
		 * 10 20 30 40
		 */
		vec = board.getBBSList();

		int all = vec.size();

		int count = 0;
		if (all % sizeNum != 0) {
			count = 1;
		}
		all = all / sizeNum;
		if (count == 1) {
			all = all + 1;
		}
		int endNum = pageNum * sizeNum;
		if (endNum > vec.size()) {
			endNum = vec.size();
		}
		int startNum = endNum - sizeNum + 1;

		for (int i = startNum; i <= endNum; i++) {
			bdto = vec.get(i - 1);
			vec1.add(bdto);
		}

		int start = ((pageNum / 10) * 10) + 1;
		int end = start + 9;
		if (end > all) {
			end = all;
		}

		request.setAttribute("page", page);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("all", all);
		request.setAttribute("vec", vec1);
		request.setAttribute("arr", arr);

		return "managePage/userbbs";
	}

	@PostMapping("/bbsDelete.do")
	public String bbsDeleteDo(HttpServletRequest request) {

		String bbsid = request.getParameter("delete");

		board.deleteMember(bbsid);

		return "forward:/bbsList.do";
	}

	@PostMapping("/bbsView.do")
	public String bbsViewDo(HttpServletRequest request) {
		String bbsid = request.getParameter("bbsid");
		String url = "";
		String update = request.getParameter("update");

		String file = "";

		int count = 0;

		BbsDTO bdto = new BbsDTO();
		Vector<BbsDTO> vec = new Vector<BbsDTO>();

		bdto = board.findBoard(bbsid);
		vec.add(bdto);

		if (update == null || update == "") {
			url = "/managePage/bbsView";
			bdto.setBbscount(bdto.getBbscount() + 1);
			board.updateBBSCount(bdto);
		} else {
			url = "/managePage/bbsUpdate";
		}

		if (bdto.getBbsimg() == "" || bdto.getBbsimg() == null) {
		} 
		else {
			file = bdto.getBbsimg();
		}

		// String content = bdto.getBbscontent();
		// String title = bdto.getBbstitle();
		request.setAttribute("file", file);
		request.setAttribute("vec", vec);

		return url;
	}

	@GetMapping("/bbsWrite")
	public String bbsWrite() {

		return "managePage/bbsWrite";
	}

	@PostMapping("/bbsList.do")
	public String bbsListDo(HttpServletRequest request) {

		Vector<BbsDTO> vec = new Vector<BbsDTO>();
		Vector<BbsDTO> vec1 = new Vector<BbsDTO>();
		BbsDTO bdto;
		String page = request.getParameter("page");
		String size = request.getParameter("size");

		if (page == null || page == "") {
			page = "1";
		}
		if (size == null || size == "") {
			size = "10";
		}
		int pageNum = Integer.parseInt(page);
		int sizeNum = Integer.parseInt(size);
		String[] arr = { "", "", "" };

		switch (sizeNum) {
		case 10:
			arr[0] = "selected";
			break;
		case 15:
			arr[1] = "selected";
			break;
		case 20:
			arr[2] = "selected";
			break;
		}

		/*
		 * 1 2 3 4
		 * 
		 * 1 11 21 31
		 * 
		 * 10 20 30 40
		 */
		vec = board.getBBSList();

		int all = vec.size();

		int count = 0;
		if (all % sizeNum != 0) {
			count = 1;
		}
		all = all / sizeNum;
		if (count == 1) {
			all = all + 1;
		}
		int endNum = pageNum * sizeNum;
		if (endNum > vec.size()) {
			endNum = vec.size();
		}
		int startNum = endNum - sizeNum + 1;

		for (int i = startNum; i <= endNum; i++) {
			bdto = vec.get(i - 1);
			vec1.add(bdto);
		}

		int start = ((pageNum / 10) * 10) + 1;
		int end = start + 9;
		if (end > all) {
			end = all;
		}

		request.setAttribute("page", page);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("all", all);
		request.setAttribute("vec", vec1);
		request.setAttribute("arr", arr);

		return "managePage/bbsList";
	}

	@PostMapping("/memberFind.do")
	public String memberFindDo(HttpServletRequest request) {

		String type = request.getParameter("type");
		String key = request.getParameter("key");
		String[] arr = { "", "", "" };

		Vector<UserDTO> vec = new Vector<UserDTO>();

		if (type.equals("userid")) {
			arr[0] = "selected";
		}
		if (type.equals("name")) {
			arr[1] = "selected";
		}
		if (type.equals("phone")) {
			arr[2] = "selected";
		}

		vec = user.likeFind(type, key);

		request.setAttribute("vec", vec);
		request.setAttribute("arr", arr);

		return "managePage/memberSearch";
	}

	@PostMapping("/memberDelete.do")
	public String memberDeleteDo(HttpServletRequest request) {
		String userid = request.getParameter("delete");
		String message;
		message = user.deleteMember(userid);

		System.out.print(message);

		request.setAttribute("message", message);

		return "forward:/memberSearch.do";
	}

	// 회원정보 수정
	@PostMapping("memberUpdate.do")
	public String memberUpdateDo(HttpServletRequest request) {
		String message;
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String birth = request.getParameter("birth");
		if (birth == "") {
			birth = null;
		}
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String addr1 = request.getParameter("addr1");
		String roadaddr = request.getParameter("roadAddr");
		String addr3 = request.getParameter("addr3");
		String userid = request.getParameter("userid");

		String addr = "(" + addr1 + ") " + roadaddr + ", " + addr3;

		// email email + @ + emailSite
		email = null;
		if (request.getParameter("email") != "" && request.getParameter("eMailSite") != "") {
			email = request.getParameter("email") + "@" + request.getParameter("eMailSite");
		}

		UserDTO udto = new UserDTO();
		udto.setName(name);
		udto.setPwd(pwd);
		udto.setBirth(birth);
		udto.setEmail(email);
		udto.setPhone(phone);
		udto.setAddr(addr);
		udto.setUserid(userid);

		message = user.updateMember(udto);
		System.out.print(message);

		request.setAttribute("message", message);

		return "forward:/memberSearch.do";
	}

	@PostMapping("memberOnepick.do")
	public String memberOnepickDo(HttpServletRequest request) {

		String userid = request.getParameter("update");
		String[] arr = { "", "", "", "", "", "" };
		UserDTO userDTO = new UserDTO();

		try {
			userDTO = user.login(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String addr = userDTO.getAddr();
		Date birth = userDTO.getBirth();
		String email = userDTO.getEmail();

		arr = user.seperateData(addr, birth, email);

		request.setAttribute("arr", arr);
		request.setAttribute("bean", userDTO);

		return "managePage/memberUpdate";
	}

	// 전체 회원정보 출력
	@PostMapping("memberSearch.do")
	public String memberSearchDo(HttpServletRequest request) {

		String[] arr = { "", "", "" };
		String message = (String) request.getAttribute("message");
		String test = request.getParameter("test");
		if (test == null || test == "") {

		} else {
			message = "test";
		}

		// 회원정보 받아오기
		Vector<UserDTO> vec = user.allSelect();

		request.setAttribute("vec", vec);
		request.setAttribute("arr", arr);
		request.setAttribute("message", message);

		return "managePage/memberSearch";
	}

}
