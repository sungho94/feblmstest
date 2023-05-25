package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.TeacherListDao;
import kr.happyjob.study.adm.model.TeacherListModel;

@Service
public class TeacherListServiceImpl implements TeacherListService {

	@Autowired
	TeacherListDao  teacherListDao;
	/* 강사 목록 */
	@Override
	public List<TeacherListModel> teacherList(Map<String, Object> paramMap) throws Exception {
		
		List<TeacherListModel> teacherLis = teacherListDao.teacherList(paramMap);
		
	   return teacherLis;
	}
	
	/* 강사 목록 수*/
	@Override
	public int listCnt(Map<String, Object> paramMap) throws Exception {
		
		int listCnt = teacherListDao.listCnt(paramMap);
		
		return listCnt;
	}
	
	/*강사 유저 타입 업데이트*/
	@Override
	public int tutupdate(Map<String, Object> paramMap) throws Exception {
		return teacherListDao.tutupdate(paramMap);
	}
	
	/* 강사 정보 상세보기 */
	@Override
	public TeacherListModel tutInfoDetail(Map<String, Object> paramMap) throws Exception {
		return teacherListDao.tutInfoDetail(paramMap);
	}

}
