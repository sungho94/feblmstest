package kr.happyjob.study.tut.model;

public class WeekPlanListModel {
	
	private int lecture_seq;        // 강의 시퀸스
	private int plan_no;            // 계획 번호
	private String plan_week;       // 주차
	private String plan_goal;       // 학습목표
	private String plan_content;    // 학습내용
	private String maxWeek;
	

	
	public String getMaxWeek() {
		return maxWeek;
	}
	public void setMaxWeek(String maxWeek) {
		this.maxWeek = maxWeek;
	}
	public int getLecture_seq() {
		return lecture_seq;
	}
	public void setLecture_seq(int lecture_seq) {
		this.lecture_seq = lecture_seq;
	}
	public int getPlan_no() {
		return plan_no;
	}
	public void setPlan_no(int plan_no) {
		this.plan_no = plan_no;
	}
	public String getPlan_week() {
		return plan_week;
	}
	public void setPlan_week(String plan_week) {
		this.plan_week = plan_week;
	}
	public String getPlan_goal() {
		return plan_goal;
	}
	public void setPlan_goal(String plan_goal) {
		this.plan_goal = plan_goal;
	}
	public String getPlan_content() {
		return plan_content;
	}
	public void setPlan_content(String plan_content) {
		this.plan_content = plan_content;
	}
	
	
	
}
