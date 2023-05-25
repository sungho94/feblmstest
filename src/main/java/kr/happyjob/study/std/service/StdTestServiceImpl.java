package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.std.dao.LectureListDAO;
import kr.happyjob.study.std.dao.StdTestDao;
import kr.happyjob.study.std.model.LectureListModel;
import kr.happyjob.study.std.model.StdTestModel;

@Service
public class StdTestServiceImpl implements StdTestService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	StdTestDao stdTestDao;
	
	// 수강중인 강의 목록 조회
	@Override
	public List<StdTestModel> testLectureList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return stdTestDao.testLectureList(paramMap);
	}

	// 수강중인 강의 목록 카운트
	@Override
	public int testLectureListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return stdTestDao.testLectureListCnt(paramMap);
	}
	
	// 시험 문제 불러오기
	@Override
	public List<StdTestModel> testQuestion(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return stdTestDao.testQuestion(paramMap);
	}
	
	// 시험 문제 카운트
	@Override
	public int testQuestionCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return stdTestDao.testQuestionCnt(paramMap);
	}
	
	// 시험 문제 저장
	@Override
	public int saveQuestion(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return stdTestDao.saveQuestion(paramMap);
	}
	
	// 학생 시험 유무 업데이트
	@Override
	public int updateStudent(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return stdTestDao.updateStudent(paramMap);
	}


}
