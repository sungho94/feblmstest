package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.StudentDao;
import kr.happyjob.study.adm.model.StudentModel;

@Service
public class StudentServiceImpl implements StudentService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	StudentDao studentDao;
	
	// 학생관리 강의 목록 조회
	@Override
	public List<StudentModel> lectureList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return studentDao.lectureList(paramMap);
	}
	
	// 학생관리 강의 목록 조회수
	@Override
	public int lectureListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return studentDao.lectureListCnt(paramMap);
	}
	
	// 학생관리 학생 목록 조회
	@Override
	public List<StudentModel> studentList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return studentDao.studentList(paramMap);
	}
	
	// 학생관리 학생 목록 조회수
	@Override
	public int studentListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return studentDao.studentListCnt(paramMap);
	}
	
	// 학생 상세조회
	@Override
	public StudentModel studentSelect(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return studentDao.studentSelect(paramMap);
	}
	
	// 학생 수강 취소
	@Override
	public int studentCancel(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return studentDao.studentCancel(paramMap);
	}
	
	

}
