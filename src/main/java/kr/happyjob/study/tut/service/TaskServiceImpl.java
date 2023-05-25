package kr.happyjob.study.tut.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.system.dao.ComnCodDao;
import kr.happyjob.study.tut.dao.TaskDao;
import kr.happyjob.study.tut.model.LectureModel;
import kr.happyjob.study.tut.model.PlanListModel;
import kr.happyjob.study.tut.model.TaskModel;
import kr.happyjob.study.tut.model.TaskSendModel;

@Service
public class TaskServiceImpl implements TaskService {
	
	@Autowired
	TaskDao  taskDao;
	
	@Autowired
	ComnCodDao comnCodDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Value("${fileUpload.roomimage}")
	private String taskFile;
	
	/* 강의목록 조회*/
	@Override
	public List<LectureModel> lectureList(Map<String, Object> paramMap,  HttpSession session) throws Exception {
		
		List<LectureModel> lectureList = taskDao.lectureList(paramMap);
		
		return lectureList;
	}


	@Override
	public int lectureListCnt(Map<String, Object> paramMap) throws Exception {
		int ListCnt = taskDao.lectureListCnt(paramMap);
		return ListCnt;
	}

	/*과제관리 목록*/
	@Override
	public List<TaskModel> taskList(Map<String, Object> paramMap) throws Exception {
		List<TaskModel> taskList =  taskDao.taskList(paramMap);
		
		return taskList;
	}


	@Override
	public int taskListCnt(Map<String, Object> paramMap) throws Exception {
		int taskListCnt = taskDao.taskListCnt(paramMap);
		return taskListCnt;
	}

	/* 과제관리  상세 조회*/
	@Override
	public TaskModel taskDetail(Map<String, Object> paramMap) throws Exception {
		
		return taskDao.taskDetail(paramMap);
	}



	
	/* 과제 등록 + 파일 */
	@Override
	public int taskInsert(Map<String, Object> paramMap, HttpSession session, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		String taskFilePath = taskFile + File.separator;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, taskFilePath)	;
		Map<String, Object> fileInfo = fileUtil.uploadFiles();
		
		fileInfo.put("file_lloc", virtualRootPath + File.separator + taskFilePath + fileInfo.get("file_nm"));
		
		paramMap.put("fileInfo", fileInfo);
		
		taskDao.taskInsert(paramMap);
	
		return 1;
	}

	
	/* 과제 수정 + 파일*/
	@Override
	public int taskUpdate(Map<String, Object> paramMap, HttpSession session, HttpServletRequest request) throws Exception {
		  
		 MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
			
			String taskFilePath = taskFile + File.separator;
			FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, taskFilePath)	;
			
			Map<String, Object> fileInfo = fileUtil.uploadFiles();

			paramMap.put("planNo",  paramMap.get("planNo"));
			
			TaskModel taskInfo =  taskDao.taskDetail(paramMap); //수정할 과제내용 select
			
			if(taskInfo.getTaskName()!=null){
				//파일이 있으면 삭제하기(물리경로)
				String mul = taskInfo.getTaskMul();
				
				File currentFile = new File(mul);
				currentFile.delete();
			}
			
			if("".equals(fileInfo.get("file_nm")) || fileInfo.get("file_nm") == null){
				fileInfo.put("file_lloc","");  //수정시 파일 값이 없으면 논리 경로 초기화
			}else{
				fileInfo.put("file_lloc", virtualRootPath + File.separator + taskFilePath + fileInfo.get("file_nm"));
			}
			
			paramMap.put("fileInfo", fileInfo);
			
			
		return taskDao.taskUpdate(paramMap);
	}


   /* 강의계획 목록*/
	@Override
	public List<PlanListModel> planList(Map<String, Object> paramMap) throws Exception {
		 List<PlanListModel> planList = taskDao.planList(paramMap);
		return planList;
	}

	@Override
	public int planListCnt(Map<String, Object> paramMap) throws Exception {
		int planListCnt = taskDao.planListCnt(paramMap);
		return planListCnt;
	}

   /* 과제 제출 명단 보기*/
	@Override
	public List<TaskSendModel>tasksendinfo(Map<String, Object> paramMap) throws Exception {
		List<TaskSendModel>tasksendinfo = taskDao.tasksendinfo(paramMap);
		return tasksendinfo;
	}


	@Override
	public int tasksnedtCnt(Map<String, Object> paramMap) throws Exception {
		int tasksnedtCnt = taskDao.tasksnedtCnt(paramMap);
		return tasksnedtCnt;
	}

	/* 과제 제출 상세보기*/
	@Override
	public TaskSendModel taskSendDetail(Map<String, Object> paramMap) throws Exception {
		return taskDao.taskSendDetail(paramMap);
	}


	
	
	

}
