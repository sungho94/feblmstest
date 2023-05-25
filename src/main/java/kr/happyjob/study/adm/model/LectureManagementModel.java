package kr.happyjob.study.adm.model;

public class LectureManagementModel {
	
	private String teacher_name;	//강사 이름 
	private String room_name;    	// 강의실 이름
	private String room_no;			// 강의실번호
	private int room_seq;			// 룸시퀀스
	private int lecture_seq;		// 강의시퀀스
	private int lecture_no;			// 강의번호
	private String loginID;			//사용자ID
	private int test_no;			//시험번호
	private String test_title;      // 시험명
	private String lecture_name;	//강의명
	private String lecture_person;	//모집인원
	private String lecture_total;	//마감인원
	private String lecture_goal;	//수업목표
	private String lecture_start;	//강의 시작날짜
	private String lecture_end;		//강의 종료날짜
	private String lecture_confirm;	//강의 종료 여부 
	private String room_status;	//강의실 사용 여부 
	private String checkBoxStatus;
	
	
	public String getCheckBoxStatus() {
		return checkBoxStatus;
	}
	public void setCheckBoxStatus(String checkBoxStatus) {
		this.checkBoxStatus = checkBoxStatus;
	}
	public String getRoom_status() {
		return room_status;
	}
	public void setRoom_status(String room_status) {
		this.room_status = room_status;
	}
	public int getRoom_seq() {
		return room_seq;
	}
	public void setRoom_seq(int room_seq) {
		this.room_seq = room_seq;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public String getRoom_no() {
		return room_no;
	}
	public void setRoom_no(String room_no) {
		this.room_no = room_no;
	}
	public int getLecture_seq() {
		return lecture_seq;
	}
	public void setLecture_seq(int lecture_seq) {
		this.lecture_seq = lecture_seq;
	}
	public int getLecture_no() {
		return lecture_no;
	}
	public void setLecture_no(int lecture_no) {
		this.lecture_no = lecture_no;
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
	public String getTest_title() {
		return test_title;
	}
	public void setTest_title(String test_title) {
		this.test_title = test_title;
	}
	public String getLecture_name() {
		return lecture_name;
	}
	public void setLecture_name(String lecture_name) {
		this.lecture_name = lecture_name;
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
