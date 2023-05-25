package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.tut.dao.StudentInfoDao;
import kr.happyjob.study.tut.model.StudentInfoModel;

@Service
public class StudentInfoServiceImpl implements StudentInfoService {

	@Autowired 
	StudentInfoDao studentInfoDao;
	@Override
	public List<StudentInfoModel> lectureInfoList(Map<String, Object> paramMap) throws Exception {
					
		return studentInfoDao.lectureInfoList(paramMap);
	}
	@Override
	public StudentInfoModel lectureInfoSearch(Map<String, Object> paramMap) throws Exception {
		
		return studentInfoDao.lectureInfoSearch(paramMap);
	}
	@Override
	public int lectureInfoListCnt(Map<String, Object> paramMap) throws Exception {
		return studentInfoDao.lectureInfoListCnt(paramMap);
	}
	@Override
	public List<StudentInfoModel> studentInfoList(Map<String, Object> paramMap) throws Exception {
		return studentInfoDao.studentInfoList(paramMap);
	}
	@Override
	public int studentInfoListCnt(Map<String, Object> paramMap) throws Exception {
		return studentInfoDao.studentInfoListCnt(paramMap);
	}
	@Override
	public int studentInfoConfirmYes(Map<String, Object> paramMap) throws Exception {
		
		int confirmYes = studentInfoDao.studentInfoConfirmYes(paramMap);
			studentInfoDao.lecturePersonUpdate(paramMap);
		return confirmYes;
	}
	@Override
	public int studentInfoConfirmNo(Map<String, Object> paramMap) throws Exception {
			
		int confirmNo= studentInfoDao.studentInfoConfirmNo(paramMap);
			studentInfoDao.lecturePersonUpdate(paramMap);
		return confirmNo;
	}

}
