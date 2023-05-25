package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.tut.dao.LecturePlanListDAO;
import kr.happyjob.study.tut.model.LecturePlanListModel;
import kr.happyjob.study.tut.model.WeekPlanListModel;

@Service
public class LecturePlanListServiceImpl implements LecturePlanListService {
	
	@Autowired
	LecturePlanListDAO lecturePlanListDAO;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
   
	// Get class name for logger
  	private final String className = this.getClass().toString();
   
	//개설 강의 목록 조회
	public List<LecturePlanListModel> lecturePlanListSearch(Map<String, Object> paramMap) throws Exception{
		
		List<LecturePlanListModel> lecturePlanListSearch = lecturePlanListDAO.lecturePlanListSearch(paramMap);
		
		return lecturePlanListSearch;
		
	}
	
	//강의 목록 갯수
	public int lecturePlanListCnt(Map<String, Object> paramMap)throws Exception{
		
		int totalCount = lecturePlanListDAO.lecturePlanListCnt(paramMap);
		
		return totalCount;
		
	}

	//강의 목록 선택
	public LecturePlanListModel LecturePlanSelect(Map<String, Object> paramMap)throws Exception{
		
		return lecturePlanListDAO.LecturePlanSelect(paramMap);
		
	}
	
	//강의 주차별계획 목록
	public List<WeekPlanListModel> weekPlanList(Map<String, Object> paramMap) throws Exception{
		
		List<WeekPlanListModel> weekPlanList = lecturePlanListDAO.weekPlanList(paramMap);
		
		return weekPlanList;
		
	}
	
	//강의 주차별계획 목록 갯수
	public int weekPlanListCnt(Map<String, Object> paramMap)throws Exception{
		
		int totalCount = lecturePlanListDAO.weekPlanListCnt(paramMap);
		
		return totalCount;
		
	}
	
	/** 주차별계획 목록 조회 */
	public WeekPlanListModel weekselect(Map<String, Object> paramMap) throws Exception {
		
		return lecturePlanListDAO.weekselect(paramMap);
	}
	
	//주차별계획 등록
	public int weekinsert(Map<String, Object> paramMap)throws Exception{
		
		return lecturePlanListDAO.weekinsert(paramMap);
		
	}
	
	//주차별계획 수정
	public int weekupdate(Map<String, Object> paramMap)throws Exception{
		
		return lecturePlanListDAO.weekupdate(paramMap);
		
	}
	
	//주차별계획 삭제
	public int weekdelete(Map<String, Object> paramMap)throws Exception{
		
		return lecturePlanListDAO.weekdelete(paramMap);
		
	}
}
