package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.std.model.LectureListModel;

public interface LectureListService {
	
	//강의 목록 조회
	public List<LectureListModel> lectureListSearch(Map<String, Object> paramMap) throws Exception;
	
	//강의 목록 갯수
	public int lectureListCnt(Map<String, Object> paramMap)throws Exception ;

	//list 한건 조회
	public LectureListModel lectureSelect(Map<String, Object> paramMap) throws Exception;
		
	//학생 update
	public int studentInsert(Map<String, Object> paramMap)throws Exception ;
	
	//강의계획 목록 조회
	public List<LectureListModel> lecturePlanSelect(Map<String, Object> paramMap)throws Exception ;
	
	//강의계획 목록 갯수
	   public int lecturePlanCnt(Map<String, Object> paramMap)throws Exception ;
	
}
