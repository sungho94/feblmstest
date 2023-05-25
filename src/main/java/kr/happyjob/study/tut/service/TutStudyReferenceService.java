package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.happyjob.study.tut.model.TutStudyReferenceModel;

public interface TutStudyReferenceService {

	//강의 목록 조회
	public List<TutStudyReferenceModel> LectureList(Map<String, Object> paramMap) throws Exception;
	
	//강의 목록 갯수
	public int LectureListCnt(Map<String, Object> paramMap)throws Exception ;
	
	//학습자료 목록 조회
	public List<TutStudyReferenceModel> referenceselectlist(Map<String, Object> paramMap) throws Exception;
	
	//학습자료 목록 갯수
	public int referenceselectlistCnt(Map<String, Object> paramMap)throws Exception ;
	
	/** 학습자료 조회 */
	public TutStudyReferenceModel referenceselect(Map<String, Object> paramMap) throws Exception;
	
	/** 학습자료 등록 */
	public int referenceinsert(Map<String, Object> paramMap, HttpServletRequest request, HttpSession session) throws Exception;
	
	/** 학습자료 수정 */
	public int referenceupdate(Map<String, Object> paramMap, HttpServletRequest request, HttpSession session) throws Exception;
	
	/** 학습자료 삭제 */
	public int referencedelete(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
}
