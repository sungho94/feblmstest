package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.LectureManagementModel;
import kr.happyjob.study.adm.model.StudentModel;

public interface LectureManagementService {
	
	//강의 목록 조회
	public List<LectureManagementModel> lectureListSearch(Map<String, Object> paramMap) throws Exception;
		
	//강의 목록 갯수
	public int lectureListCnt(Map<String, Object> paramMap)throws Exception ;

	//강의 한건 조회
	public LectureManagementModel lectureSelect(Map<String, Object> paramMap)throws Exception ;
	
	//강의 insert
	public int lectureInsert(Map<String, Object> paramMap)throws Exception ;

	//강의 update
	public int lectureUpdate(Map<String, Object> paramMap)throws Exception ;
	
/*	//강의 delete
	public int lectureDelete(Map<String, Object> paramMap)throws Exception ;*/
	
	// 학생 목록 조회
	public List<StudentModel> studentList(Map<String, Object> paramMap) throws Exception;

	// 학생 목록 조회수
	public int studentListCnt(Map<String, Object> paramMap) throws Exception;
	
	//강의실 사용유무 update
	public int roomStatusUpdate(Map<String, Object> paramMap)throws Exception ;
	
	//강의 tb_detail_code insert
	//public int lectureInsertComnDtlCod(Map<String, Object> paramMap)throws Exception ;
}
