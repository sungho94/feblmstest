package kr.happyjob.study.std.model;

public class TaskListModel {
	
  /* 주차별 과제 목록 */
  private int lecture_seq; //강의 시퀀스
  private int plan_no; //계획서 번호
  private int task_no; //과제번호
  private String plan_week; //주차
  private String lectureName; //강의명
  private String send_no; //과제번호
  private String plan_goal;

  
public String getSend_no() {
	return send_no;
}
public void setSend_no(String send_no) {
	this.send_no = send_no;
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
public String getLectureName() {
	return lectureName;
}
public void setLectureName(String lectureName) {
	this.lectureName = lectureName;
}
public void setPlan_no(int plan_no) {
	this.plan_no = plan_no;
}
public int getTask_no() {
	return task_no;
}
public String getPlan_goal() {
	return plan_goal;
}
public void setPlan_goal(String plan_goal) {
	this.plan_goal = plan_goal;
}

public void setTask_no(int task_no) {
	this.task_no = task_no;
}

public String getPlan_week() {
	return plan_week;
}
public void setPlan_week(String plan_week) {
	this.plan_week = plan_week;
}

}
