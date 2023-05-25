package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.TutTestResultModel;

public interface TutTestResultDao {
	
	
	//개설 강의 목록 조회
	public List<TutTestResultModel> testResultLectureList(Map<String, Object> paramMap) throws Exception;
	
	//강의 목록 갯수
	public int testResultLectureListCnt(Map<String, Object> paramMap)throws Exception ;
	
	//학생 목록 조회
	public List<TutTestResultModel> testStudentSelectList(Map<String, Object> paramMap) throws Exception;
	
	//학생 목록 갯수
	public int testStudentSelectListCnt(Map<String, Object> paramMap)throws Exception ;
	
}
