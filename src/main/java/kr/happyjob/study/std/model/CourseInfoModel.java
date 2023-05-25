package kr.happyjob.study.std.model;

public class CourseInfoModel {
	/* 수강내역 */
	private String loginID;			//사용자ID
	private String lectureName;	//강의명
	private String teacherName;	//강사 이름 
	private String lectureStart; // 시작일
	private String lectureEnd; // 종강일
	private String lectureSeq; // 강의시퀀스
	

	public String getLectureSeq() {
		return lectureSeq;
	}
	public void setLectureSeq(String lectureSeq) {
		this.lectureSeq = lectureSeq;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getLectureName() {
		return lectureName;
	}
	public void setLectureName(String lectureName) {
		this.lectureName = lectureName;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
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
	
	
}
