package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.tut.dao.CounselDAO;
import kr.happyjob.study.tut.model.CounselModel;

@Service
public class CounselServiceImpl implements CounselService {

	@Autowired
	CounselDAO counselDao;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	// 강의 목록 조회
	@Override
	public List<CounselModel> counselLectureList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return counselDao.counselLectureList(paramMap);
	}

	// 강의 목록 조회 카운트
	@Override
	public int counselLectureListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return counselDao.counselLectureListCnt(paramMap);
	}

	// 학생 목록 조회
	@Override
	public List<CounselModel> counselStudentList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return counselDao.counselStudentList(paramMap);
	}

	// 학생 목록 조회 카운트
	@Override
	public int counselStudentListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return counselDao.counselStudentListCnt(paramMap);
	}
	
	// 학생 상담일지 상세보기
	@Override
	public CounselModel detailStudent(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return counselDao.detailStudent(paramMap);
	}

	// 상담 일지 신규 등록
	@Override
	public int insertCounsel(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return counselDao.insertCounsel(paramMap);
	}
	
	// 상담일지 수정
	@Override
	public int updateCounsel(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return counselDao.updateCounsel(paramMap);
	}
	
	// 상담일지 삭제
	@Override
	public int deleteCounsel(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return counselDao.deleteCounsel(paramMap);
	}

}
