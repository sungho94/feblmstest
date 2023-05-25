package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.tut.dao.TutSurveyDao;
import kr.happyjob.study.tut.model.TutSurveyModel;


@Service
public class TutSurveyServiceImpl implements TutSurveyService {
	
	@Autowired
	TutSurveyDao tutSurveyDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
   
	// Get class name for logger
  	private final String className = this.getClass().toString();
  	
  	//설문 조사 결과
	@Override
	public List<TutSurveyModel> surveyResult(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return tutSurveyDao.surveyResult(paramMap);
	}
	
	// 설문조사 강의 목록 조회
	@Override
	public List<TutSurveyModel> vuesurveyLectureList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return tutSurveyDao.vuesurveyLectureList(paramMap);
	}
	
	// 설문조사 강의 목록 조회수
	@Override
	public int surveyLectureListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return tutSurveyDao.surveyLectureListCnt(paramMap);
	}
	
	// 설문조사 결과
	@Override
	public TutSurveyModel vuesurveyResult(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return tutSurveyDao.vuesurveyResult(paramMap);
	}
	
	

}
