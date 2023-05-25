package kr.happyjob.study.adm.model;

public class TeacherListModel {
	
	  private String loginID; //강사아이디
      private String  user_type; //강사타입
      private String  name; //이름
      private String  user_hp; //연락처
      private String user_email; //이메일
      private String  user_regdate; //가입일자
      private int user_zipcode; //우편번호
      private String user_address; //주소
      private String user_birthday; //생년월일
      private String lectureName; //강의명
      

	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
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
	public String getUser_regdate() {
		return user_regdate;
	}
	public void setUser_regdate(String user_regdate) {
		this.user_regdate = user_regdate;
	}
	public int getUser_zipcode() {
		return user_zipcode;
	}
	public void setUser_zipcode(int user_zipcode) {
		this.user_zipcode = user_zipcode;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_birthday() {
		return user_birthday;
	}
	public void setUser_birthday(String user_birthday) {
		this.user_birthday = user_birthday;
	}
	public String getLectureName() {
		return lectureName;
	}
	public void setLectureName(String lectureName) {
		this.lectureName = lectureName;
	}

}
