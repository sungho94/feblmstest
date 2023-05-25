package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.StudentInfoModel;

public interface StudentInfoDao {
	
	// 수업 리스트 조회
	public List<StudentInfoModel> lectureInfoList (Map<String, Object> paramMap) throws Exception;
	// 수업 리스트 카운트
	public int lectureInfoListCnt (Map<String, Object> paramMap) throws Exception;
	// 수업 단건 조회
	public StudentInfoModel lectureInfoSearch (Map<String, Object> paramMap) throws Exception;;
	// 수강 학생 리스트 조회
	public List<StudentInfoModel> studentInfoList (Map<String, Object> parmaMap) throws Exception;
	//  수강 학생 리스트 카운트
	public int studentInfoListCnt (Map<String, Object> paramMap) throws Exception;
	
	// 수강학생 수강여부 '승인'
	public int studentInfoConfirmYes (Map<String, Object> paramMap) throws Exception;
	// 수강학생 수강여부 '취소'
	public int studentInfoConfirmNo (Map<String, Object> paramMap) throws Exception;
	// lecture 테이블에 현재인원 업데이트
	public int lecturePersonUpdate (Map<String, Object> paramMap) throws Exception;
}
