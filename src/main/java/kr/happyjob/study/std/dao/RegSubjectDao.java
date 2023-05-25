package kr.happyjob.study.std.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.std.model.RegSubjectModel;
import kr.happyjob.study.std.model.UserUpdateModel;

public interface RegSubjectDao {

	// 수강목록 조회
	public List<RegSubjectModel> regSubjectList(Map<String, Object> paramMap) throws Exception;

	// 수강목록 카운트
	public int regSubjectListCnt(Map<String, Object> paramMap) throws Exception;

	// 강의 목표 및 강의 계획서
	public List<RegSubjectModel> lecturePlanList(Map<String, Object> paramMap) throws Exception;
	//public List<RegSubjectModel> lectureGoalList(Map<String, Object> paramMap) throws Exception;

	// 강의 목표 및 강의 계획서 카운트
	public int lecturePlanListCnt(Map<String, Object> paramMap) throws Exception;

	// 설문조사 문항 목록 조회
	public List<RegSubjectModel> surveyQuestionList(Map<String, Object> paramMap) throws Exception;

	// 설문 조사 저장
	public int saveSurvey(Map<String, Object> paramMap) throws Exception;

	// 설문조사 여부 업데이트
	public int updateStudent(Map<String, Object> paramMap) throws Exception;
}
