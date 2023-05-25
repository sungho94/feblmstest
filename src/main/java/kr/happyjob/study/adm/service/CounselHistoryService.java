package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.CounselHistoryModel;
import kr.happyjob.study.adm.model.LectureModel;

public interface CounselHistoryService {

	/* 강의 목록 */
	public List<LectureModel> counselLectureList(Map<String, Object> paramMap) throws Exception;
	
	/* 강의 목록 수 */
	public int lectureListCnt(Map<String, Object> paramMap) throws Exception;
	
	/* 상담 목록 */
	public List<CounselHistoryModel> counselList(Map<String, Object> paramMap) throws Exception;
	
	/* 상담 목록 수*/
	public int counselCnt(Map<String, Object> paramMap)  throws Exception;

	/* 상담 상세 조회*/
	public CounselHistoryModel counselSelect(Map<String, Object> paramMap)  throws Exception;
	
}
