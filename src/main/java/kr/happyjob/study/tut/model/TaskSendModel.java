package kr.happyjob.study.tut.model;

public class TaskSendModel {
	
	private int taskNo;   //과제번호
	private int sendNo;   //제출번호
	private String loginId;   //사용자Id
	private String stdName;   //학생 이름
	private String sendTitle;   //제목
	private String sendContent;   //내용
	private String sendDate;   //제출일
	private String sendFile;   //파일명
	private String sendNon;   //논리경로
	private String sendMul;   //물리경로
	private int planNo;
	public int getPlanNo() {
		return planNo;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
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
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getStdName() {
		return stdName;
	}
	public void setStdName(String stdName) {
		this.stdName = stdName;
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
