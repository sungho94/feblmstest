package kr.happyjob.study.tut.model;

public class LecturePlanListModel {
	
	private int lecture_seq;              // 강의 시퀸스
	private String loginID;               // 사용자ID
	private int test_no;                  // 시험번호
	private int lecture_no;               // 강의번호
	private String lecture_person;        // 모집인원
	private String lecture_total;         // 마감인원
	private String lecture_goal;          // 수업목표
	private String lecture_start;         // 강의시작날짜
	private String lecture_end;           // 강의종료날짜
	private String lecture_confirm;       // 강의승인여부
	private String lecture_name;          // 강의명
	private String teacherName;                  // 강사명
	private String maxWeek;
	
	
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	public String getMaxWeek() {
		return maxWeek;
	}
	public void setMaxWeek(String maxWeek) {
		this.maxWeek = maxWeek;
	}
	public String getLecture_name() {
		return lecture_name;
	}
	public void setLecture_name(String lecture_name) {
		this.lecture_name = lecture_name;
	}
	public int getLecture_seq() {
		return lecture_seq;
	}
	public void setLecture_seq(int lecture_seq) {
		this.lecture_seq = lecture_seq;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public int getTest_no() {
		return test_no;
	}
	public void setTest_no(int test_no) {
		this.test_no = test_no;
	}
	public int getLecture_no() {
		return lecture_no;
	}
	public void setLecture_no(int lecture_no) {
		this.lecture_no = lecture_no;
	}
	public String getLecture_person() {
		return lecture_person;
	}
	public void setLecture_person(String lecture_person) {
		this.lecture_person = lecture_person;
	}
	public String getLecture_total() {
		return lecture_total;
	}
	public void setLecture_total(String lecture_total) {
		this.lecture_total = lecture_total;
	}
	public String getLecture_goal() {
		return lecture_goal;
	}
	public void setLecture_goal(String lecture_goal) {
		this.lecture_goal = lecture_goal;
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
	public String getLecture_confirm() {
		return lecture_confirm;
	}
	public void setLecture_confirm(String lecture_confirm) {
		this.lecture_confirm = lecture_confirm;
	}
	
	
	
}
