package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import kr.happyjob.study.std.model.CourseInfoModel;
import kr.happyjob.study.std.model.TaskListModel;
import kr.happyjob.study.std.model.TaskModel;
import kr.happyjob.study.std.model.TaskSendModel;


public interface TaskSendService {
	 
	/* 수강내역*/
	public List<CourseInfoModel> lectureList(Map<String, Object> paramMap, HttpSession session) throws Exception;
	
	/* 수강내역 수 */
	public int lectureListCnt(Map<String, Object> paramMap)  throws Exception;

	 /* 주차별 과제 목록 */
	public List<TaskListModel> taskList(Map<String, Object> paramMap)  throws Exception;
	
	 /* 주차별 과제 목록 수*/
	public int taskListCnt(Map<String, Object> paramMap) throws Exception;
	
	/* 과제 내용 조회 */
	public TaskModel taskContent(Map<String, Object> paramMap) throws Exception;
	
	/* 제출한 과제 조회*/
	public TaskSendModel taskSendSelect(Map<String, Object> paramMap) throws Exception;
	
	/* 과제 등록 */
	public int taskInsert(Map<String, Object> paramMap, HttpSession session, HttpServletRequest request)  throws Exception;
	
	/* 과제 수정*/
	public int  taskUpdate(Map<String, Object> paramMap, HttpSession session, HttpServletRequest request)  throws Exception;


	
} 
