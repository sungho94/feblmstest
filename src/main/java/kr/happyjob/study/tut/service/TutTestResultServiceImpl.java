package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.tut.dao.TutTestResultDao;
import kr.happyjob.study.tut.model.TutTestResultModel;


@Service
public class TutTestResultServiceImpl implements TutTestResultService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	TutTestResultDao tutTestResultDao;
	
	//개설 강의 목록 조회
	public List<TutTestResultModel> testResultLectureList(Map<String, Object> paramMap) throws Exception{
		
		List<TutTestResultModel> testResultLectureList = tutTestResultDao.testResultLectureList(paramMap);
		
		return testResultLectureList;
		
	}
	
	//강의 목록 갯수
	public int testResultLectureListCnt(Map<String, Object> paramMap)throws Exception{
		
		int totalCount = tutTestResultDao.testResultLectureListCnt(paramMap);
		
		return totalCount;
		
	}

	@Override
	public List<TutTestResultModel> testStudentSelectList(Map<String, Object> paramMap) throws Exception {
		
		List<TutTestResultModel> testStudentSelectList = tutTestResultDao.testStudentSelectList(paramMap);
		
		return testStudentSelectList;
	}

	@Override
	public int testStudentSelectListCnt(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = tutTestResultDao.testStudentSelectListCnt(paramMap);
		
		return totalCount;
	}
	
}
