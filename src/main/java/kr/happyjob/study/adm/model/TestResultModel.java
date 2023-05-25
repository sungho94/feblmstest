package kr.happyjob.study.adm.model;

public class TestResultModel {
	
	private int lecture_seq;            // 강의시퀸스
	private String loginID;             // 사용자ID
	private int test_no;                // 시험번호
	private int lecture_no;             // 강의번호
	private String lecture_person;      // 모집인원
	private String name;                // 사용자이름
	private int SCORE;                  // 총점
	private String lecture_name;        // 강의명
	private int AFT;                    // 응시자 카운트
	private int BEF;                    // 미응시자 카운트
	
	
	public int getAFT() {
		return AFT;
	}
	public void setAFT(int aFT) {
		AFT = aFT;
	}
	public int getBEF() {
		return BEF;
	}
	public void setBEF(int bEF) {
		BEF = bEF;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSCORE() {
		return SCORE;
	}
	public void setSCORE(int sCORE) {
		SCORE = sCORE;
	}
	
	
}
