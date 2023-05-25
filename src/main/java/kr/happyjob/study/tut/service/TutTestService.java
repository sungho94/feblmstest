package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.TutTestModel;

public interface TutTestService {

	//시험리스트
	public List<TutTestModel> testList (Map<String, Object>paramMap) throws Exception;
	//시험갯수
	public int testListCnt (Map<String, Object>paramMap) throws Exception;
	//시험상세조회
	public TutTestModel testDetail (Map<String, Object> paramMap) throws Exception;
	//테스트 상세조회에서 등록된 강의보기
	public Map<String,Object> testDetailSelect (Map<String, Object> paramMap) throws Exception;
	//시험등록
	public int testInsert (Map<String, Object> paramMap) throws Exception;
	//시험수정
	public int testUpdate (Map<String, Object> paramMap) throws Exception;
	//시험삭제
	public int testDelete (Map<String, Object> paramMap) throws Exception;
	
	
	//question 테이블 관련
	//문제리스트
	public List <TutTestModel> questionList (Map<String, Object> paramMap) throws Exception;
	//문제갯수
	public int questionListCnt (Map<String, Object> paramMap) throws Exception;
	//문제상세조회
	public TutTestModel questionDetail (Map<String, Object> paramMap) throws Exception;
	//문제등록
	public int questionInsert (Map<String, Object> paramMap) throws Exception;
	//문제수정
	public int questionUpdate (Map<String, Object> paramMap) throws Exception;
	//문제삭제
	public int questionDelete (Map<String, Object> paramMap) throws Exception;
}
