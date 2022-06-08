package kr.co.EZHOME.dto;

public class BbsDTO {
	private int bbsid;
	private String userid;
	private String bbstitle;
	private String bbscontent;
	private String bbsdate;
	private String bbsimg;
	private int bbscount;

	public int getBbscount() {
		return bbscount;
	}

	public void setBbscount(int bbscount) {
		this.bbscount = bbscount;
	}

	public BbsDTO() {

	}

	public String getBbsimg() {
		return bbsimg;
	}

	public void setBbsimg(String bbsimg) {
		this.bbsimg = bbsimg;
	}

	public int getBbsid() {
		return bbsid;
	}

	public void setBbsid(int bbsid) {
		this.bbsid = bbsid;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getBbstitle() {
		return bbstitle;
	}

	public void setBbstitle(String bbstitle) {
		this.bbstitle = bbstitle;
	}

	public String getBbscontent() {
		return bbscontent;
	}

	public void setBbscontent(String bbscontent) {
		this.bbscontent = bbscontent;
	}

	public String getBbsdate() {
		return bbsdate;
	}

	public void setBbsdate(String bbsdate) {
		this.bbsdate = bbsdate;
	}

}
