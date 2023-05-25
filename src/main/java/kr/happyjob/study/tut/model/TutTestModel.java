package kr.happyjob.study.tut.model;

public class TutTestModel {

	//tb_test 테이블
	private int test_no; //시험-시험번호(PRI)
	private String test_title; // 시험-시험제목
/* 시험날짜에 관련된건 tb_lecture 테이블로 이동*/	
	
	// tb_question 테이블
	
	//test_no 컬럼 있음(PRI)
	private int question_no; //문제-문제번호(PRI)
	private int question_answer;//문제-문제정답
	private String question_ex;//문제-문항
	private String question_one;//문제-1번
	private String question_two;//문제-2번
	private String question_three;//문제-3번
	private String question_four;//문제-4번
	private int question_score; //문제-문제의점수(ex-5점짜리문제)
	
	// tb_result 테이블
	
	//test_no 컬럼 있음(PRI)
	private String lecture_seq; //결과-강의번호(PRI)
	private String loginID; //결과-시험친 학생(PRI)
	//question_no 컬럼 있음
	private int result_answer; // 결과-제출정답
	
	//tb_lecture 테이블 ---- 한개의 강의당 하나의 시험!!!
	private String lecture_start; //강의 시작일
	private String lecture_end;//강의 종료일
	private String test_start;//시험시작일
	private String test_end;//시험종료일
	
	//tb_student
	private String student_test; // 수강생정보테이블에서 '시험여부' 업데이트!!

	//tb_detail_code
	private String lecture_name; //강의명 가져오기
	
	
	public int getTest_no() {
		return test_no;
	}

	public void setTest_no(int test_no) {
		this.test_no = test_no;
	}

	public String getTest_title() {
		return test_title;
	}

	public void setTest_title(String test_title) {
		this.test_title = test_title;
	}

	public int getQuestion_no() {
		return question_no;
	}

	public void setQuestion_no(int question_no) {
		this.question_no = question_no;
	}

	public int getQuestion_answer() {
		return question_answer;
	}

	public void setQuestion_answer(int question_answer) {
		this.question_answer = question_answer;
	}

	public String getQuestion_ex() {
		return question_ex;
	}

	public void setQuestion_ex(String question_ex) {
		this.question_ex = question_ex;
	}

	public String getQuestion_one() {
		return question_one;
	}

	public void setQuestion_one(String question_one) {
		this.question_one = question_one;
	}

	public String getQuestion_two() {
		return question_two;
	}

	public void setQuestion_two(String question_two) {
		this.question_two = question_two;
	}

	public String getQuestion_three() {
		return question_three;
	}

	public void setQuestion_three(String question_three) {
		this.question_three = question_three;
	}

	public String getQuestion_four() {
		return question_four;
	}

	public void setQuestion_four(String question_four) {
		this.question_four = question_four;
	}

	

	public String getLecture_seq() {
		return lecture_seq;
	}

	public void setLecture_seq(String lecture_seq) {
		this.lecture_seq = lecture_seq;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public int getResult_answer() {
		return result_answer;
	}

	public void setResult_answer(int result_answer) {
		this.result_answer = result_answer;
	}

	public String getLecture_start() {
		return lecture_start;
	}

	public void setLecture_start(String lecture_start) {
		this.lecture_start = lecture_start;
	}

	public String getLecture_end() {
		return lecture_end;
	}

	public void setLecture_end(String lecture_end) {
		this.lecture_end = lecture_end;
	}

	public String getTest_start() {
		return test_start;
	}

	public void setTest_start(String test_start) {
		this.test_start = test_start;
	}

	public String getTest_end() {
		return test_end;
	}

	public void setTest_end(String test_end) {
		this.test_end = test_end;
	}

	public String getStudent_test() {
		return student_test;
	}

	public void setStudent_test(String student_test) {
		this.student_test = student_test;
	}

	public String getLecture_name() {
		return lecture_name;
	}

	public void setLecture_name(String lecture_name) {
		this.lecture_name = lecture_name;
	}

	public int getQuestion_score() {
		return question_score;
	}

	public void setQuestion_score(int question_score) {
		this.question_score = question_score;
	}
	
	
	
}
