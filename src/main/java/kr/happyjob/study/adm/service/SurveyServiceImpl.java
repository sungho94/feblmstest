package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.SurveyDao;
import kr.happyjob.study.adm.model.SurveyModel;

@Service
public class SurveyServiceImpl implements SurveyService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	SurveyDao surveyDao;
	
	// 설문조사 강사 리스트 조회
	@Override
	public List<SurveyModel> surveyTeacherList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return surveyDao.surveyTeacherList(paramMap);
	}

	// 설문조사 강사 리스트 조회수
	@Override
	public int surveyTeacherListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return surveyDao.surveyTeacherListCnt(paramMap);
	}
	
	// 설문조사 강의 목록 조회
	@Override
	public List<SurveyModel> surveyLectureList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return surveyDao.surveyLectureList(paramMap);
	}
	
	// 설문조사 강의 목록 조회수
	@Override
	public int surveyLectureListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return surveyDao.surveyLectureListCnt(paramMap);
	}
	
	// 설문조사 결과
	@Override
	public SurveyModel surveyResult(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return surveyDao.surveyResult(paramMap);
	}


}
