package kr.happyjob.study.std.model;

public class TaskSendModel {
	
	private int sendNo;
	private int lectureNo;
    private int taskNo;
	private int planNo;
	private String loginId;
	private String sendTitle;
	private String sendContent;
	private String sendDate;
	private String sendFile;
	private String sendNon;
	private String sendMul;
	private String studentLecture;
	
	
	public String getStudentLecture() {
		return studentLecture;
	}
	public void setStudentLecture(String studentLecture) {
		this.studentLecture = studentLecture;
	}
	public int getTaskNo() {
		return taskNo;
	}
	public void setTaskNo(int taskNo) {
		this.taskNo = taskNo;
	}
	public int getSendNo() {
		return sendNo;
	}
	public void setSendNo(int sendNo) {
		this.sendNo = sendNo;
	}
	public int getLectureNo() {
		return lectureNo;
	}
	public void setLectureNo(int lectureNo) {
		this.lectureNo = lectureNo;
	}
	public int getPlanNo() {
		return planNo;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getSendTitle() {
		return sendTitle;
	}
	public void setSendTitle(String sendTitle) {
		this.sendTitle = sendTitle;
	}
	public String getSendContent() {
		return sendContent;
	}
	public void setSendContent(String sendContent) {
		this.sendContent = sendContent;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getSendFile() {
		return sendFile;
	}
	public void setSendFile(String sendFile) {
		this.sendFile = sendFile;
	}
	public String getSendNon() {
		return sendNon;
	}
	public void setSendNon(String sendNon) {
		this.sendNon = sendNon;
	}
	public String getSendMul() {
		return sendMul;
	}
	public void setSendMul(String sendMul) {
		this.sendMul = sendMul;
	}
	
	
}
