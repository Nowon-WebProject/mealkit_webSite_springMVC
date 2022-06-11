package kr.co.EZHOME.dto;

import org.springframework.stereotype.Component;


public class PageDTO {

	private int pageSize; //화면에 보여질 총 게시글 개수
	private int pageNum; // 누른 페이지
	private int startPage; //시작 페이지
	private int endPage; //끝페이지
	private int startRow; //페이지에서 가져올 첫번째 상품 DB Row 값
	private int endRow; // 페이지에서 가져올 마지막 상품 DB Row 값
	private int pageCount; //전체 페이지 개수
	
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

}
