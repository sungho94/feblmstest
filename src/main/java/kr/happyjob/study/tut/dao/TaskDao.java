package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.happyjob.study.tut.model.LectureModel;
import kr.happyjob.study.tut.model.PlanListModel;
import kr.happyjob.study.tut.model.TaskModel;
import kr.happyjob.study.tut.model.TaskSendModel;

public interface TaskDao {
	
	/* 강의 목록 조회*/
	public List<LectureModel> lectureList(Map<String, Object> paramMap) throws Exception;

	public int lectureListCnt(Map<String, Object> paramMap) throws Exception;
	

	/*과제관리 목록*/
	public List<TaskModel> taskList(Map<String, Object> paramMap) throws Exception;

	public int taskListCnt(Map<String, Object> paramMap) throws Exception;
	
	/* 과제 내용 조회*/
	public TaskModel taskDetail(Map<String, Object> paramMap) throws Exception;
	
	/* 과제 제출 명단*/
	public List<TaskSendModel>tasksendinfo(Map<String, Object> paramMap) throws Exception;
	public int tasksnedtCnt(Map<String, Object> paramMap) throws Exception;
	
	
	/* 제출 과제 상세 조회*/
	public TaskSendModel taskSendDetail(Map<String, Object> paramMap)  throws Exception;
	
	/* 과제 신규 등록*/
	public int taskInsert(Map<String, Object> paramMap) throws Exception;
	
	/* 과제 수정*/
	public int taskUpdate(Map<String, Object> paramMap)throws Exception;
	
	/* 강의 계획 목록*/
	public List<PlanListModel> planList(Map<String, Object> paramMap) throws Exception;

	public int planListCnt(Map<String, Object> paramMap) throws Exception;


}
