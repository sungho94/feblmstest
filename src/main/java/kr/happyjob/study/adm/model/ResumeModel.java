package kr.happyjob.study.adm.model;

public class ResumeModel {
	
	private int lecture_seq;             // 강의 시퀸스
	private String loginID;              // 사용자ID
	private int lecture_no;              // 강의번호
	private String lecture_person;       // 모집인원
	private String lecture_start;        // 강의시작날짜
	private String lecture_end;          // 강의종료날짜
	private String user_type;            // 유저타입 A:학생, B:강사, C:관리자
	private String name;                 // 이름
	private String user_hp;              // 연락처
	private String user_email;           // 이메일
	private String resume_file;          // 이력서
	private String resume_non;           // 논리경로
	private String resume_mul;           // 물리경로
	private String student_resume;       // 이력서 제출여부
	private String lecture_name;         // 강의명
	
	
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
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
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
	public String getResume_file() {
		return resume_file;
	}
	public void setResume_file(String resume_file) {
		this.resume_file = resume_file;
	}
	public String getResume_non() {
		return resume_non;
	}
	public void setResume_non(String resume_non) {
		this.resume_non = resume_non;
	}
	public String getResume_mul() {
		return resume_mul;
	}
	public void setResume_mul(String resume_mul) {
		this.resume_mul = resume_mul;
	}
	public String getStudent_resume() {
		return student_resume;
	}
	public void setStudent_resume(String student_resume) {
		this.student_resume = student_resume;
	}
	
	
	
}
