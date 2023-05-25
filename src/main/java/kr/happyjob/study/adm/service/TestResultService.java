package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.TestResultModel;

public interface TestResultService {
	
	//개설 강의 목록 조회
	public List<TestResultModel> testResultLectureList(Map<String, Object> paramMap) throws Exception;
	
	//강의 목록 갯수
	public int testResultLectureListCnt(Map<String, Object> paramMap)throws Exception ;
	
	//학생 목록 조회
	public List<TestResultModel> testResultSelect(Map<String, Object> paramMap) throws Exception;
	
	//학생 목록 갯수
	public int testResultSelectCnt(Map<String, Object> paramMap)throws Exception ;
}
