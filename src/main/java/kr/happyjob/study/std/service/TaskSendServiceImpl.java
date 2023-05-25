package kr.happyjob.study.std.service;


import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.std.dao.TaskSendDao;
import kr.happyjob.study.std.model.CourseInfoModel;
import kr.happyjob.study.std.model.TaskListModel;
import kr.happyjob.study.std.model.TaskModel;
import kr.happyjob.study.std.model.TaskSendModel;
import kr.happyjob.study.system.dao.ComnCodDao;

@Service
public class TaskSendServiceImpl implements TaskSendService {
	
	@Autowired
	TaskSendDao taskSendDao;

	@Autowired
	ComnCodDao comnCodDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Value("${fileUpload.roomimage}")
	private String taskFile;
	
	/* 수강내역*/
	@Override
	public List<CourseInfoModel> lectureList(Map<String, Object> paramMap, HttpSession session) throws Exception {
		 List<CourseInfoModel> lectureList = taskSendDao.lectureList(paramMap);
		return lectureList;
	}
	
	/* 수강내역 수 */
	@Override
	public int lectureListCnt(Map<String, Object> paramMap) throws Exception {
		 int lectureListCnt = taskSendDao.lectureListCnt(paramMap);
		return lectureListCnt;
	}
	
	/* 과제 목록 */
	@Override
	public List<TaskListModel> taskList(Map<String, Object> paramMap) throws Exception {
		List<TaskListModel> taskList = taskSendDao.taskList(paramMap);
		return taskList;
	}
   
	/* 과제 목록 수 */
	@Override
	public int taskListCnt(Map<String, Object> paramMap) throws Exception {
		 int taskListCnt = taskSendDao.taskListCnt(paramMap);
		return taskListCnt;
	}
	
	/* 과제 내용 조회 */
	@Override
	public TaskModel taskContent(Map<String, Object> paramMap) throws Exception {
		 TaskModel taskContent = taskSendDao.taskContent(paramMap);
		return taskContent;
	}
	
	/* 제출한 과제 조회 */
	@Override
	public TaskSendModel taskSendSelect(Map<String, Object> paramMap) throws Exception {
		
		return taskSendDao.taskSendSelect(paramMap);
	}

	/* 과제 등록 */
	@Override
	public int taskInsert(Map<String, Object> paramMap, HttpSession session, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		String taskFilePath = taskFile + File.separator; // roomimage\
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, taskFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();
		
		//논리경로 저장
		fileInfo.put("file_lloc", virtualRootPath+File.separator +  taskFilePath  + fileInfo.get("file_nm") ); // fil_lloc => \roomimage\파일이름
		
		paramMap.put("fileInfo", fileInfo);
		 taskSendDao.taskInsert(paramMap);
		 
		return 1;
	}

	/* 과제 수정*/
	@Override
	public int taskUpdate(Map<String, Object> paramMap, HttpSession session, HttpServletRequest request) throws Exception {
      
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		String taskFilePath = taskFile + File.separator; // roomimage\
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, taskFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();
		
		paramMap.put("planNo", paramMap.get("planNo"));
		
		TaskSendModel taskSendInfo =  taskSendDao.taskSendSelect(paramMap);
		
		if(taskSendInfo.getSendFile() != null){

			String sendMul = taskSendInfo.getSendMul();
			String fileName = taskSendInfo.getSendFile();
		   File currentFile = new File(sendMul);
		   if(!fileName.equals(fileInfo.get("file_nm"))){
		   currentFile.delete();
		   }
		}
		
		if("".equals(fileInfo.get("file_nm")) || fileInfo.get("file_nm") == null){
			fileInfo.put("file_lloc", "");
		} else{
			fileInfo.put("file_lloc",  virtualRootPath+File.separator +  taskFilePath  + fileInfo.get("file_nm"));
		}
		
		paramMap.put("fileInfo", fileInfo);
		return  taskSendDao.taskUpdate(paramMap);
	}



	

	
	

}
