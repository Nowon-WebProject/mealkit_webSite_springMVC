package kr.co.EZHOME.domain;

import java.util.Vector;

import org.springframework.stereotype.Service;

import kr.co.EZHOME.dao.BoardDAO;
import kr.co.EZHOME.dto.BbsDTO;

@Service
public class Board {

	private final BoardDAO boardDAO;
	
	public Board(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}
	
	//게시글 수정
	public void updateMember(BbsDTO bdto) {
		boardDAO.updateMember(bdto);
	}
	
	//해당 bbsid의 게시글을 삭지
	public void deleteMember(String bbsid) {
		boardDAO.deleteMember(bbsid);
	}
	
	//bbsCount 를 수정
	public void updateBBSCount(BbsDTO bdto) {
		boardDAO.updateBBSCount(bdto);
	}
	
	//해당 bbsid의 게시글 정보 가져오기
	public BbsDTO findBoard(String bbsid) {
		BbsDTO boardInfo = boardDAO.findBoard(bbsid);
		
		return boardInfo;
	}
	
	//게시글 작성
	public void bbsWrite(BbsDTO bdto) {
		
		boardDAO.bbsWrite(bdto);
	}
	
	//공지사항 리스트 가져오기
	public Vector<BbsDTO> getBBSList() {
		Vector<BbsDTO> bbsDTO = boardDAO.getBBSList();
		
		return bbsDTO;
	}
}
