package kr.happyjob.study.std.model;


public class UserUpdateModel {
	
	private String loginID;
	private String name;
	private String password;
	private int user_zipcode;
	private String user_address;
	private String user_hp;
	private String user_email;
	private String resume_file; 
	private String resume_non;
	private String resume_mul;
	
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	
	
	
	
}