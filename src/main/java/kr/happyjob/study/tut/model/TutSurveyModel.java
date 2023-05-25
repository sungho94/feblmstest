package kr.happyjob.study.tut.model;

public class TutSurveyModel {

	// 설문조사 결과
	private int servey_no;
	private int serveyitem_queno;
	private int answer1;
	private int answer2;
	private int answer3;
	private int answer4;
	private int answer5;
	private String serveyitem_question;
	private String name;
	private int lecture_seq;
	
	// 설문조사 강의 목록
	private String lecture_name;
	private String lecture_start;
	private String lecture_end;
	
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getLecture_seq() {
		return lecture_seq;
	}
	public void setLecture_seq(int lecture_seq) {
		this.lecture_seq = lecture_seq;
	}
	
	

}
