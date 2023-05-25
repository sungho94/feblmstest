package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.std.model.StdTestModel;

public interface StdTestService {

	// 수강중인 강의 목록 조회
	public List<StdTestModel> testLectureList(Map<String, Object> paramMap) throws Exception;

	// 수강중인 강의 목록 카운트
	public int testLectureListCnt(Map<String, Object> paramMap) throws Exception;

	// 시험 문제 불러오기
	public List<StdTestModel> testQuestion(Map<String, Object> paramMap) throws Exception;

	// 시험 문제 카운트
	public int testQuestionCnt(Map<String, Object> paramMap) throws Exception;

	// 시험 문제 저장
	public int saveQuestion(Map<String, Object> paramMap) throws Exception;

	// 학생 시험 유무 업데이트
	public int updateStudent(Map<String, Object> paramMap) throws Exception;
}
