package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.LecturePlanListModel;
import kr.happyjob.study.tut.model.WeekPlanListModel;

public interface LecturePlanListDAO {
	
	//개설 강의 목록 조회
	public List<LecturePlanListModel> lecturePlanListSearch(Map<String, Object> paramMap) throws Exception;
	
	//강의 목록 갯수
	public int lecturePlanListCnt(Map<String, Object> paramMap)throws Exception ;
	
	//강의 목록 선택
	public LecturePlanListModel LecturePlanSelect(Map<String, Object> paramMap)throws Exception ;
	
	//강의 주차별계획 목록
	public List<WeekPlanListModel> weekPlanList(Map<String, Object> paramMap) throws Exception;
	
	//강의 주차별계획 목록 갯수
	public int weekPlanListCnt(Map<String, Object> paramMap)throws Exception ;
	
	// 주차별계획 조회
	public WeekPlanListModel weekselect(Map<String, Object> paramMap) throws Exception;
	
	//주차별계획 등록
	public int weekinsert(Map<String, Object> paramMap)throws Exception ;
	
	//주차별계획 수정
	public int weekupdate(Map<String, Object> paramMap)throws Exception ;
	
	//주차별계획 삭제
	public int weekdelete(Map<String, Object> paramMap)throws Exception ;
}
