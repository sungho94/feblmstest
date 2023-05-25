package kr.happyjob.study.adm.model;

public class LectureModel {
	
	private int lectureNo;                  // 강의번호
	private String loginId;          // 로그인아이디
	private int testNo;                     //시험번호
	private String lectureName;        //강의명
	private String lecturePerson;     //모집인원
	private String lectureTotal;         //마감인원
	private String lectureGoal;         //수업목표
	private String lectureStart;         //강의시작날짜

	private String lectureEnd;         //강의종료날짜
	private String lectureConfirm;   //강의승인여부
	private String roomNo;           //강의실 호실
	private String tutName;           //강사이름
	private int planNo; //계획서 넘버
	private String lectureSeq; // 강의시퀀스
	
	public int getLectureNo() {
		return lectureNo;
	}
	public void setLectureNo(int lectureNo) {
		this.lectureNo = lectureNo;
	}
	public String getLoginId() {
		return loginId;
	}
	public int getPlanNo() {
		return planNo;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public int getTestNo() {
		return testNo;
	}
	public void setTestNo(int testNo) {
		this.testNo = testNo;
	}
	public String getLectureName() {
		return lectureName;
	}
	public void setLectureName(String lectureName) {
		this.lectureName = lectureName;
	}
	public String getLecturePerson() {
		return lecturePerson;
	}
	public void setLecturePerson(String lecturePerson) {
		this.lecturePerson = lecturePerson;
	}
	public String getLectureTotal() {
		return lectureTotal;
	}
	public void setLectureTotal(String lectureTotal) {
		this.lectureTotal = lectureTotal;
	}
	public String getLectureGoal() {
		return lectureGoal;
	}
	public void setLectureGoal(String lectureGoal) {
		this.lectureGoal = lectureGoal;
	}
	public String getLectureStart() {
		return lectureStart;
	}
	public void setLectureStart(String lectureStart) {
		this.lectureStart = lectureStart;
	}
	public String getLectureEnd() {
		return lectureEnd;
	}
	public void setLectureEnd(String lectureEnd) {
		this.lectureEnd = lectureEnd;
	}
	public String getLectureConfirm() {
		return lectureConfirm;
	}
	public void setLectureConfirm(String lectureConfirm) {
		this.lectureConfirm = lectureConfirm;
	}
	public String getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}
	public String getTutName() {
		return tutName;
	}
	public void setTutName(String tutName) {
		this.tutName = tutName;
	}
	
	public String getLectureSeq() {
		return lectureSeq;
	}
	public void setLectureSeq(String lectureSeq) {
		this.lectureSeq = lectureSeq;
	}
}
