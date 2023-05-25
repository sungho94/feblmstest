package kr.happyjob.study.std.model;

public class TaskModel {
	
	private int planNo;  //계획번호
	private int taskNo; //과제번호
	private String taskTitle; // 과제명
	private String taskContent; //과제내용
	private String taskStart; //제출일
	private String taskEnd; //마감일
	private String taskName; //파일이름
	private String taskNon; //논리경로
	private String taskMul; //물리경로
	private String lectureSeq; //강의 시퀀스
	private String planWeek;
	private String lecture;
	
	
	public String getPlanWeek() {
		return planWeek;
	}
	public void setPlanWeek(String planWeek) {
		this.planWeek = planWeek;
	}
	public String getLecture() {
		return lecture;
	}
	public void setLecture(String lecture) {
		this.lecture = lecture;
	}
	public int getTaskNo() {
		return taskNo;
	}
	public void setTaskNo(int taskNo) {
		this.taskNo = taskNo;
	}

	public String getLectureSeq() {
		return lectureSeq;
	}
	public void setLectureSeq(String lectureSeq) {
		this.lectureSeq = lectureSeq;
	}
	public int getPlanNo() {
		return planNo;
	}
	public String getTaskName() {
		return taskName;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	public String getTaskNon() {
		return taskNon;
	}
	public void setTaskNon(String taskNon) {
		this.taskNon = taskNon;
	}
	public String getTaskMul() {
		return taskMul;
	}
	public void setTaskMul(String taskMul) {
		this.taskMul = taskMul;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
	}

	public String getTaskTitle() {
		return taskTitle;
	}
	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}
	public String getTaskContent() {
		return taskContent;
	}
	public void setTaskContent(String taskContent) {
		this.taskContent = taskContent;
	}
	public String getTaskStart() {
		return taskStart;
	}
	public void setTaskStart(String taskStart) {
		this.taskStart = taskStart;
	}
	public String getTaskEnd() {
		return taskEnd;
	}
	public void setTaskEnd(String taskEnd) {
		this.taskEnd = taskEnd;
	}
	
	
}
