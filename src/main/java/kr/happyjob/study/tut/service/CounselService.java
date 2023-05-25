package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.CounselModel;

public interface CounselService {

	// 강의 목록 조회
	public List<CounselModel> counselLectureList(Map<String, Object> paramMap) throws Exception;

	// 강의 목록 조회 카운트
	public int counselLectureListCnt(Map<String, Object> paramMap) throws Exception;

	// 학생 목록 조회
	public List<CounselModel> counselStudentList(Map<String, Object> paramMap) throws Exception;

	// 학생 목록 조회 카운트
	public int counselStudentListCnt(Map<String, Object> paramMap) throws Exception;
	
	// 학생 상담일지 상세보기
	public CounselModel detailStudent(Map<String, Object> paramMap) throws Exception;

	// 상담 일지 신규 등록
	public int insertCounsel(Map<String, Object> paramMap) throws Exception;
	
	// 상담 일지 수정
	public int updateCounsel(Map<String, Object> paramMap) throws Exception;
	
	// 상담 일지 삭제
	public int deleteCounsel(Map<String, Object> paramMap) throws Exception;

}
