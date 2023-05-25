package kr.happyjob.study.tut.model;

public class CounselModel {
	
	// 강의 목록 볼러오기
	private int lecture_no;
	private int lecture_seq;
	private String lecture_Name;
	private String teacherName;
	private String tchLoginID;
	private String lecture_start;
	private String lecture_end;
	private String room_name;
	
	// 학생 목록 불러오기
	private int consultant_no;
	private String studentName;
	private String stuLoginID;
	private String consultant_content;
	private String consultant_counsel;
	private String consultant_date;
	
	
	public int getLecture_no() {
		return lecture_no;
	}
	public void setLecture_no(int lecture_no) {
		this.lecture_no = lecture_no;
	}
	public int getLecture_seq() {
		return lecture_seq;
	}
	public void setLecture_seq(int lecture_seq) {
		this.lecture_seq = lecture_seq;
	}
	public String getLecture_Name() {
		return lecture_Name;
	}
	public void setLecture_Name(String lecture_Name) {
		this.lecture_Name = lecture_Name;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
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
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public int getConsultant_no() {
		return consultant_no;
	}
	public void setConsultant_no(int consultant_no) {
		this.consultant_no = consultant_no;
	}
	public String getTchLoginID() {
		return tchLoginID;
	}
	public void setTchLoginID(String tchLoginID) {
		this.tchLoginID = tchLoginID;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getStuLoginID() {
		return stuLoginID;
	}
	public void setStuLoginID(String stuLoginID) {
		this.stuLoginID = stuLoginID;
	}
	public String getConsultant_content() {
		return consultant_content;
	}
	public void setConsultant_content(String consultant_content) {
		this.consultant_content = consultant_content;
	}
	public String getConsultant_counsel() {
		return consultant_counsel;
	}
	public void setConsultant_counsel(String consultant_counsel) {
		this.consultant_counsel = consultant_counsel;
	}
	public String getConsultant_date() {
		return consultant_date;
	}
	public void setConsultant_date(String consultant_date) {
		this.consultant_date = consultant_date;
	}
	
	

	
}
