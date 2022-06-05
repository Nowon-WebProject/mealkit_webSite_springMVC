package kr.co.EZHOME.dto;

public class OrderDTO {
	private String order_num;
	private String userid;
	private String order_date;
	private String order_name;
	private int amount;
	private int usePoint;
	private String deli_name;
	private String deli_addr;
	private String deli_phone;
	private String deli_msg;
	private String deli_pwd;
	private String deli_status;
	private String item_pictureUrl1;
	private int item_num;
	private String item_name;
	private int item_price;
	private int item_cnt;
	private String refund_status;
	private String refund_request;
	private String refund_reject;

	public OrderDTO() {

	}

	public String getOrder_num() {
		return order_num;
	}

	public void setOrder_num(String order_num) {
		this.order_num = order_num;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public String getOrder_name() {
		return order_name;
	}

	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getUsePoint() {
		return usePoint;
	}

	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}

	public String getDeli_name() {
		return deli_name;
	}

	public void setDeli_name(String deli_name) {
		this.deli_name = deli_name;
	}

	public String getDeli_addr() {
		return deli_addr;
	}

	public void setDeli_addr(String deli_addr) {
		this.deli_addr = deli_addr;
	}

	public String getDeli_phone() {
		return deli_phone;
	}

	public void setDeli_phone(String deli_phone) {
		this.deli_phone = deli_phone;
	}

	public String getDeli_msg() {
		return deli_msg;
	}

	public void setDeli_msg(String deli_msg) {
		this.deli_msg = deli_msg;
	}

	public String getDeli_pwd() {
		return deli_pwd;
	}

	public void setDeli_pwd(String deli_pwd) {
		this.deli_pwd = deli_pwd;
	}

	public String getDeli_status() {
		return deli_status;
	}

	public void setDeli_status(String deli_status) {
		this.deli_status = deli_status;
	}

	public String getItem_pictureUrl1() {
		return item_pictureUrl1;
	}

	public void setItem_pictureUrl1(String item_pictureUrl1) {
		this.item_pictureUrl1 = item_pictureUrl1;
	}

	public int getItem_num() {
		return item_num;
	}

	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public int getItem_price() {
		return item_price;
	}

	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}

	public int getItem_cnt() {
		return item_cnt;
	}

	public void setItem_cnt(int item_cnt) {
		this.item_cnt = item_cnt;
	}

	public String getRefund_status() {
		return refund_status;
	}

	public void setRefund_status(String refund_status) {
		this.refund_status = refund_status;
	}

	public String getRefund_request() {
		return refund_request;
	}

	public void setRefund_request(String refund_request) {
		this.refund_request = refund_request;
	}

	public String getRefund_reject() {
		return refund_reject;
	}

	public void setRefund_reject(String refund_reject) {
		this.refund_reject = refund_reject;
	}

}
