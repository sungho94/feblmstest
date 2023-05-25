package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.TestResultDao;
import kr.happyjob.study.adm.model.ResumeModel;
import kr.happyjob.study.adm.model.TestResultModel;


@Service
public class TestResultServiceImpl implements TestResultService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	TestResultDao testResultDao;
	
	//개설 강의 목록 조회
	public List<TestResultModel> testResultLectureList(Map<String, Object> paramMap) throws Exception{
		
		List<TestResultModel> testResultLectureList = testResultDao.testResultLectureList(paramMap);
		
		return testResultLectureList;
		
	}
	
	//강의 목록 갯수
	public int testResultLectureListCnt(Map<String, Object> paramMap)throws Exception{
		
		int totalCount = testResultDao.testResultLectureListCnt(paramMap);
		
		return totalCount;
		
	}
	
	//학생 목록 조회
	public List<TestResultModel> testResultSelect(Map<String, Object> paramMap) throws Exception{
		
		List<TestResultModel> testResultSelect = testResultDao.testResultSelect(paramMap);
		
		return testResultSelect;
		
	}
	
	//학생 목록 갯수
	public int testResultSelectCnt(Map<String, Object> paramMap)throws Exception{
		
		int totalCount = testResultDao.testResultSelectCnt(paramMap);
		
		return totalCount;
		
	}
	
}
