package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.SurveyModel;

public interface SurveyDao {

	// 설문조사 강사 목록 조회
	public List<SurveyModel> surveyTeacherList(Map<String, Object> paramMap) throws Exception;

	// 설문조사 강사 목록 조회수
	public int surveyTeacherListCnt(Map<String, Object> paramMap) throws Exception;

	// 설문조사 강의 목록 조회
	public List<SurveyModel> surveyLectureList(Map<String, Object> paramMap) throws Exception;

	// 설문조사 강의 목록 조회수
	public int surveyLectureListCnt(Map<String, Object> paramMap) throws Exception;
	
	// 설문조사 결과
	public SurveyModel surveyResult(Map<String, Object> paramMap) throws Exception;

}
