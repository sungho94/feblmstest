package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.ResumeModel;

public interface ResumeDao {
	
	//개설 강의 목록 조회
	public List<ResumeModel> resumeLectureListSearch(Map<String, Object> paramMap) throws Exception;
	
	//강의 목록 갯수
	public int resumeLectureListCnt(Map<String, Object> paramMap)throws Exception ;
	
	//학생 목록 조회
	public List<ResumeModel> resumeLectureSelect(Map<String, Object> paramMap) throws Exception;
	
	//학생 목록 갯수
	public int resumeLectureSelectCnt(Map<String, Object> paramMap)throws Exception ;
	
	/** 이력서 다운로드 */
	public ResumeModel userinfo(Map<String, Object> paramMap) throws Exception;
	
}
