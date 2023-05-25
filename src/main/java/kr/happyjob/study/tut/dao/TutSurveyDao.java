package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.TutSurveyModel;

public interface TutSurveyDao {


	// 설문조사 결과
	public List<TutSurveyModel> surveyResult(Map<String, Object> paramMap) throws Exception;
	
	// 설문조사 강의 목록 조회
	public List<TutSurveyModel> vuesurveyLectureList(Map<String, Object> paramMap) throws Exception;

	// 설문조사 강의 목록 조회수
	public int surveyLectureListCnt(Map<String, Object> paramMap) throws Exception;

	// 설문조사 결과
	public TutSurveyModel vuesurveyResult(Map<String, Object> paramMap) throws Exception;
}
