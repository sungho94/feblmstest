package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.CounselHistoryDao;
import kr.happyjob.study.adm.model.CounselHistoryModel;
import kr.happyjob.study.adm.model.LectureModel;

@Service
public class CounselHistoryServiceIpml implements CounselHistoryService {
	
	@Autowired
	CounselHistoryDao counselHistoryDao;
	
	/* 강의 목록 */
	@Override
	public List<LectureModel> counselLectureList(Map<String, Object> paramMap) throws Exception {
		List<LectureModel> lectureList = counselHistoryDao.counselLectureList(paramMap);
		return lectureList;
	}
	/* 강의 목록 수*/
	@Override
	public int lectureListCnt(Map<String, Object> paramMap) throws Exception {
		int lectureListCnt = counselHistoryDao.lectureListCnt(paramMap);
		return lectureListCnt;
	}
	
	/* 상담 목록 */
	@Override
	public List<CounselHistoryModel> counselList(Map<String, Object> paramMap) throws Exception {
		List<CounselHistoryModel> counselList = counselHistoryDao.counselList(paramMap);
		return counselList;
	}
	/* 상담 목록 수 */
	@Override
	public int counselCnt(Map<String, Object> paramMap) throws Exception {
		int counselCnt = counselHistoryDao.counselCnt(paramMap);
		return counselCnt;
	}
	
	/* 상담 상세 조회*/
	@Override
	public CounselHistoryModel counselSelect(Map<String, Object> paramMap) throws Exception {
		
		return counselHistoryDao.counselSelect(paramMap);
	}
	

	
}
