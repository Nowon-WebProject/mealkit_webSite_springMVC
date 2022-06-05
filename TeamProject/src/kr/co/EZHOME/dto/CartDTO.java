package kr.co.EZHOME.dto;

public class CartDTO {
	private int item_num;
	private String item_pictureUrl1;
	private int cart_seq;
	private String userid;
	private String item_name;
	private String item_price;
	private int item_cnt;
	private int item_quantity;

	public CartDTO() {

	}

	public int getItem_num() {
		return item_num;
	}

	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}

	public String getItem_pictureUrl1() {
		return item_pictureUrl1;
	}

	public void setItem_pictureUrl1(String item_pictureUrl1) {
		this.item_pictureUrl1 = item_pictureUrl1;
	}

	public int getCart_seq() {
		return cart_seq;
	}

	public void setCart_seq(int cart_seq) {
		this.cart_seq = cart_seq;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getItem_price() {
		return item_price;
	}

	public void setItem_price(String item_price) {
		this.item_price = item_price;
	}

	public int getItem_cnt() {
		return item_cnt;
	}

	public void setItem_cnt(int item_cnt) {
		this.item_cnt = item_cnt;
	}

	public int getItem_quantity() {
		return item_quantity;
	}

	public void setItem_quantity(int item_quantity) {
		this.item_quantity = item_quantity;
	}

}
