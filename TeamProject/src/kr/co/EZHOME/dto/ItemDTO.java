package kr.co.EZHOME.dto;

import java.sql.Date;

public class ItemDTO {
	private String item_pictureUrl1; //섬네일
	private String item_pictureUrl2; //상세이미지
	private int item_num; //상품 번호
	private String item_category; //카테고리
	private String item_name; //이름
	private String item_content; // 상품설명
	private int item_price; //가격
	private int item_quantity; //재고량
	private Date item_date; //상품 추가된 시간
	private String item_total; //몇인분
	private String item_time; //조리시간
	private String item_main; //메인 출력할 카테고리
	private int item_sales; //판매량
	private double item_discount; //할인율
	private double item_starsAvg; //평균 별점

	public ItemDTO() {
		
		
	}

	public String getItem_pictureUrl1() {
		return item_pictureUrl1;
	}

	public void setItem_pictureUrl1(String item_pictureUrl1) {
		this.item_pictureUrl1 = item_pictureUrl1;
	}

	public String getItem_pictureUrl2() {
		return item_pictureUrl2;
	}

	public void setItem_pictureUrl2(String item_pictureUrl2) {
		this.item_pictureUrl2 = item_pictureUrl2;
	}

	public int getItem_num() {
		return item_num;
	}

	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}

	public String getItem_category() {
		return item_category;
	}

	public void setItem_category(String item_category) {
		this.item_category = item_category;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getItem_content() {
		return item_content;
	}

	public void setItem_content(String item_content) {
		this.item_content = item_content;
	}

	public int getItem_price() {
		return item_price;
	}

	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}

	public int getItem_quantity() {
		return item_quantity;
	}

	public void setItem_quantity(int item_quantity) {
		this.item_quantity = item_quantity;
	}
	
	public Date getItem_date() {
		return item_date;
	}

	public void setItem_date(Date item_date) {
		this.item_date = item_date;
	}

	public String getItem_total() {
		return item_total;
	}

	public void setItem_total(String item_total) {
		this.item_total = item_total;
	}

	public String getItem_time() {
		return item_time;
	}

	public void setItem_time(String item_time) {
		this.item_time = item_time;
	}

	public String getItem_main() {
		return item_main;
	}

	public void setItem_main(String item_main) {
		this.item_main = item_main;
	}

	public int getItem_sales() {
		return item_sales;
	}

	public void setItem_sales(int item_sales) {
		this.item_sales = item_sales;
	}

	public double getItem_discount() {
		return item_discount;
	}

	public void setItem_discount(double item_discount) {
		this.item_discount = item_discount;
	}

	public double getItem_starsAvg() {
		return item_starsAvg;
	}

	public void setItem_starsAvg(double item_starsAvg) {
		this.item_starsAvg = item_starsAvg;
	}	
	
}
