package kr.co.EZHOME.dao;

import java.util.Vector;

import org.springframework.stereotype.Repository;

import kr.co.EZHOME.database.BoardMapper;
import kr.co.EZHOME.dto.BbsDTO;

@Repository
public class BoardDAO {

	private final BoardMapper boardMapper;

	public BoardDAO(BoardMapper boardMapper) {
		this.boardMapper = boardMapper;
	}

	// 게시글 수정
	public void updateMember(BbsDTO bdto) {
		boardMapper.updateMember(bdto);
	}

	// 해당 bbsid의 게시글을 삭지
	public void deleteMember(String bbsid) {
		boardMapper.deleteMember(bbsid);
	}

	// bbsCount 를 수정
	public void updateBBSCount(BbsDTO bdto) {
		boardMapper.updateBBSCount(bdto);
	}

	// 해당 bbsid의 게시글 정보 가져오기
	public BbsDTO findBoard(String bbsid) {
		BbsDTO boardInfo = boardMapper.findBoard(bbsid);

		return boardInfo;
	}

	// 게시글 작성
	public void bbsWrite(BbsDTO bdto) {

		boardMapper.bbsWrite(bdto);
	}

	// 공지사항 리스트 가져오기
	public Vector<BbsDTO> getBBSList() {
		Vector<BbsDTO> bbsDTO = boardMapper.getBBSList();

		return bbsDTO;
	}
}
