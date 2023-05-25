package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.std.dao.RegSubjectDao;
import kr.happyjob.study.std.dao.UserUpdateDao;
import kr.happyjob.study.std.model.RegSubjectModel;
import kr.happyjob.study.std.model.UserUpdateModel;

@Service
public class RegSubjectServiceimpl implements RegSubjectService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	RegSubjectDao regSubjectDao;

	// 수강목록 조회
	@Override
	public List<RegSubjectModel> regSubjectList(Map<String, Object> paramMap) throws Exception {

		return regSubjectDao.regSubjectList(paramMap);
	}

	// 수강목록 카운트
	@Override
	public int regSubjectListCnt(Map<String, Object> paramMap) throws Exception {

		return regSubjectDao.regSubjectListCnt(paramMap);
	}

	// 강의 목표 및 강의 계획서
	@Override
	public List<RegSubjectModel> lecturePlanList(Map<String, Object> paramMap) throws Exception {

		return regSubjectDao.lecturePlanList(paramMap);
	}
	
	// 강의 목표
	/*@Override
	public List<RegSubjectModel> lectureGoalList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return regSubjectDao.lectureGoalList(paramMap);
	}*/

	// 강의 목표 및 강의 계획서 카운트
	@Override
	public int lecturePlanListCnt(Map<String, Object> paramMap) throws Exception {

		return regSubjectDao.lecturePlanListCnt(paramMap);
	}

	// 설문조사 문항 목록 조회
	@Override
	public List<RegSubjectModel> surveyQuestionList(Map<String, Object> paramMap) throws Exception {

		return regSubjectDao.surveyQuestionList(paramMap);
	}

	// 설문조사 저장
	@Override
	public int saveSurvey(Map<String, Object> paramMap) throws Exception {

		return regSubjectDao.saveSurvey(paramMap);
	}
	
	// 설문조사 여부 업데이트
	@Override
	public int updateStudent(Map<String, Object> paramMap) throws Exception {
		
		return regSubjectDao.updateStudent(paramMap);
	}

	

}
