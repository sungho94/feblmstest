package kr.happyjob.study.adm.model;

import java.util.Date;

public class SurveyModel {
	
	// 설문조사 강사 목록 
	private String loginID;
	private String name;
	private String user_hp;
	private String user_email;
	private String user_regdate;
	private String user_address;
	
	// 설문조사 강의 목록
	private String lecture_name;
	private String lecture_start;
	private String lecture_end;
	private int lecture_seq;
	private int lecture_person;
	private int result;
	
	// 설문조사 결과
	private int servey_no;
	private int serveyitem_queno;
	private int answer1;
	private int answer2;
	private int answer3;
	private int answer4;
	private int answer5;
	private String serveyitem_question;
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUser_hp() {
		return user_hp;
	}
	public void setUser_hp(String user_hp) {
		this.user_hp = user_hp;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_regdate() {
		return user_regdate;
	}
	public void setUser_regdate(String user_regdate) {
		this.user_regdate = user_regdate;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getLecture_name() {
		return lecture_name;
	}
	public void setLecture_name(String lecture_name) {
		this.lecture_name = lecture_name;
	}
	public String getLecture_start() {
		return lecture_start;
	}
	public void setLecture_start(String lecture_start) {
		this.lecture_start = lecture_start;
	}
	public String getLecture_end() {
		return lecture_end;
	}
	public void setLecture_end(String lecture_end) {
		this.lecture_end = lecture_end;
	}
	public int getLecture_seq() {
		return lecture_seq;
	}
	public void setLecture_seq(int lecture_seq) {
		this.lecture_seq = lecture_seq;
	}
	public int getLecture_person() {
		return lecture_person;
	}
	public void setLecture_person(int lecture_person) {
		this.lecture_person = lecture_person;
	}
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public int getServey_no() {
		return servey_no;
	}
	public void setServey_no(int servey_no) {
		this.servey_no = servey_no;
	}
	public int getServeyitem_queno() {
		return serveyitem_queno;
	}
	public void setServeyitem_queno(int serveyitem_queno) {
		this.serveyitem_queno = serveyitem_queno;
	}
	public int getAnswer1() {
		return answer1;
	}
	public void setAnswer1(int answer1) {
		this.answer1 = answer1;
	}
	public int getAnswer2() {
		return answer2;
	}
	public void setAnswer2(int answer2) {
		this.answer2 = answer2;
	}
	public int getAnswer3() {
		return answer3;
	}
	public void setAnswer3(int answer3) {
		this.answer3 = answer3;
	}
	public int getAnswer4() {
		return answer4;
	}
	public void setAnswer4(int answer4) {
		this.answer4 = answer4;
	}
	public int getAnswer5() {
		return answer5;
	}
	public void setAnswer5(int answer5) {
		this.answer5 = answer5;
	}
	public String getServeyitem_question() {
		return serveyitem_question;
	}
	public void setServeyitem_question(String serveyitem_question) {
		this.serveyitem_question = serveyitem_question;
	}
	
	
	
	
}