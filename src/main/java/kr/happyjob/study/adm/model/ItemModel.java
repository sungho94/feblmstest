package kr.happyjob.study.adm.model;

public class ItemModel {
	private int item_no;   //장비번호
	private String room_seq;    //강의실번호(순번)
	private String item_note;   // 비고
	private String item_volume;   //갯수(수량)
	private String item_name;   //장비명  
	
	
	
	public int getItem_no() {
		return item_no;
	}
	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}
	
	public String getItem_note() {
		return item_note;
	}
	public void setItem_note(String item_note) {
		this.item_note = item_note;
	}
	
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	
	public String getItem_volume() {
		return item_volume;
	}
	public void setItem_volume(String item_volume) {
		this.item_volume = item_volume;
	}
	public String getRoom_seq() {
		return room_seq;
	}
	public void setRoom_seq(String room_seq) {
		this.room_seq = room_seq;
	}
	
	
	
	
}
