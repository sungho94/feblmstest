package kr.happyjob.study.tut.model;

public class StudentInfoModel {

	private int lecture_seq; //강의실 시퀀스
	private int lecture_no; // 강의실 코드
	private String lecture_name; // 강의실 이름
	private String teacher_name; // 강사 이름
	private String student_name; // 수강생 이름
	private String student_no; // 수강생 학번
	private String student_hp_no; // 수강생 전화번호
	private String student_birth; // 수강생 생일
	private String lecture_start; // 강의시작일
	private String lecture_end; // 강의종강일
	private String room_name; // 강의실
	private String lecture_person; // 현재수강인원
	private String lecture_total ; // 정원
	private String loginID; // 로그인한 아이디
	private String student_date; // 수강신청일
	private String student_lecture; // 수강상태
	private String student_survey; // 설문여부
	private String student_test; // 시험여부
	private String student_test_score; // 시험점수
	
	
	public int getLecture_no() {
		return lecture_no;
	}
	public void setLecture_no(int lecture_no) {
		this.lecture_no = lecture_no;
	}
	public String getLecture_name() {
		return lecture_name;
	}
	public void setLecture_name(String lecture_name) {
		this.lecture_name = lecture_name;
	}
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public String getStudent_name() {
		return student_name;
	}
	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}
	
	public String getStudent_hp_no() {
		return student_hp_no;
	}
	public void setStudent_hp_no(String student_hp_no) {
		this.student_hp_no = student_hp_no;
	}
	public String getStudent_birth() {
		return student_birth;
	}
	public void setStudent_birth(String student_birth) {
		this.student_birth = student_birth;
	}
	public String getLecture_end() {
		return lecture_end;
	}
	public void setLecture_end(String lecture_end) {
		this.lecture_end = lecture_end;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	
	public String getLecture_total() {
		return lecture_total;
	}
	public void setLecture_total(String lecture_total) {
		this.lecture_total = lecture_total;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getStudent_date() {
		return student_date;
	}
	public void setStudent_date(String student_date) {
		this.student_date = student_date;
	}
	public String getStudent_lecture() {
		return student_lecture;
	}
	public void setStudent_lecture(String student_lecture) {
		this.student_lecture = student_lecture;
	}
	
	public String getStudent_test() {
		return student_test;
	}
	public void setStudent_test(String student_test) {
		this.student_test = student_test;
	}
	public String getStudent_test_score() {
		return student_test_score;
	}
	public void setStudent_test_score(String student_test_score) {
		this.student_test_score = student_test_score;
	}
	public String getLecture_start() {
		return lecture_start;
	}
	public void setLecture_start(String lecture_start) {
		this.lecture_start = lecture_start;
	}
	public String getLecture_person() {
		return lecture_person;
	}
	public void setLecture_person(String lecture_person) {
		this.lecture_person = lecture_person;
	}
	public int getLecture_seq() {
		return lecture_seq;
	}
	public void setLecture_seq(int lecture_seq) {
		this.lecture_seq = lecture_seq;
	}
	public String getStudent_no() {
		return student_no;
	}
	public void setStudent_no(String student_no) {
		this.student_no = student_no;
	}
	public String getStudent_survey() {
		return student_survey;
	}
	public void setStudent_survey(String student_survey) {
		this.student_survey = student_survey;
	}
	
	
}
