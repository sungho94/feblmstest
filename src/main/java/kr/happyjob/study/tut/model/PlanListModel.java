package kr.happyjob.study.tut.model;

public class PlanListModel {
	
	private int planNo;
	private int lectureNo;
	private String loginId;
	private String planWeek;
	private String planStart;
    private String planEnd;
    private String planGoal;
    
	public int getPlanNo() {
		return planNo;
	}
	public String getPlanGoal() {
		return planGoal;
	}
	public void setPlanGoal(String planGoal) {
		this.planGoal = planGoal;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
	}
	public int getLectureNo() {
		return lectureNo;
	}
	public void setLectureNo(int lectureNo) {
		this.lectureNo = lectureNo;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getPlanWeek() {
		return planWeek;
	}
	public void setPlanWeek(String planWeek) {
		this.planWeek = planWeek;
	}
	public String getPlanStart() {
		return planStart;
	}
	public void setPlanStart(String planStart) {
		this.planStart = planStart;
	}
	public String getPlanEnd() {
		return planEnd;
	}
	public void setPlanEnd(String planEnd) {
		this.planEnd = planEnd;
	}
    

}
