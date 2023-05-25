package kr.happyjob.study.std.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.std.model.StdStudyReferenceModel;

public interface StdStudyReferenceDAO {
	
	//강의 목록 조회
	public List<StdStudyReferenceModel> LectureList(Map<String, Object> paramMap) throws Exception;
	
	//강의 목록 갯수
	public int LectureListCnt(Map<String, Object> paramMap)throws Exception ;
	
	//학습자료 목록 조회
	public List<StdStudyReferenceModel> referenceselectlist(Map<String, Object> paramMap) throws Exception;
	
	//학습자료 목록 갯수
	public int referenceselectlistCnt(Map<String, Object> paramMap)throws Exception ;
	
	/** 학습자료 조회 */
	public StdStudyReferenceModel referenceselect(Map<String, Object> paramMap) throws Exception;
	
	
}
