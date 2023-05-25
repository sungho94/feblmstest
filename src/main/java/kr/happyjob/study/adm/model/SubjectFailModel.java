package kr.happyjob.study.adm.model;

public class SubjectFailModel {
	private int lectureSeq;
	private String lectureName;
	private int lectureTotal;
	private String lectureStart;
	private String lectureEnd;
	private String days;	
	private int total;
	private int pass;
	private int fail;
	
	private String startDate;
	private String endDate;
	private String startPage;
	private String endPage;
	
	
	@Override
	public String toString() {
		return "SubjectFailModel [lectureSeq=" + lectureSeq + ", lectureName=" + lectureName + ", lectureTotal="
				+ lectureTotal + ", lectureStart=" + lectureStart + ", lectureEnd=" + lectureEnd + ", days=" + days
				+ ", total=" + total + ", pass=" + pass + ", fail=" + fail + ", startDate=" + startDate + ", endDate="
				+ endDate + ", startPage=" + startPage + ", endPage=" + endPage + "]";
	}
	
	
	
	public int getLectureSeq() {
		return lectureSeq;
	}
	public void setLectureSeq(int lectureSeq) {
		this.lectureSeq = lectureSeq;
	}
	public String getLectureName() {
		return lectureName;
	}
	public void setLectureName(String lectureName) {
		this.lectureName = lectureName;
	}
	public int getLectureTotal() {
		return lectureTotal;
	}
	public void setLectureTotal(int lectureTotal) {
		this.lectureTotal = lectureTotal;
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
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPass() {
		return pass;
	}
	public void setPass(int pass) {
		this.pass = pass;
	}
	public int getFail() {
		return fail;
	}
	public void setFail(int fail) {
		this.fail = fail;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getStartPage() {
		return startPage;
	}
	public void setStartPage(String startPage) {
		this.startPage = startPage;
	}
	public String getEndPage() {
		return endPage;
	}
	public void setEndPage(String endPage) {
		this.endPage = endPage;
	}
	
}
