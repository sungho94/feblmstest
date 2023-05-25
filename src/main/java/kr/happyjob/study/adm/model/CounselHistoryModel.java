package kr.happyjob.study.adm.model;

public class CounselHistoryModel {
	
	private int consultant_no; //상담번호
	private String loginID;  //관리자 아이디
	private String stu_loginID; // 학생 아이디
	private String consultant_counsel;  //상담일
	private String consultant_date; //작성일
	private String lecture_name; //강의명
	private String teacher_name; //강사이름
	private String consultant_content; //내용
	private String stu_name; //학생이름
	
	
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public String getStu_loginID() {
		return stu_loginID;
	}
	public void setStu_loginID(String stu_loginID) {
		this.stu_loginID = stu_loginID;
	}
	public String getStu_name() {
		return stu_name;
	}
	public void setStu_name(String stu_name) {
		this.stu_name = stu_name;
	}

	
	public String getConsultant_content() {
		return consultant_content;
	}
	public void setConsultant_content(String consultant_content) {
		this.consultant_content = consultant_content;
	}
	public String getLecture_name() {
		return lecture_name;
	}
	public void setLecture_name(String lecture_name) {
		this.lecture_name = lecture_name;
	}
	
	public int getConsultant_no() {
		return consultant_no;
	}
	public void setConsultant_no(int consultant_no) {
		this.consultant_no = consultant_no;
	}


	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
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
